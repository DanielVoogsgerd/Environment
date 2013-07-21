setopt PROMPT_SUBST
PROMPT=$'%{${fg[green]}%}%n@%m:'  # Green color, current user@server
PROMPT+='%{${fg[blue]}%}%~'       # Blue color, current directory, from $HOME
PROMPT+='%{${fg[default]}%}$(vcs_super_info)' # Default color, Git status
PROMPT+='%{${fg[default]}%} $ ' # Default color, prompt

