if [ `uname` = 'Darwin' ]; then
  echo "Loading $0"
  alias hiddenoff="defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder"
  alias hiddenon="defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder"
else
  echo "Skipping $0"
fi
