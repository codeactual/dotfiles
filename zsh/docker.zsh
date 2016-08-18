alias dki="docker images"
alias dkia="docker images -a"
alias dkiat="docker images -a -tree"
alias dkilast="docker images | grep '<none>' | head -1 | awk '{print \$3}'"

# ID of last container
alias dklc="docker ps -l -q"

alias dkps="docker ps"
alias dkpsa="docker ps -a --no-trunc=true"
alias dkr="docker run --rm=true"
alias dkrd="docker run -d"
alias dkrlast="dkr \`dkilast\`"

alias dktlast="dkt \`dkilast\` \$1"

alias dkrmold="docker ps --all --filter=status=exited --filter=status=dead | awk '{print \$1}' | grep -v CONTAINER | xargs docker rm"
alias dkrmiold="dkrmold; docker images --filter=dangling=true | grep '<none>' | awk '{print \$3}' | xargs docker rmi; docker images"

alias dk-master-install="docker -v; sudo service docker stop ; sudo cp \$(which docker) \$(which docker)_ ; sudo cp ./bundles/*-dev/binary/docker-*-dev $(which docker); sudo service docker start; docker -v"

# http://stackoverflow.com/questions/20010199/determining-if-a-process-runs-inside-lxc-docker
alias dk-detect="grep docker /proc/1/cgroup 2>&1 > /dev/null"

LOCAL_ZSH_DIR=$HOME/docker/zsh
if [ -d $LOCAL_ZSH_DIR ]; then
  for file in $LOCAL_ZSH_DIR/*.*sh
  do
    source $file
  done
fi

PATH=$PATH:$HOME/docker/bin
