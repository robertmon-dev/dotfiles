local vars = require("variables")

hl.window_rule({
	match = { fullscreen = false },
	opacity = vars.window_opacity .. " override",
})

hl.window_rule({
	match = { class = [[^(foot|equibop|org\.quickshell|imv|swappy)$]] },
	opaque = true,
})

hl.window_rule({
	match = {
		class = [[^(guifetch|yad|zenity|wev|org\.gnome\.FileRoller|file-roller|blueman-manager|com\.github\.GradienceTeam\.Gradience|feh|imv|system-config-printer|org\.quickshell)$]],
	},
	float = true,
})

hl.window_rule({
	match = { class = [[^(foot)$]], title = [[^(nmtui)$]] },
	float = true,
	size = "60% 70%",
	center = true,
})

hl.window_rule({
	match = { class = [[^(org\.gnome\.Settings)$]] },
	float = true,
	size = "70% 80%",
})

hl.window_rule({
	match = { class = [[^(org\.pulseaudio\.pavucontrol|yad-icon-browser)$]] },
	float = true,
	size = "60% 70%",
})

hl.window_rule({
	match = { class = [[^(nwg-look)$]] },
	float = true,
	size = "50% 60%",
})

hl.window_rule({
	match = { class = [[^(btop)$]] },
	workspace = "special:" .. vars.ws_sysmon,
})

hl.window_rule({
	match = { class = [[^(feishin|Spotify|Supersonic|Cider)$]] },
	workspace = "special:" .. vars.ws_music,
})

hl.window_rule({
	match = { initial_title = [[^(Spotify( Free)?)$]] },
	workspace = "special:" .. vars.ws_music,
})

hl.window_rule({
	match = { class = [[^(discord|vesktop|WebCord)$]] },
	workspace = "special:" .. vars.ws_discord,
})

hl.window_rule({
	match = { title = [[^(Select|Open)( a)? (File|Folder)(s)?$]] },
	float = true,
})

hl.window_rule({
	match = { title = [[^(File (Operation|Upload)( Progress)?)$]] },
	float = true,
})

hl.window_rule({
	match = { title = [[^(.* Properties)$]] },
	float = true,
})

hl.window_rule({
	match = { title = [[^(Save As)$]] },
	float = true,
})

hl.window_rule({
	match = { title = [[^(Library)$]] },
	float = true,
})

hl.window_rule({
	match = { title = [[^(Picture([ -])in([ -])[Pp]icture)$]] },
	float = true,
	pin = true,
	keep_aspect_ratio = true,
})

hl.window_rule({
	match = { class = [[^(steam)$]], title = [[^()$]] },
	rounding = 10,
})

hl.window_rule({
	match = { class = [[^(steam)$]], title = [[^(Friends List)$]] },
	float = true,
})

hl.window_rule({
	match = { class = [[^(steam_app_[0-9]+)$]] },
	immediate = true,
	idle_inhibit = "always",
})

hl.workspace_rule({ workspace = "w[tv1]", gaps_out = vars.single_window_gaps_out })
hl.workspace_rule({ workspace = "f[1]", gaps_out = vars.single_window_gaps_out })

hl.layer_rule({
	match = { namespace = "fuzzel" },
	blur = true,
	ignore_alpha = 0.5,
})

hl.layer_rule({
	match = { namespace = "waybar" },
	blur = false,
})

hl.window_rule({
	match = { class = [[^(steam_app_281990)$]] },
	immediate = true,
	idle_inhibit = "always",
	fullscreen = true,
})

hl.window_rule({
	match = { class = [[^(SQLDeveloper)$]] },
	float = true,
})

hl.window_rule({
	match = { class = [[^(SQLDeveloper)$]], title = [[^(.*Popup.*)$]] },
	center = true,
	stay_focused = true,
	border_size = 0,
})

hl.window_rule({
	match = { class = [[^(steam_app_(412020|1449560))$]] },
	fullscreen = true,
	stay_focused = true,
	immediate = true,
})

hl.window_rule({
	match = { class = [[^(steam_app_553850)$]] },
	fullscreen = true,
	stay_focused = true,
})
