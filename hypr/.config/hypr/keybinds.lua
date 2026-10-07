local vars = require("variables")
local utils = require("utils")
local dsp = hl.dsp

local default_opts = {}

local binds = {
	{ vars.kb_launcher, dsp.exec_cmd("rofi -show drun"), { release = true, description = "Open app launcher" } },

	{
		"SUPER + V",
		dsp.exec_cmd("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"),
		{ description = "Open clipboard history" },
	},
	{
		"SUPER + D",
		dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
		{ description = "Toggle fullscreen" },
	},
	{ "SUPER + P", dsp.window.pin({ action = "toggle" }), { description = "Pin window on top" } },
	{ "SUPER + left", dsp.focus({ direction = "left" }), { description = "Focus left" } },
	{ "SUPER + right", dsp.focus({ direction = "right" }), { description = "Focus right" } },
	{ "SUPER + up", dsp.focus({ direction = "up" }), { description = "Focus up" } },
	{ "SUPER + down", dsp.focus({ direction = "down" }), { description = "Focus down" } },

	{ "SUPER + mouse:272", dsp.window.drag(), { drag = true, description = "Move window" } },
	{ "SUPER + mouse:273", dsp.window.resize(), { drag = true, description = "Resize window" } },

	{ "SUPER + mouse_down", dsp.focus({ workspace = "e-1" }), { description = "Previous workspace (scroll)" } },
	{ "SUPER + mouse_up", dsp.focus({ workspace = "e+1" }), { description = "Next workspace (scroll)" } },

	{ "SUPER + M", dsp.workspace.toggle_special(vars.ws_discord), { description = "Toggle Discord scratchpad" } },
	{
		"SUPER + B",
		dsp.workspace.toggle_special(vars.ws_sysmon),
		{ description = "Toggle system monitor scratchpad" },
	},

	{
		"SUPER SHIFT + M",
		dsp.window.move({ workspace = "special:" .. vars.ws_discord, follow = false }),
		{ description = "Send window to Discord scratchpad" },
	},
	{
		"SUPER SHIFT + B",
		dsp.window.move({ workspace = "special:" .. vars.ws_sysmon, follow = false }),
		{ description = "Send window to system monitor scratchpad" },
	},
	{
		"SUPER SHIFT + Return",
		dsp.window.move({ workspace = "e+0", follow = true }),
		{ description = "Move window to next empty workspace" },
	},

	{ "SUPER + Page_Up", dsp.focus({ workspace = "e-1" }), { repeating = true, description = "Previous workspace" } },
	{ "SUPER + Page_Down", dsp.focus({ workspace = "e+1" }), { repeating = true, description = "Next workspace" } },
	{
		"SUPER CTRL + left",
		dsp.focus({ workspace = "e-1" }),
		{ repeating = true, description = "Previous workspace" },
	},
	{ "SUPER CTRL + right", dsp.focus({ workspace = "e+1" }), { repeating = true, description = "Next workspace" } },
	{ "SUPER CTRL + up", dsp.focus({ workspace = "e+1" }), { repeating = true, description = "Next workspace" } },
	{
		"SUPER CTRL + down",
		dsp.focus({ workspace = "e-1" }),
		{ repeating = true, description = "Previous workspace" },
	},

	{
		"XF86AudioMute",
		dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
		{ locked = true, description = "Toggle mute" },
	},
	{
		"XF86AudioRaiseVolume",
		dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ " .. vars.volume_step .. "%+"),
		{ locked = true, repeating = true, description = "Volume up" },
	},
	{
		"XF86AudioLowerVolume",
		dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. vars.volume_step .. "%-"),
		{ locked = true, repeating = true, description = "Volume down" },
	},
	{
		"XF86MonBrightnessUp",
		dsp.exec_cmd("brightnessctl set " .. vars.brightness_step .. "%+"),
		{ locked = true, description = "Brightness up" },
	},
	{
		"XF86MonBrightnessDown",
		dsp.exec_cmd("brightnessctl set " .. vars.brightness_step .. "%-"),
		{ locked = true, description = "Brightness down" },
	},

	{
		"Print",
		dsp.exec_cmd([[grim ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png]]),
		{ locked = true, description = "Screenshot fullscreen" },
	},
	{
		"SUPER SHIFT + S",
		dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]),
		{ description = "Screenshot selection" },
	},
	{ "SUPER + O", dsp.exec_cmd("grimblast copy area"), { description = "Screenshot without edition" } },

	{
		"SUPER ALT + R",
		dsp.exec_cmd(
			[[pkill -SIGINT wf-recorder || wf-recorder -g "$(slurp)" -f ~/Videos/Record_$(date +'%Y-%m-%d_%H-%M-%S').mp4]]
		),
		{ description = "Record screen (selection)" },
	},
	{
		"SUPER SHIFT + R",
		dsp.exec_cmd([[pkill -SIGINT wf-recorder || wf-recorder -f ~/Videos/Record_$(date +'%Y-%m-%d_%H-%M-%S').mp4]]),
		{ description = "Record full screen" },
	},

	{ vars.kb_terminal, dsp.exec_cmd(vars.terminal), { description = "Open terminal (SUPER + T)" } },
	{ vars.kb_browser, dsp.exec_cmd(vars.browser), { description = "Open browser (SUPER + B)" } },
	{
		vars.kb_file_explorer,
		dsp.exec_cmd(vars.terminal .. " -e " .. vars.file_explorer),
		{ description = "Open file explorer (SUPER + F)" },
	},
	{
		vars.kb_editor,
		dsp.exec_cmd(vars.terminal .. " -e " .. vars.editor),
		{ description = "Open editor (SUPER + E)" },
	},

	{ vars.kb_close_window, dsp.window.close(), { description = "Close window (SUPER + Q)" } },
	{ "SUPER + L", dsp.exec_cmd("hyprlock"), { description = "Lock the screen" } },

	{ "SUPER + H", dsp.exec_cmd("~/.config/hypr/scripts/keybinds.sh"), { description = "Show keybinds cheat-sheet" } },
	{ "SUPER + W", dsp.exec_cmd(vars.browser), { description = "Open browser" } },
}

for i = 1, 10 do
	local key = i % 10
	table.insert(
		binds,
		{ "SUPER + " .. key, dsp.focus({ workspace = tostring(i) }), { description = "Switch to workspace " .. i } }
	)
	table.insert(binds, {
		"SUPER ALT + " .. key,
		dsp.window.move({ workspace = tostring(i), follow = true }),
		{ description = "Move window to workspace " .. i },
	})
end

utils.apply_binds(binds, default_opts, hl.bind)
