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


# Defaults
EDITOR="vim"
VISUAL="subl"
GIT_EDITOR="vim"

export EDITOR VISUAL GIT_EDITOR
