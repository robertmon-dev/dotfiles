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

function M.has_touchpad()
	local f = io.popen("grep -i -E 'touchpad|synaptics' /proc/bus/input/devices 2>/dev/null", "r")
	if not f then
		return false
	end
	local content = f:read("*a")
	f:close()
	return content and #content > 0
end

return M
