source $ZSH/vcs/zshrc.sh

SSH_CONNECTED_HOST=`who am i | awk -F"[()]" '{print $2}'`
PROMPT=$'%{${fg_bold[white]}%}'
setopt PROMPT_SUBST
if [[ "$USER" == "root" ]]; then
	PROMPT+='%{${fg[red]}%}%n'
elif [[ "$USER" == "daniel" ]]; then
	PROMPT+='%{${fg[green]}%}%n'
else
	PROMPT+='%{${fg[blue]}%}%n'
fi
PROMPT+='%{${fg[blue]}%}@'
if [[ "$SSH_CONNECTED_HOST" == ":0" || "$SSH_CONNECTED_HOST" == ":0.0" ]]; then
	PROMPT+='%{${fg[blue]}%}%m'
else
	PROMPT+='%{${fg[red]}%}%m'
fi
PROMPT+='%{${fg[blue]}%}:%~'       # Blue color, current directory, from $HOME
PROMPT+='%{${fg[default]}%}$(vcs_super_info)' # Default color, Git status
PROMPT+='%{${fg[default]}%} $ ' # Default color, prompt


RPROMPT=$'[%?][%*]'
