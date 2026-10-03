function trj --description "Fuzzy find and restore trashed files"
    set -l selected (trash-list | fzf --prompt="Restore from trash: " --height=40% --layout=reverse --border --tac)

    if test -n "$selected"
        set -l file_path (string replace -r '^[0-9-]+\s+[0-9:]+\s+' '' -- $selected)

        if test -n "$file_path"
            set_color cyan
            echo "Restoring: $file_path..."
            set_color normal

            trash-restore "$file_path"
        end
    end
end
