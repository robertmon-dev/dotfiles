local state = require("lib.state")
local utils = require("lib.utils")

local layout, refresh

if state.is_laptop then
	local internal = state:get_internal_display() or "eDP-1"
	layout = { internal, state:get_primary_external() }
	refresh = ""
else
	layout = { "HDMI-A-1", "DP-1" }
	refresh = "@144"
end

local monitor_rules = {}
local x = 0

for _, output in ipairs(layout) do
	local res = state:get_resolution(output)
	if res then
		table.insert(monitor_rules, {
			output = output,
			mode = res .. refresh,
			position = x .. "x0",
			scale = 1,
		})
		x = x + tonumber(res:match("^(%d+)x"))
	end
end

utils.apply_each(monitor_rules, hl.monitor)
