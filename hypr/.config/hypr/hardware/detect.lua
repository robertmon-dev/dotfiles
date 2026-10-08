local M = {}

local DRM = "/sys/class/drm/"

M.VENDOR = { INTEL = "0x8086", AMD = "0x1002", NVIDIA = "0x10de" }

local GPU_RANK = { [M.VENDOR.INTEL] = 1, [M.VENDOR.AMD] = 2, [M.VENDOR.NVIDIA] = 3 }

local PORTABLE_CHASSIS = {
	[8] = true,
	[9] = true,
	[10] = true,
	[11] = true,
	[14] = true,
	[30] = true,
	[31] = true,
	[32] = true,
}

local INTEL_IHD_PATHS = {
	"/usr/lib/dri/iHD_drv_video.so",
	"/usr/lib64/dri/iHD_drv_video.so",
	"/usr/lib/x86_64-linux-gnu/dri/iHD_drv_video.so",
}

local INTEL_GENERATIONS = {
	{ name = "GMA / i9xx / G965", gen = 3, from = 0x2500, to = 0x29FF },
	{ name = "GM965 / GM45", gen = 4, from = 0x2A00, to = 0x2AFF },
	{ name = "G45 / Q45 / G41", gen = 4, from = 0x2E00, to = 0x2EFF },
	{ name = "Pineview", gen = 3, from = 0xA001, to = 0xA011 },
	{ name = "Ironlake", gen = 5, from = 0x0042, to = 0x0046 },
	{ name = "Sandy Bridge", gen = 6, from = 0x0100, to = 0x014F },
	{ name = "Ivy Bridge", gen = 7, from = 0x0150, to = 0x016F },
	{ name = "Bay Trail", gen = 7, from = 0x0F30, to = 0x0F3F },
	{ name = "Haswell", gen = 7.5, from = 0x0400, to = 0x04FF },
	{ name = "Haswell ULT", gen = 7.5, from = 0x0A00, to = 0x0AFF },
	{ name = "Haswell SDV", gen = 7.5, from = 0x0C00, to = 0x0CFF },
	{ name = "Haswell GT3e", gen = 7.5, from = 0x0D00, to = 0x0DFF },
	{ name = "Broadwell", gen = 8, from = 0x1600, to = 0x16FF },
	{ name = "Braswell", gen = 8, from = 0x22B0, to = 0x22BF, ihd = false },
	{ name = "Skylake", gen = 9, from = 0x1900, to = 0x19FF },
	{ name = "Kaby Lake", gen = 9, from = 0x5900, to = 0x59FF },
	{ name = "Apollo Lake", gen = 9, from = 0x5A80, to = 0x5A8F },
	{ name = "Gemini Lake", gen = 9, from = 0x3180, to = 0x318F },
	{ name = "Coffee Lake", gen = 9, from = 0x3E00, to = 0x3EFF },
	{ name = "Comet Lake", gen = 9, from = 0x9B00, to = 0x9BFF },
	{ name = "Ice Lake", gen = 11, from = 0x8A00, to = 0x8AFF },
	{ name = "Elkhart Lake", gen = 11, from = 0x4500, to = 0x45FF },
	{ name = "Jasper Lake", gen = 11, from = 0x4E00, to = 0x4EFF },
	{ name = "Tiger Lake", gen = 12, from = 0x9A00, to = 0x9AFF },
	{ name = "Rocket Lake", gen = 12, from = 0x4C80, to = 0x4C8F },
	{ name = "Alder Lake", gen = 12, from = 0x4600, to = 0x46FF },
	{ name = "Raptor Lake", gen = 12, from = 0xA700, to = 0xA7FF },
	{ name = "Arc Alchemist", gen = 12, from = 0x5690, to = 0x56FF },
	{ name = "Meteor/Arrow Lake", gen = 12, from = 0x7D00, to = 0x7DFF },
	{ name = "Lunar Lake", gen = 20, from = 0x6400, to = 0x64FF },
	{ name = "Battlemage", gen = 20, from = 0xE200, to = 0xE2FF },
}

local function exists(path)
	local f = io.open(path, "r")
	if f then
		f:close()
		return true
	end
	return false
end

local function any_exists(paths)
	for _, path in ipairs(paths) do
		if exists(path) then
			return true
		end
	end
	return false
end

local function read_first_line(path)
	local f = io.open(path, "r")
	if not f then
		return nil
	end
	local line = f:read("l")
	f:close()
	return line and line:match("^%s*(.-)%s*$")
end

local function read_all(path)
	local f = io.open(path, "r")
	if not f then
		return nil
	end
	local content = f:read("a")
	f:close()
	return content
end

local outputs_cache

local function scan_outputs()
	local outputs = {}
	local handle = io.popen("ls -d " .. DRM .. "card*-* 2>/dev/null")
	if not handle then
		return outputs
	end

	for path in handle:lines() do
		local card, name = path:match("(card%d+)%-(.+)$")
		if name and read_first_line(path .. "/status") == "connected" then
			local mode = read_first_line(path .. "/modes")
			table.insert(outputs, {
				card = card,
				name = name,
				internal = name:match("^eDP") ~= nil,
				resolution = mode and mode:match("^%d+x%d+") or nil,
			})
		end
	end
	handle:close()

	table.sort(outputs, function(a, b)
		return a.name < b.name
	end)
	return outputs
end

local function outputs()
	if not outputs_cache then
		outputs_cache = scan_outputs()
	end
	return outputs_cache
end

function M.refresh()
	outputs_cache = nil
end

function M.connected_monitors_with_modes()
	return outputs()
end

function M.connected_monitors()
	local names = {}
	for _, o in ipairs(outputs()) do
		table.insert(names, o.name)
	end
	return names
end

function M.internal_display()
	for _, o in ipairs(outputs()) do
		if o.internal then
			return o.name
		end
	end
	return nil
end

function M.monitor_resolution(output_name)
	for _, o in ipairs(outputs()) do
		if o.name == output_name then
			return o.resolution
		end
	end
	return nil
end

function M.hostname()
	return read_first_line("/etc/hostname") or os.getenv("HOSTNAME") or "unknown"
end

function M.has_battery()
	return any_exists({
		"/sys/class/power_supply/BAT0",
		"/sys/class/power_supply/BAT1",
		"/sys/class/power_supply/BATT",
		"/sys/class/power_supply/BATC",
		"/sys/class/power_supply/CMB0",
	})
end

function M.is_laptop()
	local chassis = tonumber(read_first_line("/sys/class/dmi/id/chassis_type") or "")
	if chassis then
		return PORTABLE_CHASSIS[chassis] == true
	end
	return M.has_battery()
end

function M.has_touchpad()
	local devices = read_all("/proc/bus/input/devices")
	if not devices then
		return false
	end
	devices = devices:lower()
	return devices:find("touchpad", 1, true) ~= nil or devices:find("synaptics", 1, true) ~= nil
end

function M.has_nvidia()
	return exists("/proc/driver/nvidia") or exists("/sys/module/nvidia")
end

function M.has_intel()
	return exists("/sys/module/i915") or exists("/sys/module/xe")
end

function M.has_amd()
	return exists("/sys/module/amdgpu")
end

function M.intel_generation(device_id)
	local id = tonumber(device_id or "")
	if not id then
		return nil
	end
	for _, g in ipairs(INTEL_GENERATIONS) do
		if id >= g.from and id <= g.to then
			return g
		end
	end
	return nil
end

function M.intel_driver_name(device_id)
	local g = M.intel_generation(device_id)
	if g then
		local supported = g.ihd
		if supported == nil then
			supported = g.gen >= 8
		end
		if not supported then
			return "i965"
		end
	end
	return any_exists(INTEL_IHD_PATHS) and "iHD" or "i965"
end

function M.drm_cards()
	local internal_cards = {}
	for _, o in ipairs(outputs()) do
		if o.internal and o.card then
			internal_cards[o.card] = true
		end
	end

	local cards = {}
	local h = io.popen("ls -d " .. DRM .. "card* 2>/dev/null")
	if not h then
		return cards
	end
	for path in h:lines() do
		local card = path:match("(card%d+)$")
		local vendor = card and read_first_line(path .. "/device/vendor")
		if vendor and GPU_RANK[vendor] then
			table.insert(cards, {
				card = card,
				num = tonumber(card:match("%d+")),
				vendor = vendor,
				device = read_first_line(path .. "/device/device"),
				rank = internal_cards[card] and 0 or GPU_RANK[vendor],
			})
		end
	end
	h:close()

	table.sort(cards, function(a, b)
		if a.rank ~= b.rank then
			return a.rank < b.rank
		end
		return a.num < b.num
	end)
	return cards
end

return M
