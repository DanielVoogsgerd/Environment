source $SHELLLOC/plugins/vcs/zshrc.sh


SSH_CONNECTED_HOST=`who am i | awk -F"[()]" '{print $2}'`
setopt PROMPT_SUBST

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
clc_path="004"
clc_reset="$reset_color"
clc_end="015"

if [[ "$USER" == "$username" ]]; then
    clc_name="002"
elif [[ "$USER" == "root" ]]; then
    clc_name="001"
fi

if [[ "$SSH_CONNECTED_HOST" == ":0" || "$SSH_CONNECTED_HOST" == ":0.0" ]]; then
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

	PROMPT="$PCLC_NAME%n$PCLC_DEFAULT@$PCLC_HOSTNAME%m%f $PCLC_PATH%~%f"'$(vcs_super_info)'"$PCLC_END $ "
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
