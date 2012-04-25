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
export HISTIGNORE="&:ls:ll:top:[bf]g:exit:reset:clear:cd:cd ..:cd.."
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
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

source ~/zsh/completion/*.sh

function configurePrompt {
  local NEWLINE=$'\n'
  export PROMPT="%D{%a %b %d} %{$fg[green]%}%D{%T}%{$reset_color%} %D{%Z} %{$fg[magenta]%}%M%{$reset_color%} %{$fg[blue]%}%n%{$reset_color%} %{$fg[yellow]%}%d%{$reset_color%} %! "'$(__git_ps1 "(%s)") '"$NEWLINE: "
}
configurePrompt

########################
##### MISC OPTIONS #####
########################

setopt alwaystoend      # After completion from in-word, move cursor to end.
setopt autocd           # Change directory without 'cd ' prepended.
setopt autopushd        # Auto-pop dirs to stack for `pushd`/`popd` use.
setopt completeinword   # Enable completion mid-word, ex. apache<tab>tl -> apachectl.
setopt correct          # Correction prompt when command not found.
setopt extendedglob     # Extended patterns, e.g. exclude JS files: `ls ^*.js`
setopt nocorrectall     # Do not correct arguments, only commands.
setopt nohup            # Don't kill bg processes on exit.
setopt pushdignoredups  # Don't auto-add duplicate dirs for `pushd`/popd` use.

function loadLocalConfigs {
  local LOCAL_CONFIG_DIR=$HOME/zsh/local
  if [ -d $LOCAL_CONFIG_DIR ]; then
    echo "Loading $LOCAL_CONFIG_DIR"
    source $LOCAL_CONFIG_DIR/*.sh
  fi
}
loadLocalConfigs
