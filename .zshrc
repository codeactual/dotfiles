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
source ~/zsh/svn.zsh
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

########################
##### DEPENDENCIES #####
########################

function installDependencies {
  local -a packages
  packages=(
    sudo apt-get install

    # build
    #ant
    autoconf
    make

    # dev
    exuberant-ctags
    g++
    git-core
    subversion
    tcl
    vim

    # java
    #openjdk-7-jdk

    # mysql
    libaio1

    # node.js
    libc-ares2
    libev4
    libssl-dev
    libv8-3.7.12.22

    # percona tools
    libdbd-mysql-perl

    # php
    graphviz
    libcurl4-gnutls-dev
    libicu-dev
    libmcrypt-dev
    libmemcached-dev
    libreadline6-dev
    libssl-dev
    libxml2-dev
    libxslt1-dev
    net-tools
    zlib1g-dev

    # python
    ipython

    # ruby
    #rake
    #ruby1.8-dev

    # uuencode, etc.
    sharutils

    # util
    curl
    htop
    iftop
    multitail
    net-tools
    nmap
    nmon
    pv
    renameutils
    tmux
    tree
    wget
  )
  "${packages[@]}"
}
