setopt PROMPT_SUBST
source $ZSH/vcs/zshrc.sh

for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done

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
	commandcount=$(wc -l ~/.zhistory)
}

# preexec is called just before any command line is executed
function preexec() {
    title "$1" "%m:%35<...<%~"
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

function prompt() {
    local PCLC_NAME=$(gen_clc "$clc_name")
    local PCLC_DEFAULT=$(gen_clc "$clc_default")
    local PCLC_HOSTNAME=$(gen_clc "$clc_hostname")
    local PCLC_PATH=$(gen_clc "$clc_path")
    local PCLC_RESET=$(gen_clc "$clc_reset")
    local PCLC_END=$(gen_clc "$clc_end")

	PROMPT=""

	if [[ "$USER" != "$username" ]]; then
		PROMPT+="$PCLC_NAME%n "
	fi

	if [[ -n "$SSH_CONNECTION" && -z "$TMUX" ]]; then
		PROMPT+="$PCLC_DEFAULT@$PCLC_HOSTNAME%m%f "
	fi

	PROMPT+="$PCLC_PATH%~%f"'$(vcs_super_info_wrapper)'"$PCLC_END "'$(shell_icon)'" "

	RPROMPT="%{%F{004}%}[%{%F{012}%}"'$(cat ~/.zhistory | wc -l)'"%{%F{004}%}]%{%F{004}%}[%(?,%{%F{012}%}%?,%{%F{001}%}%?)%{%F{004}%}]"
	RPROMPT+='%F{004}[%F{012}%*%F{004}]%f'
}
prompt
