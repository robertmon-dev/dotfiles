-- variables.lua
-- Replaces variables.conf. Returned as a table so other files can
-- `local vars = require("variables")` and read fields off it.

return {
  font = "JetBrains Mono Nerd Font",

  terminal = "kitty",
  browser = "zen-browser",
  editor = "nvim",
  file_explorer = "yazi",

  kb_close_window = "SUPER + Q",
  kb_terminal = "SUPER + T",
  kb_browser = "SUPER + B",
  kb_editor = "SUPER + E",
  kb_file_explorer = "SUPER + F",
  kb_launcher = "SUPER + Super_L",

  volume_step = 5,
  brightness_step = 5,

  window_opacity = 0.95,
  single_window_gaps_out = 20,

  ws_discord = "communication",
  ws_music = "music",
  ws_sysmon = "sysmon",
}
