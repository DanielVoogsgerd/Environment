if [ -f $HOME/.rvm/scripts/rvm ];then
	source $HOME/.rvm/scripts/rvm
fi
if [ -f $HOME/.nvm/nvm.sh ]; then
	source $HOME/.nvm/nvm.sh
fi
. $ENVIRONMENT/zsh/z/z.sh

source $ZSH/wp-cli/utils/wp-completion.bash
