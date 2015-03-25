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

clc_default="$_fmt_reset"
clc_name="$_fmt_yellow"
clc_hostname="$_fmt_purple"
clc_path="$_fmt_red"
clc_reset="$reset_color"
clc_end="$_fmt_end"

if [[ "$USER" == "$username" ]]; then
    clc_name="$_fmt_green"
elif [[ "$USER" == "root" ]]; then
    clc_name="$_fmt_red"
fi

if [[ "$SSH_CONNECTED_HOST" == ":0" || "$SSH_CONNECTED_HOST" == ":0.0" ]]; then
	clc_hostname="$_fmt_purple"
else
	clc_hostname="$_fmt_red"
fi

function prompt() {
    local PCLC_NAME="$clc_name"
    local PCLC_DEFAULT="$clc_default"
    local PCLC_HOSTNAME="$clc_hostname"
    local PCLC_PATH="$clc_path"
    local PCLC_RESET="$clc_reset"
	local PCLC_END="$clc_end"

	PS1="$PCLC_NAME\u$PCLC_NAME$PCLC_DEFAULT@$PCLC_NAME$PCLC_HOSTNAME\h$PCLC_NAME$PCLC_RESET $PCLC_PATH\w$PCLC_END $ "
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
