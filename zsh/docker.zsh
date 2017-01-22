LOCAL_ZSH_DIR=$HOME/zsh/docker
if [ -d $LOCAL_ZSH_DIR ]; then
  for file in $LOCAL_ZSH_DIR/*.*sh
  do
    source $file
  done
fi

export DOCKER_HIDE_LEGACY_COMMANDS=1
