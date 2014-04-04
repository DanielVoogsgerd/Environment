alias "$USER"="cd /home/$USER/"

alias ls="ls --color=auto -h -F"
alias la="ls -lA"
alias lsa="ls -la"
alias l="ls -lh"
alias ll="ls -lah"

alias cl="clear"
alias cls="clear && ls -h"

alias ".."="cd ../"
alias "..."="cd ../../"
alias "...."="cd ../../../"
alias "....."="cd ../../../../"
alias "......"="cd ../../../../../"
alias "......."="cd ../../../../../"

# Git aliasses
alias g="git"

alias s="subl3"
alias t="tree"
alias d="tree -d"
alias v="vim"
alias n="touch"
alias clip="xclip -sel clip"
alias c='pygmentize -O style=monokai -f console256 -g'
alias extract="dtrx"
alias ':q'='exit'

# Conserve directories
alias conserveDir="pwd>$cdir"
alias tmux="conserveDir && tmux -2"
alias refresh="conserveDir && exec zsh"


alias artisan="php artisan"

alias grep="grep --exclude-dir='.svn' --exclude-dir='.git' --color=auto"
alias grepr="grep -rnH"

alias cp="rsync -aP"
alias swapcaps="/usr/bin/setxkbmap -option 'ctrl:swapcaps'"
alias SWAPCAPS="/usr/bin/setxkbmap -option 'ctrl:swapcaps'"

alias whois="whois -h whois.geektools.com"
