function sshj --description "Fuzzy find SSH server and connect using 1Password"
    if not set -q SSHJ_SERVERS
        set_color red
        echo "SSHJ_SERVERS variable is not defined in secrets.fish."
        set_color normal
        return 1
    end

    set -l selected_name (for s in $SSHJ_SERVERS; string split " | " $s | head -n 1; end | fzf --prompt="Select SSH server: " --height=40% --layout=reverse --border)

    if test -n "$selected_name"
        for s in $SSHJ_SERVERS
            set -l parts (string split " | " $s)

            if test "$parts[1]" = "$selected_name"
                set -l connection $parts[2]
                set -l op_path $parts[3]

                echo ""
                set_color blue
                echo "Initiating connection to $selected_name ($connection)..."
                set_color normal

                if test "$op_path" != none
                    set_color cyan
                    echo "Fetching credentials from 1Password vault..."
                    set_color normal

                    set -gx SSHPASS (op read "$op_path")

                    if test $status -eq 0
                        sshpass -e ssh $connection
                    else
                        set_color red
                        echo "Failed to retrieve credentials. Connection aborted."
                        set_color normal
                    end
                else
                    set_color cyan
                    echo "Connecting via standard SSH configuration..."
                    set_color normal

                    kitten ssh $connection
                end
                break
            end
        end
    end
end
