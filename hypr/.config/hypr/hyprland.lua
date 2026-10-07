require("hyprcursor")
require("hyprexpo")

require("monitors")
require("animations")
require("rules")
require("keybinds")
require("window")
require("languages")

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("awww img ~/Pictures/Wallpapers/theme.jpg")
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)
