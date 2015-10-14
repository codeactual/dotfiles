source ~/zsh/core.zsh

#########################
##### MAIN INCLUDES #####
#########################

source ~/zsh/aliases.zsh
source ~/zsh/docker.zsh
source ~/zsh/irc.zsh
source ~/zsh/android.zsh
source ~/zsh/funcs.zsh
source ~/zsh/gnome.zsh
source ~/zsh/mac.zsh
source ~/zsh/mysql.zsh
source ~/zsh/php.zsh
source ~/zsh/python.zsh
source ~/zsh/ruby.zsh
source ~/zsh/node.zsh
source ~/zsh/git.zsh
source ~/zsh/ssh-agent.zsh

##########################
##### LOCAL INCLUDES #####
##########################

LOCAL_CONFIG_DIR=$HOME/zsh/local
if [ -d $LOCAL_CONFIG_DIR ]; then
  for file in $LOCAL_CONFIG_DIR/*.zsh
  do
    source $file
  done
fi
