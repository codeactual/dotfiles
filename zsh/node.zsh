echo "Loading $0"

# https://twitter.com/thl0/status/347923557508063235
alias lnpm='npm --no-registry'

function ganodemodules {
  local EXT=".*\.\(yml\|ttf\|md\|markdown\|html\|css\|.*ignore\|gitmodules\|eot\|otf\|woff\|png\|gif\|txt\|zip\|gz\|.*~.*\|el\|.*intrc\|old\|bak\|orig\|min\.js\|cc?\|gnu\|log\)$"
  local DIRS=".*/\(tests?\|examples?\|specs?\|fonts?\|docs?\|man\)/.*"
  local EXACT=".*/\(\(grunt\|gulp\|.*ake\)file.*\|\(component\|bower\).json\|CONTRIBUTORS\|.*-min\.js\|build\)$"
  find ./node_modules -type f -not -regex $EXT -not -iregex $DIRS -not -iregex $EXACT -exec git add {} \;
}
