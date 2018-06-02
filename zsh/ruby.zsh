echo "Loading $0"

# To avoid gem installation that requires sudo.
# See "Installing RubyGems in a User Directory" http://docs.rubygems.org/
export RUBY_PREFIX="$HOME/opt/ruby"
export GEM_HOME="$RUBY_PREFIX/gems"
export GEM_PATH=$GEM_HOME

alias ruby-gem-path="ruby -r rubygems -e 'p Gem.path'"
