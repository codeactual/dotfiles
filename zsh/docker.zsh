echo "Loading $0"

alias dk="docker"

# -rm: Remove intermediate containers
alias dkb="docker build -rm"

alias dki="docker images -a"
alias dkit="docker images -a -tree"

# ID of last container
alias dklc="docker ps -l -q"

alias dkps="docker ps -a -s"
alias dkr="docker run"

# Delete the oldest 20 containers that are at least about 1 hour old.
alias dkrmold="docker ps -a | egrep 'day|week|hour' | tail -n 20 | awk '{print \$1}' | xargs docker rm; docker ps -a"

# Delete the oldest 20 images that are at least about 1 hour old.
alias dkrmiold="docker images | egrep 'day|week|hour' | tail -n 20 | sort --reverse | awk '{print \$1}' | xargs docker rmi; docker images"

LOCAL_ZSH_DIR=$HOME/docker/zsh
if [ -d $LOCAL_ZSH_DIR ]; then
  for file in $LOCAL_ZSH_DIR/*.zsh
  do
    source $file
  done
fi

PATH=$PATH:$HOME/docker/bin
