source $ZSH/vcs/zshrc.sh

for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done
 
SSH_CONNECTED_HOST=`who am i | awk -F"[()]" '{print $2}'`
PROMPT=$''
setopt PROMPT_SUBST
if [[ "$USER" == "root" ]]; then
    PROMPT+='%{%F{001}%}%n'
elif [[ "$USER" == "$username" ]]; then
    PROMPT+='%{%F{002}%}%n'
else
    PROMPT+='%{%F{011}%}%n'
fi
PROMPT+='%{%F{004}%}@'
if [[ "$SSH_CONNECTED_HOST" == ":0" || "$SSH_CONNECTED_HOST" == ":0.0" ]]; then
    PROMPT+='%{%F{005}%}%m%f'
else
    PROMPT+='%{%F{009}%}%m'
fi
PROMPT+='%{%F{004}%}:%{%F{004}%}%~'       # Blue color, current directory, from $HOME
PROMPT+='%{$reset_color%}$(vcs_super_info)' # Default color, Git status
PROMPT+='%{%F{015}%} $ ' # Default color, prompt
RPROMPT='%{%F{004}%}[%(?,%{%F{012}%}%?,%{%F{001}%}%?)%{%F{004}%}]'
RPROMPT+='%F{004}[%F{012}%*%F{004}]%f'

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

function gen_clc() {
    echo "%{%F{$1}%}"
}

clc_default="004"
clc_name="011"
clc_hostname="005"
clc_path="027"
clc_reset="$reset_color"
clc_end="015"

if [[ "$USER" == "$username" ]]; then
    clc_name="002"
elif [[ "$USER" == "root" ]]; then
    clc_name="001"
fi

if [[ -z "$SSH_CONNECTED" ]]; then
	clc_hostname="005"
else
	clc_hostname="009"
fi

function prompt() {
    local PCLC_NAME=$(gen_clc "$clc_name")
    local PCLC_DEFAULT=$(gen_clc "$clc_default")
    local PCLC_HOSTNAME=$(gen_clc "$clc_hostname")
    local PCLC_PATH=$(gen_clc "$clc_path")
    local PCLC_RESET=$(gen_clc "$clc_reset")
    local PCLC_END=$(gen_clc "$clc_end")

	PROMPT=""

	if [[ "$USER" != "$username" ]]; then
		PROMPT+="$PCLC_NAME%n"
	fi

	if [[ -n "$SSH_CONNECTION" && -z "$TMUX" ]]; then
		PROMPT+="$PCLC_DEFAULT@$PCLC_HOSTNAME%m%f "
	fi

	PROMPT+="$PCLC_PATH%~%f"'$(vcs_super_info_wrapper)'"$PCLC_END "'$(shell_icon)'" "
}
prompt

# precmd is called just before the prompt is printed
function precmd() {
    title "zsh" "%m:%55<...<%~"
}

# preexec is called just before any command line is executed
function preexec() {
    title "$1" "%m:%35<...<%~"
}
