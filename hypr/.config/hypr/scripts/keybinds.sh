#!/bin/bash
grep -E '^(bind|bindm|binde|bindl|bindr)' ~/.config/hypr/conf/keybinds.conf |
  awk -F ' # ' '{printf "%-30s %s\n", $1, $2}' |
  sed 's/^bind[a-z]* = //g' |
  rofi -dmenu -i -p "Keybinds" -theme-str '
window { width: 1100px; }
listview { columns: 2; lines: 15; }
element-icon { size: 0; }
'
