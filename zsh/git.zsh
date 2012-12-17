echo "Loading $0"

# Prepend `git` commands with GIT_TRACE=1 for verbose/debug output.

# Based on http://justinlilly.com/dotfiles/zsh.html
alias g=git
alias ga='git add'
alias gamend="git commit --amend"                                   # Amend last commit.
alias gap='git add --patch'
alias gble="git blame -C"                                           # Blame last editor (not last mover/copier).
alias gb='git branch'
alias gbr='git branch -r'
alias gba='git branch -a'                                          # Include remote-tracking and local.
alias gco='git checkout'
alias gci='git commit -v'                                           # Verbose commit.
alias gcatchup="git fetch && git rebase origin/master"              # Catch up local snapshot of origin/master. But don't modify local master.
alias gcop='git checkout --patch'
alias gd='git diff'
alias gda="git diff; git diff --cached"
alias gdaw="gdw; gdcw"
alias gdc="git diff --cached"
alias gdcw="git diff --cached --word-diff"
alias gdl="git diff HEAD\^ HEAD"                                    # Diff of last commit.
alias gdmi="git diff origin/master \^master"
alias gdmo="git diff master \^origin/master"
alias gddi="git diff origin/develop \^develop"
alias gddo="git diff develop \^origin/develop"
alias gdv='git diff | $EDITOR -R - '
alias gdw="git diff --word-diff"
alias gi="git info"
alias gl='git log --oneline --graph --decorate'
alias glc="git log --stat -n 1"                                     # Log of last commit.
alias gld="git log -- \$1"                                          # Search log for a deleted path.
alias glf="git log --follow -p"                                     # Search log for changes to a path w/ diffs.
alias gln="git log --name-status"
alias glp="git log -p -40 | vim - -R -c 'set foldmethod=syntax' -O1"
alias glmi="git log --name-status origin/master \^master"
alias glmo="git log --name-status master \^origin/master"
alias glsi="git ls-files --others -i --exclude-standard"            # Ignore files.
alias glsm="git ls-files -m"                                        # Modified files.
alias glsu="git ls-files -o --exclude-standard"                     # Untracked files.
alias glt="git log --graph --decorate --branches --pretty=oneline"  # Timeline.
alias gm="git merge --no-commit"
alias gmv='git mv'
alias gp='git push'
alias gs='git status'
alias gss='git status -sb'
alias gsh='git stash'
alias gsha='git stash apply'                                        # Like pop but w/out modifying stash list.
alias gu="git reset HEAD"                                           # Unstage.
