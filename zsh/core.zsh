#################
##### NOTES #####
#################
# - man zshoptions
# - `setopt` shows options that differ from default
# - private configs live in $HOME/zsh/local/*.sh

grep docker /proc/1/cgroup 2>&1 > /dev/null
if [ $? -eq 0 ]; then
  in_docker=0
else
  in_docker=1
fi

# Set up the prompt
autoload -Uz promptinit
promptinit
autoload -U colors && colors
setopt prompt_subst

###################
##### HISTORY #####
###################

export HISTFILE=~/zsh/history
export HISTSIZE=2000
export SAVEHIST=1000

# If outside a docker container, perform egrep-based filtering.
if [ "$in_docker" = "1" ] && [ -z "$TMUX" ]; then
  __ZSH_HISTIGNORE_ANYWHERE="(AWS_|secret|auth|code|token|key|encrypt|decrypt|delete|remove|drop|purge|prune|rm|mv|cp|sudo|patch|-f|force)"
  __ZSH_HISTIGNORE_BEGINSWITH="(export|shutdown|exit|reset|clear|gci|node|vim|git)"

  __ZSH_HISTIGNORE_RESULT="/tmp/.zsh_history_filtered_pid$$"
  __ZSH_HISTIGNORE_DIFF="/tmp/.zsh_history_diff_pid$$"
  # If a filter result is missing or old.
    if [ -f "${HISTFILE}" ]; then
      if [ ! -f $__ZSH_HISTIGNORE_RESULT ] || [ test `find ${__ZSH_HISTIGNORE_RESULT} -mmin +1 > /dev/null 2>&1` ]; then
        cat ${HISTFILE} | egrep -iv ": [0-9]+:[0-9]+;.*${__ZSH_HISTIGNORE_ANYWHERE}" > ${__ZSH_HISTIGNORE_RESULT}.anywhere
        if [ "${DUMPDIFF}" = "1" ]; then
          diff ${HISTFILE} ${__ZSH_HISTIGNORE_RESULT}.anywhere > ${__ZSH_HISTIGNORE_DIFF}.anywhere
          echo "ZSH history cleanup (anywhere): ${__ZSH_HISTIGNORE_DIFF}.anywhere ($(egrep "^<" ${__ZSH_HISTIGNORE_DIFF}.anywhere | wc -l))"
        fi

        cat ${__ZSH_HISTIGNORE_RESULT}.anywhere | egrep -v ": [0-9]+:[0-9]+;${__ZSH_HISTIGNORE_BEGINSWITH}" > ${__ZSH_HISTIGNORE_RESULT}.beginswith
        if [ "${DUMPDIFF}" = "1" ]; then
          diff ${HISTFILE} ${__ZSH_HISTIGNORE_RESULT}.beginswith > ${__ZSH_HISTIGNORE_DIFF}.beginswith
          echo "ZSH history cleanup (beginswith): ${__ZSH_HISTIGNORE_DIFF}.beginswith ($(egrep "^<" ${__ZSH_HISTIGNORE_DIFF}.beginswith | wc -l))"
        fi

        cp ${__ZSH_HISTIGNORE_RESULT}.beginswith ${HISTFILE}
        rm -f ${__ZSH_HISTIGNORE_RESULT}
      fi
    fi
  fi

setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Strip extra blanks from added lines.
#
# Disabled due to bug where long lines get mangled. Should be fixed when ubuntu has zsh 5.05.
#
# - https://bugs.launchpad.net/ubuntu/+source/zsh/+bug/1334858
# - https://bugzilla.novell.com/show_bug.cgi?id=902509
#setopt HIST_REDUCE_BLANKS
unsetopt HIST_REDUCE_BLANKS

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

# Use 'qq' for <ESC> to match .vimrc
bindkey -M viins 'qq' vi-cmd-mode

######################
##### COMPLETION #####
######################

# Use modern completion system
autoload -Uz compinit
autoload -Uz bashcompinit
compinit
bashcompinit

# For git-completion
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="verbose name git"
export GIT_PS1_SHOWCOLORHINTS=

# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/vi-mode/vi-mode.plugin.zsh
# Updates editor information when the keymap changes.
function zle-line-init zle-keymap-select() {
  zle reset-prompt
  zle -R
}
# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}
zle -N zle-line-init
zle -N zle-keymap-select
zle -N edit-command-line
if [[ "$MODE_INDICATOR" == "" ]]; then
  MODE_INDICATOR="%{$fg_bold[red]%}:%{$reset_color%}"
fi
function vi_mode_prompt_info() {
  echo "
${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/:}"
}

# 200ms for key sequences (to match vim default)
# From https://www.johnhawthorn.com/2012/09/vi-escape-delays/
KEYTIMEOUT=200

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
PRMT_TIME="%D{%H:%M}:%D{%S}"
PRMT_TZ="%D{%Z} $(TZ=":America/Los_Angeles" date +'%z %Z')"
PRMT_USER="%n"

if grep docker /proc/1/cgroup 2>&1 > /dev/null; then
  PRMT_HOST_PREFIX="docker "
else
  PRMT_HOST_PREFIX=""
fi
PRMT_HOST="$PRMT_HOST_PREFIX%M"

function __git_dir_info {
  GIT_BRANCH=`git name-rev --name-only HEAD 2>&1`
  if [ $? -ne 0 ] || [[ $GIT_BRANCH == *"HEAD"* ]]; then
    return $? # not a git repo
  fi

  GIT_REMOTE=$(git config "branch.${GIT_BRANCH}.remote")
  if [ "${GIT_REMOTE}" = "" ]; then
    GIT_REMOTE="no_remote"
  else
    GIT_REMOTE=$(git config "branch.${GIT_BRANCH}.remote")
  fi

  echo "${GIT_REMOTE}/"
}

# https://github.com/jonmosco/kube-ps1
source ~/zsh/kube-ps1.sh

PRMT_DIR="
%{$fg[green]%}%d%{$reset_color%}
"
PRMT_HISTNUM="
%!"
precmd () {
  # 1st arg: prepend to the git status section
  # 2nd arg: append to git status section
  # 3rd arg: format of git status section
  # - Use multi-line string, for 2nd arg, because \n won't work there.
  __git_ps1 "\${PRMT_DIR}\${PRMT_DATE} \${PRMT_TIME} \${PRMT_TZ} | \${PRMT_HOST} \${PRMT_USER} \$(kube_ps1)\${PRMT_HISTNUM} \$(__git_dir_info)" "
\$(vi_mode_prompt_info) " "%s"
}

unset PS1
unset PROMPT
source ~/zsh/completion/git-prompt.zsh

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

# https://github.com/tmux/tmux/issues/625#issuecomment-258009586
if [[ $TMUX = "" ]]; then
  export TERM="xterm-256color"
else
  export TERM="tmux"
fi


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
#
export PERL5LIB=""

# Don't overwrite any PATH customization made via `docker run -e ...`
if ! grep docker /proc/1/cgroup 2>&1 > /dev/null; then
  export PATH="/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:$HOME/bin"
fi

BIN_DIR="$HOME/zsh/bin"
for dir in `ls -d $BIN_DIR/*`
do
  # Don't overwrite any PATH customization made via `docker run -e ...`
  if ! grep docker /proc/1/cgroup 2>&1 > /dev/null; then
    if [ -d "$dir/bin" ]; then
      PATH="$PATH:$dir/bin"             # Ex. zsh/bin/percona-toolkit/bin
    else
      PATH="$PATH:$dir"                 # Ex. zsh/bin/search
    fi
  fi
  if [ -d "$dir/lib" ]; then
    if [ -z $PERL5LIB ]; then
      PERL5LIB="$dir/lib"             # Ex. zsh/bin/MySQL-Sandbox/lib
    else
      PERL5LIB="$PERL5LIB:$dir/lib"
    fi
  fi
done

export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8
