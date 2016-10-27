# cd to users homedir, by using their name
for homedir in /home/*/; do
    user=$(echo "$homedir" | awk -F"/" '{ print $3 }' )
    alias "$user"="cd /home/$user/"
done

# Use aliasses when using sudo
alias sudo="sudo "

# Better listing
alias ls="ls --color=auto -h -F"
alias la="ls -lAh"
alias lsa="ls -lah"
alias l="ls -lh"
alias ll="ls -lah"

# clear aliasses
alias cl="clear"
alias cls="clear && ls -h"

# Moving verbose will show you what files are being moved. It is the most progressslike you're gonnna get.
alias mv="mv -vi"

# Quick backwards dir hopping
alias ".."="cd ../"
alias "..."="cd ../../"
alias "...."="cd ../../../"
alias "....."="cd ../../../../"
alias "......"="cd ../../../../../"
alias "......."="cd ../../../../../../"

# Application aliasses
alias g="git"
alias d="docker"

# Really short aliases, for basic operations
alias e="edit"
alias t="tree"
alias n="touch"
alias clip="xclip -sel clip"
alias c='pygmentize -O style=monokai -f console256 -g'
alias ':q'='exit'
alias open="xdg-open"
alias todo="cliist"
alias chmox="chmod +x"
alias ctl="systemctl"
alias cert="sudo certbot certonly -a webroot --webroot-path=/srv/www/letsencrypt"

# And some fasd aliases
function ef { edit `f $1` }


# Conserve directories
alias conserveDir="pwd>$cdir"
alias tmux="conserveDir && tmux -2"
alias refresh="conserveDir && exec zsh"

# Grep is awesome, but some things should be default for me
alias grep="grep --exclude-dir='.svn' --exclude-dir='.git' --color=auto"
alias grepr="grep -rnH"

# Better cp, why send the same file twice
alias cp="rsync -aP"

# Because capslock should have been ctrl for the get go
alias swapcaps="/usr/bin/setxkbmap -option 'ctrl:swapcaps'"
alias SWAPCAPS="/usr/bin/setxkbmap -option 'ctrl:swapcaps'"

# I love using geektools for whois
alias whois="whois -h whois.geektools.com"

# For people working with Laravel this is very useful
alias art="php artisan"
alias artisan="php artisan"
alias cda="composer dumpautoload"
alias lmigrate="artisan migrate"
alias lseed="artisan db:seed"
alias lmreset="artisan migrate:reset"
