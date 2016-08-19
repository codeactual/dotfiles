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

# Use egrep to mimic HISTIGNORE in zsh.
export __ZSH_HISTIGNORE_EXACT="(h?top|exit|reset|clear|gci|node|replpad|rm|secret|encrypt|decrypt|mv|vim?)"
export __ZSH_HISTIGNORE_EXIST="shutdown|git checkout"
export __ZSH_HISTIGNORE="(^..$"
export __ZSH_HISTIGNORE="$__ZSH_HISTIGNORE|^l[sl] "
export __ZSH_HISTIGNORE="$__ZSH_HISTIGNORE|^export"
export __ZSH_HISTIGNORE="$__ZSH_HISTIGNORE|^[^.$/a-z:]"
export __ZSH_HISTIGNORE="$__ZSH_HISTIGNORE|$__ZSH_HISTIGNORE_EXIST"
export __ZSH_HISTIGNORE="$__ZSH_HISTIGNORE|^$__ZSH_HISTIGNORE_EXACT$"
export __ZSH_HISTIGNORE="$__ZSH_HISTIGNORE)"
__ZSH_HISTIGNORE_RESULT="/tmp/.zsh_history_filtered_pid$$"
# If a filter result is missing or old.
if [ -f ~/.zsh_history ]; then
  if [ ! -f $__ZSH_HISTIGNORE_RESULT ] || [ test `find $__ZSH_HISTIGNORE_RESULT -mmin +1 > /dev/null 2>&1` ]; then
    egrep -v "$__ZSH_HISTIGNORE" ~/zsh/history > $__ZSH_HISTIGNORE_RESULT
    echo "ZSH history cleanup: $(diff ~/zsh/history $__ZSH_HISTIGNORE_RESULT | egrep "^<" | wc -l)"
    cp $__ZSH_HISTIGNORE_RESULT ~/zsh/history
    rm -f $__ZSH_HISTIGNORE_RESULT
  fi
fi

export HISTFILE=~/zsh/history
export HISTSIZE=10000
export SAVEHIST=10000

# Update $HIST_FILE as new lines appear. Don't wait until shell exits.
setopt INC_APPEND_HISTORY
# Ignore a line if it duplcates the previous.
setopt HIST_IGNORE_ALL_DUPS
# Ignore lines that begin with a space.
setopt HIST_IGNORE_SPACE
# Strip extra blanks from added lines.
#
# Disabled due to bug where long lines get mangled. Should be fixed when ubuntu has zsh 5.05.
#
# - https://bugs.launchpad.net/ubuntu/+source/zsh/+bug/1334858
# - https://bugzilla.novell.com/show_bug.cgi?id=902509
#setopt HIST_REDUCE_BLANKS
unsetopt HIST_REDUCE_BLANKS
# Perform history expansion but don't execute yet. Let it be edited first.
setopt HIST_VERIFY
# Allow history sharing between terminals.
setopt SHARE_HISTORY

# https://github.com/nickstenning/dotfiles/blob/master/zsh/lib/keys.zsh
history-incremental-pattern-search-backward-with-buffer() {
  zle history-incremental-pattern-search-backward $BUFFER

  # Hack to move the cursor to EOL if the search is cancelled in order
  # to modify the last-displayed result before executing it.
  CURSOR=1000
}
zle -N history-incremental-pattern-search-backward-with-buffer

# Seed (bck|fwd)-i-search with current buffer.
bindkey -M vicmd '/' history-incremental-pattern-search-backward-with-buffer
bindkey -M viins '^R' history-incremental-pattern-search-backward-with-buffer

# After (bck|fwd)-i-search has been seeded, in insert or command mode, browse results.
# (vim-directional alternative to default backspace/shift-backspace).
bindkey -M viins '^K' history-incremental-pattern-search-backward
bindkey -M viins '^J' history-incremental-pattern-search-forward

# Browse history using current buffer and place cursor at EOL.
# https://bbs.archlinux.org/viewtopic.php?pid=1170272#p1170272
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -M viins "\e[A" history-beginning-search-backward-end
bindkey -M viins "\e[B" history-beginning-search-forward-end
bindkey -M viins "\eOA" history-beginning-search-backward-end
bindkey -M viins "\eOB" history-beginning-search-forward-end

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

# http://hamberg.no/erlend/posts/2010-10-17-show-current-vi-mode-in-zsh-prompt.html
# set VIMODE according to the current mode (default “[INSERT]”)
VIMODE='[INSERT]'
function zle-keymap-select {
 VIMODE="${${KEYMAP/vicmd/[NORMAL]}/(main|viins)/[INSERT]}"
 zle reset-prompt
}
zle -N zle-keymap-select

# Prevent buffer from cycling through tab-completion candiates. Only show the menu.
# http://unix.stackexchange.com/questions/12035/zsh-equivalent-of-bash-show-all-if-ambiguous
setopt bash_auto_list
setopt no_auto_menu
unsetopt ALWAYS_LAST_PROMPT

##################
##### PROMPT #####
##################

# Color list: /etc/X11/rgb.txt
#
# Example:
#
# Tue 08/11 07:38:34 UTC ubuntu @ ip-172-31-4-177 : /var/dev 4901  [INSERT]
# : some cmd
PRMT_DATE="%D{%a %m/%d}"
PRMT_TIME="%{$fg[green]%}%D{%H:%M}%{$reset_color%}:%D{%S}"
PRMT_TZ="%D{%Z}"
PRMT_USER="%n"

if [[ -z "$HOSTNAME" ]]; then
  PRMT_HOST_PREFIX=""
else
  PRMT_HOST_PREFIX="CONTAINER ---- "
fi
PRMT_HOST="%{$fg[yellow]%}$PRMT_HOST_PREFIX%M%{$reset_color%}"

PRMT_DIR="%{$fg[magenta]%}%d%{$reset_color%}"
PRMT_HISTNUM="%!"
PRMT_BRANCH=""$'$(__git_ps1 "(%s)")'
export PROMPT="$PRMT_DATE $PRMT_TIME $PRMT_TZ $PRMT_USER @ $PRMT_HOST : $PRMT_DIR $PRMT_HISTNUM $PRMT_BRANCH ${VIMODE}
: "

########################
##### MISC OPTIONS #####
########################

setopt alwaystoend      # After completion from in-word, move cursor to end.
# setopt autocd           # Change directory without 'cd ' prepended.
setopt autopushd        # Auto-pop dirs to stack for `pushd`/`popd` use.
setopt completeinword   # Enable completion mid-word, ex. apache<tab>tl -> apachectl.
unsetopt correct          # Correction prompt when command not found.
setopt extendedglob     # Extended patterns, e.g. exclude JS files: `ls ^*.js`
unsetopt correctall     # Do not correct arguments, only commands.
setopt nohup            # Don't kill bg processes on exit.
setopt pushdignoredups  # Don't auto-add duplicate dirs for `pushd`/popd` use.

###################
##### VI MODE #####
###################

# http://zshwiki.org/home/zle/vi-mode
setopt vi

bindkey -a u undo # Undo via 'u' in command mode
bindkey -a U redo  # Use 'U' to avoid control-key in tmux

# Allow backspacing beyond insert starting position
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

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

export PATH="/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:$HOME/bin"
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
