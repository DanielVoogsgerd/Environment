#!/usr/bin/zsh

if [[ "$OS" == "Debian" ]]; then

    function changelog() {
        local location="/usr/share/doc/$1/changelog.Debian.gz"
        if [ -f "$location" ]; then
            zless "$location"
        else
            echo "No changelog found"
        fi
    }


    alias pupdate="apt update"
    alias pupgrade="apt upgrade"
    alias psearch="apt search"

    alias nuke="apt purge"
fi
