echo "Loading $0"

alias dk="docker"

# -rm: Remove intermediate containers
alias dkb="docker build -rm"

alias dkd="docker diff"
alias dki="docker images -a"
alias dkit="docker images -a -tree"
alias dkilast="docker images | grep '<none>' | head -1 | awk '{print \$3}'"

# ID of last container
alias dklc="docker ps -l -q"

alias dkps="docker ps -s"
alias dkpsa="docker ps -a -s"
alias dkr="docker run -rm=true"
alias dkrd="docker run -d"
alias dkrlast="dkr \`dkilast\`"

alias dkt="docker tag"
alias dktlast="dkt \`dkilast\` \$1"

# Delete the oldest 20 containers that are at least about 1 hour old.
alias dkrmold="docker ps -a | egrep 'day|week|hour' | tail -n 20 | awk '{print \$1}' | xargs docker rm; docker ps -a"

# Delete the oldest 20 images that are at least about 1 hour old.
alias dkrmiold="docker images | egrep '<none>.*(day|week|hour)' | tail -n 20 | sort --reverse | awk '{print \$3}' | xargs docker rmi; docker images"

LOCAL_ZSH_DIR=$HOME/docker/zsh
if [ -d $LOCAL_ZSH_DIR ]; then
  for file in $LOCAL_ZSH_DIR/*.zsh
  do
    source $file
  done
fi

PATH=$PATH:$HOME/docker/bin
