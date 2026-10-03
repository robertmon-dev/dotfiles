function fish_greeting
    echo -ne '\x1b[38;5;16m'

    fastfetch --key-padding-left 5

    set_color normal
end
