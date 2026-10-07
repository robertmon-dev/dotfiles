local M = {}

local function exists(path)
	local f = io.open(path, "r")
	if f ~= nil then
		io.close(f)
		return true
	end
	return false
end

local function read_first_line(path)
	local f = io.open(path, "r")
	if not f then
		return nil
	end
	local line = f:read("*l")
	f:close()
	return line and line:match("^%s*(.-)%s*$")
end

function M.hostname()
	local h = read_first_line("/etc/hostname")
	return h or os.getenv("HOSTNAME") or "unknown"
end

function M.has_battery()
	local bat0 = exists("/sys/class/power_supply/BAT0")
	local bat1 = exists("/sys/class/power_supply/BAT1")
	return bat0 or bat1
end

function M.has_nvidia()
	return exists("/proc/driver/nvidia") or exists("/sys/module/nvidia")
end

function M.has_intel()
	return exists("/sys/module/i915") or exists("/sys/module/xe")
end

function M.intel_driver_name()
	if exists("/usr/lib/dri/iHD_drv_video.so") then
		return "iHD"
	end
	return "i965"
end

function M.has_touchpad()
	local f = io.popen("grep -i -E 'touchpad|synaptics' /proc/bus/input/devices 2>/dev/null", "r")
	if not f then
		return false
	end
	local content = f:read("*a")
	f:close()
	return content and #content > 0
end

function M.connected_monitors()
	local monitors = {}
	local handle = io.popen("find /sys/class/drm/ -maxdepth 1 -name 'card*-*' 2>/dev/null")
	if not handle then
		return monitors
	end

	for path in handle:lines() do
		local status_file = path .. "/status"
		local f = io.open(status_file, "r")
		if f then
			local status = f:read("*l")
			f:close()
			if status and status:match("^connected$") then
				local name = path:match("card%d+%-(.+)%s*$")
				if name then
					table.insert(monitors, name)
				end
			end
		end
	end
	handle:close()
	table.sort(monitors)
	return monitors
end

function M.internal_display()
	local handle = io.popen("find /sys/class/drm/ -maxdepth 1 -name 'card*-eDP-*' 2>/dev/null")
	if not handle then
		return nil
	end

	for path in handle:lines() do
		local status_file = path .. "/status"
		local f = io.open(status_file, "r")
		if f then
			local status = f:read("*l")
			f:close()
			if status and status:match("^connected$") then
				local name = path:match("card%d+%-(eDP%-%d+)%s*$")
				if name then
					handle:close()
					return name
				end
			end
		end
	end
	handle:close()
	return nil
end

function M.monitor_resolution(output_name)
	if not output_name then
		return nil
	end

	local handle = io.popen("find /sys/class/drm/ -maxdepth 1 -name 'card*-" .. output_name .. "' 2>/dev/null")
	if not handle then
		return nil
	end

	local path = handle:read("*l")
	handle:close()

	if not path then
		return nil
	end

	local modes_file = path .. "/modes"
	local f = io.open(modes_file, "r")
	if f then
		local mode = f:read("*l")
		f:close()
		if mode and mode:match("^%d+x%d+") then
			return mode
		end
	end

	return nil
end

function M.connected_monitors_with_modes()
	local monitors = {}
	local handle = io.popen("find /sys/class/drm/ -maxdepth 1 -name 'card*-*' 2>/dev/null")
	if not handle then
		return monitors
	end

	for path in handle:lines() do
		local status_file = path .. "/status"
		local f = io.open(status_file, "r")
		if f then
			local status = f:read("*l")
			f:close()
			if status and status:match("^connected$") then
				local name = path:match("card%d+%-(.+)%s*$")
				if name then
					local modes_file = path .. "/modes"
					local mf = io.open(modes_file, "r")
					local mode = mf and mf:read("*l") or "preferred"
					if mf then
						mf:close()
					end

					table.insert(monitors, {
						name = name,
						resolution = (mode and mode:match("^%d+x%d+")) or "preferred",
					})
				end
			end
		end
	end
	handle:close()
	return monitors
end

return M
