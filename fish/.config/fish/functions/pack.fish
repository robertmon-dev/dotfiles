function pack --description "Compresses a file or directory into a tar.gz archive"
    if test (count $argv) -eq 0
        echo "Usage: pack <file or directory>"
        return 1
    end

    set target $argv[1]
    set name (string replace -r '/$' '' $target)

    if test -e $target
        echo "Compressing '$target' into '$name.tar.gz'"
        tar -czf "$name.tar.gz" $target

        set size (du -sh "$name.tar.gz" | cut -f1)
        echo "Success. Archive size: $size"
    else
        echo "Error: Target '$target' does not exist."
        return 1
    end
end
