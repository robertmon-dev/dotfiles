local utils = require("lib.utils")

local env_vars = {
	{ "HYPRCURSOR_THEME", "Main" },
	{ "HYPRCURSOR_SIZE", "24" },
	{ "XCURSOR_THEME", "Main" },
	{ "XCURSOR_SIZE", "24" },
}

hl.config({
	cursor = {
		no_hardware_cursors = false,
		enable_hyprcursor = true,
		sync_gsettings_theme = true,
	},
})

utils.apply_unpack(env_vars, hl.env)
