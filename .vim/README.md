# vim-go

## update vimscripts for github.com/nsf/gocode

- Review https://github.com/nsf/gocode#manual-installation in case the dependencies have changed.

dl -O ~/.vim/autoload/gocomplete.vim https://raw.githubusercontent.com/nsf/gocode/SOME_TAG_OR_SHA/vim/autoload/gocomplete.vim
mkdir -p ~/.vim/ftplugin/go
dl -O ~/.vim/ftplugin/go/gocomplete.vim https://raw.githubusercontent.com/nsf/gocode/SOME_TAG_OR_SHA/vim/ftplugin/go/gocomplete.vim
