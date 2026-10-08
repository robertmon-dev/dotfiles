local detect = require("hardware.detect")
local utils = require("lib.utils")

local M = {}

local ORDER = { "HDMI-A-1", "DP-1" }
local REFRESH = {
	["HDMI-A-1"] = 144,
	["DP-1"] = 144,
}

local function rank(output)
	if output.internal then
		return 0
	end
	for i, name in ipairs(ORDER) do
		if name == output.name then
			return i
		end
	end
	return #ORDER + 1
end

local function sorted_outputs()
	local outputs = {}
	for _, o in ipairs(detect.connected_monitors_with_modes()) do
		table.insert(outputs, o)
	end
	table.sort(outputs, function(a, b)
		local ra, rb = rank(a), rank(b)
		if ra ~= rb then
			return ra < rb
		end
		return a.name < b.name
	end)
	return outputs
end

function M.rules()
	local rules = {}
	local x = 0

	for _, o in ipairs(sorted_outputs()) do
		local width = o.resolution and tonumber(o.resolution:match("^(%d+)x"))
		local hz = REFRESH[o.name]

		local mode = "preferred"
		if o.resolution then
			mode = hz and (o.resolution .. "@" .. hz) or o.resolution
		end

		table.insert(rules, {
			output = o.name,
			mode = mode,
			position = x and (x .. "x0") or "auto",
			scale = 1,
		})

		x = (x and width) and (x + width) or nil
	end

	return rules
end

function M.apply()
	utils.apply_each(M.rules(), hl.monitor)
end

M.apply()

return M
