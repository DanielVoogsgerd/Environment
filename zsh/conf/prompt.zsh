source $ZSH/vcs/zshrc.sh

for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done

SSH_CONNECTED_HOST=`who am i | awk -F"[()]" '{print $2}'`
PROMPT=$''
setopt PROMPT_SUBST
if [[ "$USER" == "root" ]]; then
	PROMPT+='%{${fg[red]}%}%n'
else
	PROMPT+='%F{131}%n'
fi
PROMPT+='%F{147}@'
if [[ "$SSH_CONNECTED_HOST" == ":0" || "$SSH_CONNECTED_HOST" == ":0.0" ]]; then
	PROMPT+='%F{221}%m%f'
else
	PROMPT+='%{${fg[red]}%}%m'
fi
PROMPT+='%F{147}:%F{147}%~'       # Blue color, current directory, from $HOME
PROMPT+='%F{147}$(vcs_super_info)' # Default color, Git status
PROMPT+='%F{147} $ ' # Default color, prompt
RPROMPT='%F{147}%}[%(?,%F{185}%}%?,%F{131}%}%?)%F{147}%}]'
RPROMPT+='%F{147}[%*]'

# Besides an ordinairy prompt I also set the terminal window to contain the executed command. Thanks to Brian from bstpierre

function title() {
    # escape '%' chars in $1, make nonprintables visible
    local a=${(V)1//\%/\%\%}

    # Truncate command, and join lines.
    a=$(print -Pn "%40>...>$a" | tr -d "\n")
    case $TERM in
        screen*)
            print -Pn "\e]2;$a @ $2\a" # plain xterm title
            print -Pn "\ek$a\e\\"      # screen title (in ^A")
            print -Pn "\e_$2   \e\\"   # screen location
            ;;
        xterm*)
            print -Pn "\e]2;$a @ $2\a" # plain xterm title
            ;;
    esac
}

# precmd is called just before the prompt is printed
function precmd() {
    title "zsh" "%m:%55<...<%~"
}

# preexec is called just before any command line is executed
function preexec() {
    title "$1" "%m:%35<...<%~"
}
