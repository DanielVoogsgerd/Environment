alias "$USER"="cd /home/$USER/"

alias ls="ls --color=auto -h -F"
alias la="ls -lA"
alias lsa="ls -la"
alias l="ls -la"

alias cl="clear"

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

alias artisan="php artisan"

alias grep="grep --exclude-dir='.svn' --exclude-dir='.git' --color=auto"
alias grepr="grep -rnH"

alias cp="rsync -aP"
alias swapcaps="/usr/bin/setxkbmap -option 'ctrl:swapcaps'"
alias cp="rsync -aP"
