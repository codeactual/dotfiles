echo "Loading $0"

################
##### GIT ######
################

# Based on http://justinlilly.com/dotfiles/zsh.html
alias g=git
alias ga='git add'
alias gap='git add --patch'
alias gb='git branch'
alias gba='git branch -a'                                                         # Include remote-tracking and local.
alias gc='git commit -v'                                                          # Verbose commit.
alias gcatchup="git fetch && git rebase origin/master"                            # Catch up local snapshot of origin/master. But don't modify local master.
alias gcp='git checkout --patch'
alias gd='git diff | $EDITOR -'
alias gda="git diff; git diff --cached"
alias gl='git pull'
alias gld="git log -- \$1"                                                        # Search log for a deleted path.
alias gmv='git mv'
alias gp='git push'
alias gs='git stash'
alias gsa='git stash apply'                                                       # Like pop but w/out modifying stash list.

################
##### SVN ######
################

function svndiff {
  svn diff $1 | vim -R -
}
