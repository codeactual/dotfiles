#################
##### NOTES #####
#################
# - man zshoptions
# - `setopt` shows options that differ from default
# - private configs live in $HOME/zsh/local/*.sh

# Set up the prompt
autoload -Uz promptinit
promptinit
autoload -U colors && colors
setopt prompt_subst

###################
##### HISTORY #####
###################

export HISTFILE=~/.zsh_history
export HISTIGNORE="&:ls:ll:top:[bf]g:exit:reset:clear:cd:cd ..:cd..:cd ~:gs:gss:gl:gci:gco:fg:vim:update"
export HISTSIZE=10000
export SAVEHIST=10000

# Update $HIST_FILE as new lines appear. Don't wait until shell exits.
setopt INC_APPEND_HISTORY
# Ignore a line if it duplcates the previous.
setopt HIST_IGNORE_ALL_DUPS
# Ignore lines that begin with a space.
setopt HIST_IGNORE_SPACE
# Strip extra blanks from added lines.
setopt HIST_REDUCE_BLANKS
# Perform history expansion but don't execute yet. Let it be edited first.
setopt HIST_VERIFY
# Allow history sharing between terminals.
setopt SHARE_HISTORY

bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward
# iTerm fixes (http://dotfiles.org/~brendano/.zshrc)
bindkey "\eOA" history-beginning-search-backward
bindkey "\eOB" history-beginning-search-forward

######################
##### COMPLETION #####
######################

# Use modern completion system
autoload -Uz compinit
compinit

# For git-completion
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
#export GIT_PS1_SHOWUPSTREAM="auto"

source ~/zsh/completion/git-completion.zsh
source ~/zsh/completion/git-prompt.zsh

# Color list: /etc/X11/rgb.txt
export PROMPT="%D{%a %m/%d} %{$fg[green]%}%D{%H:%M}%{$reset_color%}:%D{%S} %D{%Z} %n @ %{$fg[yellow]%}%M%{$reset_color%} : %{$fg[magenta]%}%d%{$reset_color%} %! "$'$(__git_ps1 "(%s)")\n: '

########################
##### MISC OPTIONS #####
########################

setopt alwaystoend      # After completion from in-word, move cursor to end.
# setopt autocd           # Change directory without 'cd ' prepended.
setopt autopushd        # Auto-pop dirs to stack for `pushd`/`popd` use.
setopt completeinword   # Enable completion mid-word, ex. apache<tab>tl -> apachectl.
setopt correct          # Correction prompt when command not found.
setopt extendedglob     # Extended patterns, e.g. exclude JS files: `ls ^*.js`
setopt nocorrectall     # Do not correct arguments, only commands.
setopt nohup            # Don't kill bg processes on exit.
setopt pushdignoredups  # Don't auto-add duplicate dirs for `pushd`/popd` use.

export EDITOR="vim"

# Display directories in non-bold cyan.
# http://linux-sxs.org/housekeeping/lscolors.html
# List defaults: dircolors -p
export LS_COLORS="di=00;96"

# Permit vim 256-color schemes.
# Especially to override TERM set to "screen" inside screen.
export TERM="xterm-256color"

# http://www.commandlinefu.com/commands/view/9530/color-man-pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;37m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

################
##### PATH #####
################

CORE_PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin
NODE_MODULES_BIN_PATH=./node_modules/.bin

# To avoid gem installation that requires sudo.
# See "Installing RubyGems in a User Directory" http://docs.rubygems.org/
export RUBY_PREFIX="$HOME/opt/ruby"
export GEM_HOME="$RUBY_PREFIX/gems"

export PATH=$CORE_PATH:$NODE_MODULES_BIN_PATH:$GEM_HOME/bin
export PERL5LIB=""

BIN_DIR="$HOME/zsh/bin"
for dir in `ls -d $BIN_DIR/*`
do
  if [ -d "$dir/bin" ]; then
    PATH="$PATH:$dir/bin"             # Ex. zsh/bin/percona-toolkit/bin
  else
    PATH="$PATH:$dir"                 # Ex. zsh/bin/search
  fi
  if [ -d "$dir/lib" ]; then
    if [ -z $PERL5LIB ]; then
      PERL5LIB="$dir/lib"             # Ex. zsh/bin/MySQL-Sandbox/lib
    else
      PERL5LIB="$PERL5LIB:$dir/lib"
    fi
  fi
done

#########################
##### MAIN INCLUDES #####
#########################

source ~/zsh/aliases.zsh
source ~/zsh/android.zsh
source ~/zsh/funcs.zsh
source ~/zsh/gnome.zsh
source ~/zsh/mac.zsh
source ~/zsh/mysql.zsh
source ~/zsh/php.zsh
source ~/zsh/python.zsh
source ~/zsh/ruby.zsh
source ~/zsh/vcs.zsh

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

    # util
    curl
    htop
    iftop
    multitail
    net-tools
    nmap
    pv
    renameutils
    screen
    tree
    wget
  )
  "${packages[@]}"
}

export NODE_PATH=/usr/local/lib/node_modules

ll
