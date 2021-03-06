source ~/zsh/core.zsh

#########################
##### MAIN INCLUDES #####
#########################

source ~/zsh/aliases.zsh
source ~/zsh/docker.zsh
source ~/zsh/funcs.zsh
source ~/zsh/python.zsh
source ~/zsh/ruby.zsh
source ~/zsh/node.zsh
source ~/zsh/golang.zsh
source ~/zsh/git.zsh
source ~/zsh/ssh-agent.zsh

##########################
##### LOCAL INCLUDES #####
##########################

LOCAL_ZSH_DIR=$HOME/zsh/local
if [ -d $LOCAL_ZSH_DIR ]; then
  for file in $LOCAL_ZSH_DIR/*.zsh
  do
    source $file
  done
fi
