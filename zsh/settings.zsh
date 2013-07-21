autoload -U compinit
compinit -C

# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD

# Now we can pipe to multiple outputs!
setopt MULTIOS

# Spell check commands!  (Sometimes annoying)
setopt CORRECT

# Expand globs
setopt GLOB_COMPLETE
setopt PUSHD_MINUS

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
	    'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

source $ZSH/vcs/zshrc.sh

for config_file ($ZSH/lib/*.zsh(N)); do
	  source $config_file
done

unset config_file

