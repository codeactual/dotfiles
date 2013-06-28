echo "Loading $0"

NODE_MODULES_CWD_BIN_PATH=./node_modules/.bin
NODE_MODULES_HOME_BIN_PATH=$HOME/bin/node_modules/.bin
NODE_MODULES_GLOBAL_BIN_PATH=/usr/local/node/bin

export PATH=$PATH:$NODE_MODULES_CWD_BIN_PATH:$NODE_MODULES_HOME_BIN_PATH:$NODE_MODULES_GLOBAL_BIN_PATH

# https://twitter.com/thl0/status/347923557508063235
alias lnpm='npm --no-registry'
