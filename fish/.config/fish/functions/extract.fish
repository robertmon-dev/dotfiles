function ex --description "Smart extraction for various archive formats"
    if test (count $argv) -eq 0
        echo "Usage: ex <archive file>"
        return 1
    end

    set file $argv[1]

    if test -f $file
        echo "Extracting '$file'"

        switch $file
            case "*.tar.bz2" "*.tbz2"
                tar xjf $file
            case "*.tar.gz" "*.tgz"
                tar xzf $file
            case "*.bz2"
                bunzip2 $file
            case "*.rar"
                unrar x $file
            case "*.gz"
                gunzip $file
            case "*.tar"
                tar xf $file
            case "*.zip"
                unzip $file
            case "*.Z"
                uncompress $file
            case "*.7z"
                7z x $file
            case "*"
                echo "Error: Unknown extraction method for '$file'."
                return 1
        end

        echo "Extraction successful."
    else
        echo "Error: File '$file' does not exist."
        return 1
    end
end
