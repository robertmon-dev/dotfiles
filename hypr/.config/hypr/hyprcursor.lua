-- hyprcursor.lua
-- Replaces hyprcursor.conf.

hl.env("HYPRCURSOR_THEME", "Main")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("XCURSOR_THEME", "Main")
hl.env("XCURSOR_SIZE", "24")

hl.config({
  cursor = {
    no_hardware_cursors = false,
    enable_hyprcursor = true,
    sync_gsettings_theme = true,
  },
})
