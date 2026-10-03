function pj --description "Fuzzy find project and open in nvim"
    set target_dir (fd -t d -d 4 . ~/Documents/ | fzf --prompt="Choose project: " --height=40% --layout=reverse --border)

    if test -n "$target_dir"
        cd $target_dir
    end
end
