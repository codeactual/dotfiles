echo "Loading $0"

#####################
##### LS / TREE #####
#####################

alias ll="ls -l --almost-all --color=always --classify --time-style=long-iso --human-readable"
alias lsbigdir="perl -le 'opendir DIR, \".\" or die; print while \$_ = readdir DIR; closedir DIR'" # http://www.commandlinefu.com/commands/view/8227/listing-directory-content-of-a-directory-with-a-lot-of-entrie
alias tt='tree -pFCfhD -I "components|tmp|node_modules" . | grep "$1" | less -RgIKNs'

###############################
##### LSOF / NETSTAT / PS #####
###############################

alias connected_ips="netstat -lantp | grep ESTABLISHED |awk '{print \$5}' | awk -F: '{print \$1}' | sort -u"
alias lsof-inet="lsof -i -U"
alias lsof-open-owners="lsof -i -P | grep -i 'listen'"
alias resmem="ps -Aely --sort:rss | awk '{print \$NF\": \"\$8/1024\" MB\"}' | column -t"  # http://www.commandlinefu.com/commands/view/9847/find-and-sort-by-resident-size-of-each-process-on-the-system-in-mb
alias topmem="ps -eo rss,pid,user,command --sort -rss | tail -n +2 | head -n \$1"
alias top="top -c"
alias psnow="ps auxf | egrep --color=always --context=10 \$@"

#######################
##### FIND / GREP #####
#######################

alias big='BIG () { find . -size +${1}M -ls; }; BIG $1' # http://www.commandlinefu.com/commands/view/8054/find-large-files-in-current-directory
alias cgrep="egrep --color=always"
alias findbrokensym="find -L . -type l" # http://www.commandlinefu.com/commands/view/8260/find-broken-symlinks
alias hgrep="history | cgrep -i $1"
alias lsdir="find . -maxdepth 1 -type d -not -name '.'"
alias wgnc="wcgrep-base --color=never"
alias wg="wcgrep-base --color=always"
alias higrep="egrep --color=always --context=10000"
function findnew() {
    # http://stackoverflow.com/questions/5566310/how-to-recursively-find-and-list-the-latest-modified-files-in-a-directory-with-s
  find $1 -type f -exec stat --format "%Y :%y %n" {} \; | sort -nr | cut -d: -f2- | head ${@:2}
}
function md5dir() {
    find $1 -not -regex ".*\.git/\(index\|COMMIT_EDITMSG\|modules/\).*" -exec md5sum --binary {} \; 2>&1 | md5sum - | awk '{ print $1 }'
}

######################
##### APT / DPKG #####
######################

alias dpkgfind="dpkg -l | cgrep -i $1"
alias dpkghistory="tail -n 1000 | less /var/log/dpkg.log"
alias dpkginstalled="dpkg --get-selections | grep -v deinstall"
alias dpkgls="dpkg -L $1"
alias dpkgowner="dpkg -S $1"
alias aptupdateall="pushd . >/dev/null && cd /tmp && sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade && popd >/dev/null"

#######################
##### RSYNC / SSH #####
#######################

alias rsync-resume="rsync --partial"  # Resumes incomplete scp operation.

#######################
##### CURL / WGET #####
#######################

alias curl-find-ca-bundle="curl-config --ca"
alias dl="curl --location --max-redirs 5 --proto-default https --proto-redir '=https' --remote-name --remote-header-name"
function curl-final-url {
  curl -I --silent --location --max-redirs 10 -w "%{url_effective}\n" "$1" | tail -n 1
}

################
##### MISC #####
################

alias cdzshlocal="cd ~/zsh/local"
alias resetfonts="sudo fc-cache -fv"
alias rm="rm -i"
alias vimsafe="vim -RMm"
alias zshrc="vim ~/.zshrc; sleep 1; source ~/.zshrc"
alias ccat="pygmentize -g"
alias make="/usr/bin/env make --warn-undefined-variable --no-print-directory"
alias tad="tmux attach -d"

# Evaluate aliases before passing command to sudo
alias sudo='sudo '


