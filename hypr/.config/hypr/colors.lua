-- colors.lua
-- Replaces colors.conf. Returned as a table; consumed via
-- `local colors = require("colors")` from window.lua.
--
-- NOTE: hyprlock.conf also used to source the old hyprlang colors.conf
-- for $bg_night and $lavender. Those two values are inlined directly
-- into hyprlock.conf in Task 3 below, so hyprlock no longer depends on
-- this file (hyprlock does not support Lua config and stays on .conf
-- permanently -- see the design doc).

local blue = "rgb(7aa2f7)"
local purple = "rgb(bb9af7)"

return {
  bg_night = "rgb(1a1b26)",
  bg_storm = "rgb(24283b)",
  blue = blue,
  purple = purple,
  cyan = "rgb(73daca)",
  red = "rgb(f7768e)",
  slate = "rgb(565f89)",

  orange = "rgb(ff9e64)",
  yellow = "rgb(e0af68)",
  beige = "rgb(cfc9c2)",
  green = "rgb(9ece6a)",
  teal = "rgb(73daca)",
  cyan_pale = "rgb(b4f9f8)",
  cyan_bright = "rgb(2ac3de)",
  cyan_dim = "rgb(41a6b5)",
  blue_sky = "rgb(7dcfff)",
  lavender = "rgb(c0caf5)",
  grey_blue = "rgb(a9b1d6)",
  grey_muted = "rgb(9aa5ce)",
  storm = "rgb(414868)",
  operator = "rgb(89ddff)",
  punctuation = "rgb(9abdf5)",
  doc = "rgb(6f7bb0)",

  active_border = { colors = { blue, purple }, angle = 45 },
  inactive_border = "rgba(565f8966)",
}
