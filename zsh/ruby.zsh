echo "Loading $0"

# To avoid gem installation that require sudo.
# Based on current "Installing RubyGems in a User Directory" http://docs.rubygems.org/
export GEM_HOME="~/gems"

alias ruby-gem-path="ruby -r rubygems -e 'p Gem.path'"
