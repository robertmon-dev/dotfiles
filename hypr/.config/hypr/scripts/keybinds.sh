#!/bin/bash

hyprctl binds -j | jq -r '
def modname(m):
  m as $m |
  [ {b:1,n:"SHIFT"}, {b:4,n:"CTRL"}, {b:8,n:"ALT"}, {b:64,n:"SUPER"},
    {b:2,n:"CAPS"}, {b:16,n:"MOD2"}, {b:32,n:"MOD3"}, {b:128,n:"MOD5"} ]
  | map(select(($m % (2*.b)) >= .b) | .n)
  | join(" ");

.[] | select(.description != "") |
  "\(modname(.modmask)) + \(.key)\t\(.description)"
' | rofi -dmenu -i -p "Keybinds" -theme-str '
window { width: 1100px; }
listview { columns: 2; lines: 15; }
element-icon { size: 0; }
'
