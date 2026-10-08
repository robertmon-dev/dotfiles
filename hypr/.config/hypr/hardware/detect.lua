local M = {}

local DRM = "/sys/class/drm/"

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
		local name = path:match("card%d+%-(.+)$")
		if name and read_first_line(path .. "/status") == "connected" then
			local mode = read_first_line(path .. "/modes")
			table.insert(outputs, {
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

function M.intel_driver_name()
	return any_exists(INTEL_IHD_PATHS) and "iHD" or "i965"
end

return M
