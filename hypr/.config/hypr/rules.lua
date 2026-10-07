local vars = require("variables")
local utils = require("utils")

utils.apply_each({
	{
		match = { fullscreen = false },
		opacity = vars.window_opacity .. " override",
	},
	{
		match = { class = [[^(foot|equibop|org\.quickshell|imv|swappy)$]] },
		opaque = true,
	},
	{
		match = {
			class = [[^(guifetch|yad|zenity|wev|org\.gnome\.FileRoller|file-roller|blueman-manager|com\.github\.GradienceTeam\.Gradience|feh|imv|system-config-printer|org\.quickshell)$]],
		},
		float = true,
	},
	{
		match = { class = [[^(foot)$]], title = [[^(nmtui)$]] },
		float = true,
		size = "60% 70%",
		center = true,
	},
	{
		match = { class = [[^(org\.gnome\.Settings)$]] },
		float = true,
		size = "70% 80%",
	},
	{
		match = { class = [[^(org\.pulseaudio\.pavucontrol|yad-icon-browser)$]] },
		float = true,
		size = "60% 70%",
	},
	{
		match = { class = [[^(nwg-look)$]] },
		float = true,
		size = "50% 60%",
	},
	{
		match = { class = [[^(btop)$]] },
		workspace = "special:" .. vars.ws_sysmon,
	},
	{
		match = { class = [[^(feishin|Spotify|Supersonic|Cider)$]] },
		workspace = "special:" .. vars.ws_music,
	},
	{
		match = { initial_title = [[^(Spotify( Free)?)$]] },
		workspace = "special:" .. vars.ws_music,
	},
	{
		match = { class = [[^(discord|vesktop|WebCord)$]] },
		workspace = "special:" .. vars.ws_discord,
	},
	{
		match = { title = [[^(Select|Open)( a)? (File|Folder)(s)?$]] },
		float = true,
	},
	{
		match = { title = [[^(File (Operation|Upload)( Progress)?)$]] },
		float = true,
	},
	{
		match = { title = [[^(.* Properties)$]] },
		float = true,
	},
	{
		match = { title = [[^(Save As)$]] },
		float = true,
	},
	{
		match = { title = [[^(Library)$]] },
		float = true,
	},
	{
		match = { title = [[^(Picture([ -])in([ -])[Pp]icture)$]] },
		float = true,
		pin = true,
		keep_aspect_ratio = true,
	},
	{
		match = { class = [[^(steam)$]], title = [[^()$]] },
		rounding = 10,
	},
	{
		match = { class = [[^(steam)$]], title = [[^(Friends List)$]] },
		float = true,
	},
	{
		match = { class = [[^(steam_app_[0-9]+)$]] },
		immediate = true,
		idle_inhibit = "always",
	},
	{
		match = { class = [[^(steam_app_281990)$]] },
		immediate = true,
		idle_inhibit = "always",
		fullscreen = true,
	},
	{
		match = { class = [[^(SQLDeveloper)$]] },
		float = true,
	},
	{
		match = { class = [[^(SQLDeveloper)$]], title = [[^(.*Popup.*)$]] },
		center = true,
		stay_focused = true,
		border_size = 0,
	},
	{
		match = { class = [[^(steam_app_(412020|1449560))$]] },
		fullscreen = true,
		stay_focused = true,
		immediate = true,
	},
	{
		match = { class = [[^(steam_app_553850)$]] },
		fullscreen = true,
		stay_focused = true,
	},
}, hl.window_rule)

utils.apply_each({
	{ workspace = "w[tv1]", gaps_out = vars.single_window_gaps_out },
	{ workspace = "f[1]", gaps_out = vars.single_window_gaps_out },
}, hl.workspace_rule)

utils.apply_each({
	{
		match = { namespace = "fuzzel" },
		blur = true,
		ignore_alpha = 0.5,
	},
	{
		match = { namespace = "waybar" },
		blur = false,
	},
}, hl.layer_rule)
