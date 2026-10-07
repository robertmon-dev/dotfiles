local utils = require("utils")

hl.config({
	animations = { enabled = true },
})

utils.apply_unpack({
	{ "specialWorkSwitch", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } } },
	{ "emphasizedAccel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } } },
	{ "emphasizedDecel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } } },
	{ "standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } } },
}, hl.curve)

utils.apply_each({
	{ leaf = "layersIn", enabled = true, speed = 5, bezier = "emphasizedDecel", style = "slide" },
	{ leaf = "layersOut", enabled = true, speed = 4, bezier = "emphasizedAccel", style = "slide" },
	{ leaf = "fadeLayers", enabled = true, speed = 5, bezier = "standard" },

	{ leaf = "windowsIn", enabled = true, speed = 5, bezier = "emphasizedDecel" },
	{ leaf = "windowsOut", enabled = true, speed = 3, bezier = "emphasizedAccel" },
	{ leaf = "windowsMove", enabled = true, speed = 6, bezier = "standard" },

	{ leaf = "workspaces", enabled = true, speed = 5, bezier = "standard" },

	{ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "specialWorkSwitch", style = "slidefadevert 15%" },

	{ leaf = "fade", enabled = true, speed = 6, bezier = "standard" },
	{ leaf = "fadeDim", enabled = true, speed = 6, bezier = "standard" },
	{ leaf = "border", enabled = true, speed = 6, bezier = "standard" },
}, hl.animation)
