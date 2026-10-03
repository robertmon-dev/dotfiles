fish_add_path ~/.local/bin

if status is-interactive
    set CACHE_DIR ~/.cache/fish_init

    fish_vi_key_bindings

    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual block

    if not test -d "$CACHE_DIR"
        mkdir -p "$CACHE_DIR"
        command -v starship &>/dev/null && starship init fish >"$CACHE_DIR/starship.fish"
        command -v zoxide &>/dev/null && zoxide init fish --cmd cd >"$CACHE_DIR/zoxide.fish"
        command -v direnv &>/dev/null && direnv hook fish >"$CACHE_DIR/direnv.fish"
    end

    test -f "$CACHE_DIR/starship.fish" && source "$CACHE_DIR/starship.fish"
    test -f "$CACHE_DIR/zoxide.fish" && source "$CACHE_DIR/zoxide.fish"
    test -f "$CACHE_DIR/direnv.fish" && source "$CACHE_DIR/direnv.fish"

    alias ls='eza --icons --group-directories-first -1'

    abbr gd 'git diff'
    abbr ga 'git add .'
    abbr gc 'git commit -am'
    abbr gl 'git log'
    abbr gs 'git status'
    abbr gst 'git stash'
    abbr gsp 'git stash pop'
    abbr gp 'git push'
    abbr gpl 'git pull'
    abbr gsw 'git switch'
    abbr gsm 'git switch main'
    abbr gb 'git branch'
    abbr gbd 'git branch -d'
    abbr gco 'git checkout'
    abbr gsh 'git show'

    abbr l ls
    abbr ll 'ls -l'
    abbr la 'ls -a'
    abbr lla 'ls -la'

    abbr rm trash-put
    abbr tp trash-put
    abbr tl trash-list
    abbr tr trash-restore
    abbr te trash-empty

    cat ~/.local/state/caelestia/sequences.txt 2>/dev/null

    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end

    set -gx GEM_HOME "$HOME/.local/share/gem/ruby/3.4.0"
    fish_add_path "$GEM_HOME/bin"

    set -gx EDITOR nvim
    set -gx VISUAL nvim

    set -gx GPG_TTY (tty)

    gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1 &

    for mode in insert default
        bind -M $mode \ce 'pj; commandline -f repaint'
        bind -M $mode \cf 'pe; commandline -f repaint'
        bind -M $mode \cs 'sshj; commandline -f repaint'
        bind -M $mode \ct 'trj; commandline -f repaint'
        bind -M $mode \ca 'tmux-sessionizer; commandline -f repaint'
    end

    alias cat="bat"
end

if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

if command -v op >/dev/null
    function nvim --wraps nvim
        if not set -q OPENAI_API_KEY
            set -gx OPENAI_API_KEY (op read "op://Private/OpenAI/credential")
            set -gx ANTHROPIC_API_KEY (op read "op://Private/Anthropic/credential")
            set -gx GEMINI_API_KEY (op read "op://Private/Gemini/credential")
        end

        command nvim $argv
    end
end

set -gx PATH $PATH (go env GOPATH)/bin
set -gx INSTALL4J_JAVA_HOME /usr/lib/jvm/java-21-openjdk/
set -gx JAVA_TOOL_OPTIONS "-Djava.net.preferIPv4Stack=true"
