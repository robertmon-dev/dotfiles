local vars = require("variables")
local dsp = hl.dsp

hl.bind(vars.kb_launcher, dsp.exec_cmd("rofi -show drun"), { release = true, description = "Open app launcher" })

hl.bind(
	"SUPER + V",
	dsp.exec_cmd("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"),
	{ description = "Open clipboard history" }
)
hl.bind(
	"SUPER + D",
	dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
	{ description = "Toggle fullscreen" }
)
hl.bind("SUPER + P", dsp.window.pin({ action = "toggle" }), { description = "Pin window on top" })
hl.bind("SUPER + left", dsp.focus({ direction = "left" }), { description = "Focus left" })
hl.bind("SUPER + right", dsp.focus({ direction = "right" }), { description = "Focus right" })
hl.bind("SUPER + up", dsp.focus({ direction = "up" }), { description = "Focus up" })
hl.bind("SUPER + down", dsp.focus({ direction = "down" }), { description = "Focus down" })

hl.bind("SUPER + mouse:272", dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind("SUPER + mouse:273", dsp.window.resize(), { mouse = true, description = "Resize window" })

for i = 1, 10 do
	local key = i % 10
	hl.bind("SUPER + " .. key, dsp.focus({ workspace = tostring(i) }), { description = "Switch to workspace " .. i })
	hl.bind(
		"SUPER ALT + " .. key,
		dsp.window.move({ workspace = tostring(i), follow = true }),
		{ description = "Move window to workspace " .. i }
	)
end

hl.bind("SUPER + mouse_down", dsp.focus({ workspace = "e-1" }), { description = "Previous workspace (scroll)" })
hl.bind("SUPER + mouse_up", dsp.focus({ workspace = "e+1" }), { description = "Next workspace (scroll)" })

hl.bind("SUPER + M", dsp.workspace.toggle_special(vars.ws_discord), { description = "Toggle Discord scratchpad" })
hl.bind("SUPER + B", dsp.workspace.toggle_special(vars.ws_sysmon), { description = "Toggle system monitor scratchpad" })

hl.bind(
	"SUPER SHIFT + M",
	dsp.window.move({ workspace = "special:" .. vars.ws_discord, follow = false }),
	{ description = "Send window to Discord scratchpad" }
)
hl.bind(
	"SUPER SHIFT + B",
	dsp.window.move({ workspace = "special:" .. vars.ws_sysmon, follow = false }),
	{ description = "Send window to system monitor scratchpad" }
)
hl.bind(
	"SUPER SHIFT + Return",
	dsp.window.move({ workspace = "e+0", follow = true }),
	{ description = "Move window to next empty workspace" }
)

hl.bind("SUPER + Page_Up", dsp.focus({ workspace = "e-1" }), { repeating = true, description = "Previous workspace" })
hl.bind("SUPER + Page_Down", dsp.focus({ workspace = "e+1" }), { repeating = true, description = "Next workspace" })
hl.bind("SUPER CTRL + left", dsp.focus({ workspace = "e-1" }), { repeating = true, description = "Previous workspace" })
hl.bind("SUPER CTRL + right", dsp.focus({ workspace = "e+1" }), { repeating = true, description = "Next workspace" })
hl.bind("SUPER CTRL + up", dsp.focus({ workspace = "e+1" }), { repeating = true, description = "Next workspace" })
hl.bind("SUPER CTRL + down", dsp.focus({ workspace = "e-1" }), { repeating = true, description = "Previous workspace" })

hl.bind(
	"XF86AudioMute",
	dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, description = "Toggle mute" }
)
hl.bind(
	"XF86AudioRaiseVolume",
	dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ " .. vars.volume_step .. "%+"),
	{ locked = true, repeating = true, description = "Volume up" }
)
hl.bind(
	"XF86AudioLowerVolume",
	dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. vars.volume_step .. "%-"),
	{ locked = true, repeating = true, description = "Volume down" }
)
hl.bind(
	"XF86MonBrightnessUp",
	dsp.exec_cmd("brightnessctl set " .. vars.brightness_step .. "%+"),
	{ locked = true, description = "Brightness up" }
)
hl.bind(
	"XF86MonBrightnessDown",
	dsp.exec_cmd("brightnessctl set " .. vars.brightness_step .. "%-"),
	{ locked = true, description = "Brightness down" }
)

hl.bind(
	"Print",
	dsp.exec_cmd([[grim ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png]]),
	{ locked = true, description = "Screenshot fullscreen" }
)
hl.bind(
	"SUPER SHIFT + S",
	dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]),
	{ description = "Screenshot selection" }
)
hl.bind("SUPER + O", dsp.exec_cmd("grimblast copy area"), { description = "Screenshot without edition" })

hl.bind(
	"SUPER ALT + R",
	dsp.exec_cmd(
		[[pkill -SIGINT wf-recorder || wf-recorder -g "$(slurp)" -f ~/Videos/Record_$(date +'%Y-%m-%d_%H-%M-%S').mp4]]
	),
	{ description = "Record screen (selection)" }
)
hl.bind(
	"SUPER SHIFT + R",
	dsp.exec_cmd([[pkill -SIGINT wf-recorder || wf-recorder -f ~/Videos/Record_$(date +'%Y-%m-%d_%H-%M-%S').mp4]]),
	{ description = "Record full screen" }
)

hl.bind(vars.kb_terminal, dsp.exec_cmd(vars.terminal), { description = "Open terminal (SUPER + T)" })
hl.bind(vars.kb_browser, dsp.exec_cmd(vars.browser), { description = "Open browser (SUPER + B)" })
hl.bind(
	vars.kb_file_explorer,
	dsp.exec_cmd(vars.terminal .. " -e " .. vars.file_explorer),
	{ description = "Open file explorer (SUPER + F)" }
)
hl.bind(
	vars.kb_editor,
	dsp.exec_cmd(vars.terminal .. " -e " .. vars.editor),
	{ description = "Open editor (SUPER + E)" }
)

hl.bind(vars.kb_close_window, dsp.window.close(), { description = "Close window (SUPER + Q)" })
hl.bind("SUPER + L", dsp.exec_cmd("hyprlock"), { description = "Lock the screen" })

hl.bind("SUPER + H", dsp.exec_cmd("~/.config/hypr/scripts/keybinds.sh"), { description = "Show keybinds cheat-sheet" })
hl.bind("SUPER + W", dsp.exec_cmd(vars.browser), { description = "Open browser" })
