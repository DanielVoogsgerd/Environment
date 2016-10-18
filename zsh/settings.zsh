autoload -U compinit
autoload -U colors
colors

compinit -C

# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD

# Now we can pipe to multiple outputs!
setopt MULTIOS

# Spell check commands!  (Always annoying!)
#setopt CORRECT

# Expand globs
setopt GLOB_COMPLETE
setopt PUSHD_MINUS


# Defaults
export EDITOR="nano"
export GIT_EDITOR="nano"
export VISUAL="gedit"

export LANG="en_US.UTF-8"
export EDITOR VISUAL GIT_EDITOR

# XDG Settings
export XDG_CONFIG_HOME="$HOME/.config"

# Easy cding in projects
export CDPATH="$HOME/Projects"

export LESS="FRX"
