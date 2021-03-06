echo "Loading $0"

# For .gitignore debugging (for 2.9.2+)
export GIT_TRACE_EXCLUDE=1

# Prepend `git` commands with GIT_TRACE=1 for verbose/debug output.

# Based on http://justinlilly.com/dotfiles/zsh.html
alias g=git
alias ga='git add'
alias gaa='git add --all'
alias gamend="git commit --amend"                                   # Amend last commit.
alias gap='git add --patch'
alias gcheckpoint='git stash && git stash apply'                            # http://stackoverflow.com/questions/1981830/undo-part-of-unstaged-changes-in-git
alias gble="git blame -CwM"                                           # C: blame last editor (not last mover/copier); w: ignore whitespace; M: ignore moving text
alias gb='git branch'
alias gbr='git branch -r'
alias gba='git branch -a'                                           # Include remote-tracking and local.
alias gbnmm="git branch --no-merged master"                         # List branches not yet merged into master.
alias gci='git commit -v'                                           # Verbose commit.
alias gcin='git commit -v --no-verify'
alias gcatchup="git fetch && git rebase origin/master"              # Catch up local snapshot of origin/master. But don't modify local master.
alias gcopatch='git checkout --patch'
alias gcp="git cherry-pick --no-commit"
alias gda="gd; gd --cached"
alias gdaw="gdw; gdcw"
alias gdc="gd --cached"
alias gdcw="gd --cached --word-diff"
alias gdl="gd HEAD\^ HEAD"                                    # Diff from last commit.
alias gdsl="git diff --stat HEAD\^ HEAD"
alias gdlp="git log -n1 -p -- \$1"
alias gddi="gd origin/develop \^develop"
alias gddo="gd develop \^origin/develop"
alias gdv='gd | $EDITOR -R - '
alias gdw="gd --word-diff"
alias gi="git info"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset %C(yellow)%an%d%Creset %s %Cgreen%cD (%cr)%Creset'"
alias glns="gl --name-status"
alias gla="git log --all --graph --pretty=format:'%Cred%h%Creset %C(yellow)%an%d%Creset %s %Cgreen%cD (%cr)%Creset'"
alias glans="gla --name-status"
alias glc="git log --stat -n 1"                                     # Log of last commit.
alias gld="git log -- \$1"                                          # Search log for a deleted path.
alias glf="git log --follow -p"                                     # Search log for changes to a path w/ diffs.
alias gln="git log --name-status"
alias glp="git log -p -40 | vim - -R -c 'set foldmethod=syntax' -O1"
alias glsfi="git ls-files --others -i --exclude-standard"            # Ignore files.
alias glsfm="git ls-files -m"                                        # Modified files.
alias glst="git log --stat"
alias glsu="git ls-files -o --exclude-standard"                     # Untracked files.
alias glt="git log --graph --decorate --branches --pretty=oneline"  # Timeline.
alias gm="git merge --no-ff --no-commit"
alias gmv='git mv'
alias gp='git push'
alias gpu='git fetch origin -v; git fetch upstream -v; git merge upstream/master' # http://gitready.com/intermediate/2009/02/12/easily-fetching-upstream-changes.html
alias grmmerged="git branch --merged | awk '{print \$1}' | xargs git branch -d"
alias gs='git status'
alias gss='git status -sb'
alias gsh='git stash'
alias gsha='git stash apply'                                        # Like pop but w/out modifying stash list.
alias gshol='git show HEAD'
alias gu="git reset HEAD"                                           # Unstage.

# Delete the last line to undo the last commit.
# To restage the undone commit for correction, gcp <hash from removed line>.
# Rebase target wrapped in quotes for zsh.
alias gundorebase="git rebase -i 'HEAD^^'"

alias gundoreset="git reset --soft 'HEAD^'"

# Check out a new timestamped branch.
function gcob {
  if [ -z "${1}" ]; then
    echo "branch suffix required"
    exit 1
  fi

  local date=`date "+%Y_%m_%d"`

  # Ex. 2012_12_17_fix_tests
  local branch="${date}_$1"

  # Append all remaining arguments, ex. source branch name.
  git checkout -b $branch ${@:2}
}

function gitCheckout {
  git checkout $1
}

function gcat {
  local FILE=$1
  local BRANCH_OR_COMMIT=$2
  git show $BRANCH_OR_COMMIT:$FILE
}

function glfromtag {
  gl $1.. | sed 's/\* [a-z0-9]\+ \((HEAD, master) \)\?//g'
}

function get_current_branch {
  local CUR_BRANCH=`git branch 2>/dev/null| sed -n '/^\*/s/^\* //p'`
  echo $CUR_BRANCH
}

function gdo {
  CUR_BRANCH=$(get_current_branch)
  gd $@ $CUR_BRANCH \^origin/$CUR_BRANCH
}

function gdoi {
  CUR_BRANCH=$(get_current_branch)
  gd $@ \^origin/$CUR_BRANCH $CUR_BRANCH
}

function glo {
  CUR_BRANCH=$(get_current_branch)
  git log $@ --name-status $CUR_BRANCH \^origin/$CUR_BRANCH
}

function gloi {
  CUR_BRANCH=$(get_current_branch)
  git log $@ --name-status \^origin/$CUR_BRANCH $CUR_BRANCH
}

# Ex. find which branch a commit came from, which branches have it,
# what commit merged it in, etc.
function gtracecommit {
  FROM=`git reflog show --all | grep $1`

  if [ -z "$FROM" ]; then
    echo "Not found."
    return
  fi

  IN=`git branch --contains $1`
  MERGED=`git log --merges $1`
  echo "[Added to repo]\n$FROM"
  echo "---------------------"
  echo "[Present in branch(es)]\n$IN"
  echo "---------------------"
  echo "[Merged into other branch(s) via]\n$MERGED"
}

function gdln {
  OUTPUT=`git --no-pager diff HEAD~$1 HEAD`
  OUTPUT+="\n\n"
  OUTPUT+="Showed changes from these last $1 commits\n"
  OUTPUT+=`git log --oneline -$1`
  echo $OUTPUT | vim -
}

function gpob {
  git push -u origin `get_current_branch`
}

function ggreplog {
  clear_term_if_tmux

  git rev-list --all --format="%Cgreen%cD (%cr)%Creset %C(yellow)%an%d%Creset %C(white dim)%H%Creset %n%B" | grep -v "^commit.*$" | grep --color=always --context=10 "$@" | less --RAW-CONTROL-CHARS --quit-if-one-screen --no-init
}

function hr {
  # http://wiki.bash-hackers.org/snipplets/print_horizontal_line
  printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

function ggrepcontent_main {
  clear_term_if_tmux

  GREP_COLOR="01;35" # purple/magenta

  for hash in `git rev-list --all`; do
    # Detect first-commits to avoid `git diff` error.
    # There is likely a faster command/flag combo to get the same desired output (exit code).
    git show --no-notes --no-patch "${hash}^" > /dev/null 2>&1

    if [ $? -eq 0 ]; then
      grepout=`git diff "${hash}^" "${hash}" | GREP_COLOR="${GREP_COLOR}" grep --context=10 --color=always "$@" 2>&1`
      grepexit=$?
      grepout=`echo "$grepout" | diff-highlight | strip_diff_leading_symbols`
    else
      grepout=`git show "${hash}" | GREP_COLOR="${GREP_COLOR}" grep --context=10 --color=always "$@" 2>&1`
      grepexit=$?
    fi

    if [ $grepexit -eq 0 ]; then
      hr
      git show --quiet --format=medium ${hash}
      echo "${grepout}"
    fi
    break
  done
}

function ggrepcontent {
  #ggrepcontent "$@" | less --RAW-CONTROL-CHARS --quit-if-one-screen --no-init
  ggrepcontent_main "$@"
}

function ggrepnames {
  # xargs git grep --color=always "$@" | less --RAW-CONTROL-CHARS --quit-if-one-screen --no-init
}

function gcisame {
  local msg=`git log -1 --pretty=format:%s`
  gci -m "${msg}" "$@"
}
