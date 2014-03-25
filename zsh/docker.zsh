echo "Loading $0"

alias dk="docker"

# -rm: Remove intermediate containers
alias dkb="docker build"

alias dkd="docker diff"
alias dki="docker images"
alias dkia="docker images -a"
alias dkiat="docker images -a -tree"
alias dkilast="docker images | grep '<none>' | head -1 | awk '{print \$3}'"

alias dkinip="docker inspect --format '{{ .NetworkSettings.IPAddress }}' \$1"

# ID of last container
alias dklc="docker ps -l -q"

alias dkps="docker ps -s"
alias dkpsa="docker ps -a -s"
alias dkr="docker run --rm=true"
alias dkrd="docker run -d"
alias dkrlast="dkr \`dkilast\`"

alias dkt="docker tag"
alias dktlast="dkt \`dkilast\` \$1"

# Delete the oldest 20 containers that are at least about 1 hour old.
alias dkrmold="docker ps -a | egrep 'minute|day|week|hour' | tail -n 20 | awk '{print \$1}' | xargs docker rm; docker ps -a"

# Delete the oldest 20 images that are at least about 1 hour old.
alias dkrmiold="docker images | egrep '<none>.*(minute|day|week|hour)' | tail -n 20 | sort --reverse | awk '{print \$3}' | xargs docker rmi; docker images"

alias dk-master-install="docker -v; sudo service docker stop ; sudo cp \$(which docker) \$(which docker)_ ; sudo cp ./bundles/*-dev/binary/docker-*-dev $(which docker); sudo service docker start; docker -v"

LOCAL_ZSH_DIR=$HOME/docker/zsh
FIRST="$LOCAL_ZSH_DIR/vars.zsh"
if [ -d $LOCAL_ZSH_DIR ]; then
  source $FIRST
  for file in $LOCAL_ZSH_DIR/*.zsh
  do
    if [[ "$file" != "$FIRST" ]]; then
      source $file
    fi
  done
fi

PATH=$PATH:$HOME/docker/bin
