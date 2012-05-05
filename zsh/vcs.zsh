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
alias gco='git checkout'
alias gci='git commit -v'                                                          # Verbose commit.
alias gcatchup="git fetch && git rebase origin/master"                            # Catch up local snapshot of origin/master. But don't modify local master.
alias gcop='git checkout --patch'
alias gd='git diff'
alias gda="git diff; git diff --cached"
alias gdc="git diff --cached"
alias gdv='git diff | $EDITOR -R - '
alias gl='git log --oneline --graph --decorate'
alias gld="git log -- \$1"                                                        # Search log for a deleted path.
alias gmv='git mv'
alias gp='git push'
alias gs='git status'
alias gss='git status -sb'
alias gsh='git stash'
alias gsha='git stash apply'                                                       # Like pop but w/out modifying stash list.

################
##### SVN ######
################

function svndiff {
  svn diff $1 | vim -R -
}