local detect = require("hardware.detect")

local State = {}
State.__index = State

function State:refresh()
	detect.refresh()

	self.hostname = detect.hostname()
	self.is_laptop = detect.is_laptop()

	self.connected_monitors = detect.connected_monitors()
	self.internal_display = detect.internal_display()

	self.gpus = detect.drm_cards()

	self.has_nvidia = detect.has_nvidia()
	self.has_intel = detect.has_intel()
	self.has_amd = detect.has_amd()

	self.profile = self.is_laptop and "laptop" or "desktop"

	return self
end

function State.new()
	return setmetatable({}, State):refresh()
end

function State:has_monitor(name)
	for _, m in ipairs(self.connected_monitors) do
		if m == name then
			return true
		end
	end
	return false
end

function State:has_internal_monitor()
	return self.internal_display ~= nil
end

function State:get_primary_external()
	for _, m in ipairs(self.connected_monitors) do
		if not m:match("^eDP") then
			return m
		end
	end
	return nil
end

function State:has_external_monitor()
	return self:get_primary_external() ~= nil
end

function State:get_resolution(output_name)
	return detect.monitor_resolution(output_name) or "preferred"
end

function State:get_internal_resolution()
	if not self.internal_display then
		return "preferred"
	end
	return self:get_resolution(self.internal_display)
end

function State:cond(on_laptop, on_desktop)
	if self.is_laptop then
		return on_laptop
	end
	return on_desktop
end

function State:get_aq_drm_devices()
	if #self.gpus < 2 then
		return nil
	end
	local devs = {}
	for _, g in ipairs(self.gpus) do
		table.insert(devs, "/dev/dri/" .. g.card)
	end
	return table.concat(devs, ":")
end

function State:get_env()
	local envs = {}

	if self.has_intel then
		envs["LIBVA_DRIVER_NAME"] = detect.intel_driver_name()
		envs["VDPAU_DRIVER"] = "va_gl"
	elseif self.has_nvidia then
		envs["LIBVA_DRIVER_NAME"] = "nvidia"
		envs["GBM_BACKEND"] = "nvidia-drm"
		envs["__GLX_VENDOR_LIBRARY_NAME"] = "nvidia"
		envs["NVD_BACKEND"] = "direct"
	elseif self.has_amd then
		envs["LIBVA_DRIVER_NAME"] = "radeonsi"
		envs["VDPAU_DRIVER"] = "radeonsi"
	end

	local aq = self:get_aq_drm_devices()
	if aq then
		envs["AQ_DRM_DEVICES"] = aq
	end

	return envs
end

return State.new()
