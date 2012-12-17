echo "Loading $0"

# Prevents finding of /bin/ss in path
alias sa="svn add"
alias sci="svn commit"
alias sco="svn checkout"
alias sd="svndiff"
alias sl="svn log --verbose --limit \$1"
alias ss="svn status"

function svndiff {
  svn diff $@ | vim - -R -O1
}

