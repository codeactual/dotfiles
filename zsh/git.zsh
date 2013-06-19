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
alias gba='git branch -a'                                           # Include remote-tracking and local.
alias gbnmm="git branch --no-merged master"                         # List branches not yet merged into master.
alias gci='git commit -v'                                           # Verbose commit.
alias gcin='git commit -v --no-verify'
alias gcatchup="git fetch && git rebase origin/master"              # Catch up local snapshot of origin/master. But don't modify local master.
alias gcopatch='git checkout --patch'
alias gcp="git cherry-pick --no-commit"
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
alias gg="git grep --line-number --show-function --context=4 --heading --color=always"
alias gi="git info"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset %C(yellow)%an%d%Creset %s %Cgreen(%cr)%Creset' --date=relative"
alias gla="git log --all --graph --pretty=format:'%Cred%h%Creset %C(yellow)%an%d%Creset %s %Cgreen(%cr)%Creset' --date=relative"
alias glc="git log --stat -n 1"                                     # Log of last commit.
alias gld="git log -- \$1"                                          # Search log for a deleted path.
alias glf="git log --follow -p"                                     # Search log for changes to a path w/ diffs.
alias gln="git log --name-status"
alias glp="git log -p -40 | vim - -R -c 'set foldmethod=syntax' -O1"
alias glmi="git log --name-status origin/master \^master"
alias glmo="git log --name-status master \^origin/master"
alias glsfi="git ls-files --others -i --exclude-standard"            # Ignore files.
alias glsfm="git ls-files -m"                                        # Modified files.
alias glst="git log --stat"
alias glsu="git ls-files -o --exclude-standard"                     # Untracked files.
alias glt="git log --graph --decorate --branches --pretty=oneline"  # Timeline.
alias gm="git merge --no-ff --no-commit"
alias gmv='git mv'
alias gp='git push'
alias gpu='git fetch origin -v; git fetch upstream -v; git merge upstream/master' # http://gitready.com/intermediate/2009/02/12/easily-fetching-upstream-changes.html
alias gs='git status'
alias gss='git status -sb'
alias gsh='git stash'
alias gsha='git stash apply'                                        # Like pop but w/out modifying stash list.
alias gu="git reset HEAD"                                           # Unstage.

# Delete the last line to undo the last commit.
# To restage the undone commit for correction, gcp <hash from removed line>.
# Rebase target wrapped in quotes for zsh.
alias gundorebase="git rebase -i 'HEAD^^'"

alias gundoreset="git reset --soft 'HEAD^'"

# Check out a new timestamped branch.
function gcob {
  local date=`date "+%Y-%m-%d"`

  # Ex. fix-tests-2012-12-17
  local branch="$1-$date"

  # Append all remaining arguments, ex. source branch name.
  git checkout -b $branch ${@:2}

  save_current_git_branch $branch
}

function gitCheckout {
  git checkout $1
  save_current_git_branch $1
}

function gcom {
  gitCheckout "master"
}

function gcop {
  gitCheckout $GIT_PREVIOUS_BRANCH
}

function save_current_git_branch {
  export GIT_PREVIOUS_BRANCH=$GIT_CURRENT_BRANCH
  export GIT_CURRENT_BRANCH=$1
}

function gmp {
  echo "Merging $GIT_PREVIOUS_BRANCH into $GIT_CURRENT_BRANCH"
  gm $GIT_PREVIOUS_BRANCH
}

function gcat {
  local FILE=$1
  local BRANCH_OR_COMMIT=$2
  git show $BRANCH_OR_COMMIT:$FILE
}

function glfromtag {
  gl $1.. | sed 's/\* [a-z0-9]\+ \((HEAD, master) \)\?//g'
}
