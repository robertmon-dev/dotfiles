local utils = require("utils")

local modules = {
	"hyprcursor",
	"hyprexpo",
	"monitors",
	"animations",
	"rules",
	"keybinds",
	"window",
	"languages",
	"variables",
	"colors",
}

local autostart_commands = {
	"waybar",
	"awww-daemon",
	"awww img ~/Pictures/Wallpapers/theme.jpg",
	"hyprpm reload -n",
	"wl-paste --type text --watch cliphist store",
	"wl-paste --type image --watch cliphist store",
}

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

hl.on("hyprland.start", function()
	utils.apply_each(autostart_commands, hl.exec_cmd)
end)

utils.apply_each(modules, require)
