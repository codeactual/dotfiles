echo "Loading $0"

#####################
##### LS / TREE #####
#####################

alias ll="ls -l --almost-all --color=always --classify --time-style=long-iso --human-readable"
alias lsbigdir="perl -le 'opendir DIR, \".\" or die; print while \$_ = readdir DIR; closedir DIR'" # http://www.commandlinefu.com/commands/view/8227/listing-directory-content-of-a-directory-with-a-lot-of-entrie
alias tt='tree -pFCfa -I ".git" . | grep "$1" | less -RgIKNs'

###############################
##### LSOF / NETSTAT / PS #####
###############################

alias connected_ips="netstat -lantp | grep ESTABLISHED |awk '{print \$5}' | awk -F: '{print \$1}' | sort -u"
alias lsof-inet="lsof -i -U"
alias lsof-open-owners="lsof -i -P | grep -i 'listen'"
alias resmem="ps -Aely --sort:rss | awk '{print \$NF\": \"\$8/1024\" MB\"}' | column -t"  # http://www.commandlinefu.com/commands/view/9847/find-and-sort-by-resident-size-of-each-process-on-the-system-in-mb
alias top="top -c"

#######################
##### FIND / GREP #####
#######################

alias big='BIG () { find . -size +${1}M -ls; }; BIG $1' # http://www.commandlinefu.com/commands/view/8054/find-large-files-in-current-directory
alias cgrep="egrep --color=always"
alias findbrokensym="find -L . -type l" # http://www.commandlinefu.com/commands/view/8260/find-broken-symlinks
alias hgrep="history | cgrep -i $1"
alias lsdir="find . -maxdepth 1 -type d -not -name '.'"
alias wcgrep-nocolor="wcgrep-base --color=never"
alias wcgrep="wcgrep-base --color=always"

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
alias dl="wget --max-redirect 5 --no-cookies"

################
##### MISC #####
################

alias resetfonts="sudo fc-cache -fv"
alias rm="rm -i"
alias vim="vim -O3"
alias vimsafe="vim -RMm"
alias zshrc="vim ~/.zshrc; sleep 1; source ~/.zshrc"
