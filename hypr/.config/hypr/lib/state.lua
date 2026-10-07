local detect = require("lib.detect")

local State = {}
State.__index = State

function State.new()
	local self = setmetatable({}, State)

	self.hostname = detect.hostname()
	self.is_laptop = detect.has_battery()
	self.has_nvidia = detect.has_nvidia()
	self.has_intel = detect.has_intel()

	self.profile = self.is_laptop and "laptop" or "desktop"

	return self
end

function State:cond(on_laptop, on_desktop)
	if self.is_laptop then
		return on_laptop
	end
	return on_desktop
end

function State:get_env()
	local envs = {}

	if self.has_nvidia then
		envs["LIBVA_DRIVER_NAME"] = "nvidia"
		envs["GBM_BACKEND"] = "nvidia-drm"
		envs["__GLX_VENDOR_LIBRARY_NAME"] = "nvidia"
		envs["NVD_BACKEND"] = "direct"
	elseif self.has_intel then
		envs["LIBVA_DRIVER_NAME"] = detect.intel_driver_name()
		envs["VDPAU_DRIVER"] = "va_gl"
	end

	return envs
end

return State.new()
