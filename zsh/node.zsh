echo "Loading $0"

# https://twitter.com/thl0/status/347923557508063235
alias lnpm='npm --no-registry'

function ganodemodules {
  local EXT=".*\.\(yml\|ttf\|md\|html\|css\|.*ignore\|gitmodules\|eot\|otf\|woff\|png\|gif\|txt\|zip\|gz\)$"
  local DIRS=".*/\(tests?\|examples?\|specs?\|fonts?\|docs?\)/.*"
  local EXACT=".*/\(Gruntfile.*\|Makefile\|test.js\|component.json\)$"
  find ./node_modules -type f -not -regex $EXT -not -iregex $DIRS -not -iregex $EXACT -exec git add {} \;
}
