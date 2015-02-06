#!/usr/bin/zsh

if [[ "$OS" == "Debian" ]]; then
    alias apt-get="echo \"Stop doing that already, I've been replaced by apt.\""
    alias update="apt update"
    alias upgrade="apt upgrade"
fi
