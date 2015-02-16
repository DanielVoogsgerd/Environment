#!/usr/bin/zsh

if [[ "$OS" == "Debian" ]]; then
    if exist apt; then
        alias apt-get="echo \"Stop doing that already, I've been replaced by apt.\""
        alias apt-cache="echo \"Stop doing that already, I've been replaced by apt.\""
    fi

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
