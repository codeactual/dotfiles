" my filetype file
    if exists("did_load_filetypes")
      finish
    endif
    augroup filetypedetect
      au! BufRead,BufNewFile    *.py         setfiletype python|set softtabstop=4|set tabstop=4|set shiftwidth=4
      au! BufRead,BufNewFile    *.phtml         setfiletype php|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    *.html         setfiletype html|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    *.css         setfiletype css|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    *.js         setfiletype javascript|set softtabstop=2|set tabstop=2|set shiftwidth=2|set dictionary+=$HOME/.vim/bundle/vim-node/dict/node.dict
      au! BufRead,BufNewFile    *.php           setfiletype php|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    *.php-dist      setfiletype php|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    *.wiki          setfiletype text|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    php-fpm.conf          setfiletype dosini|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufReadPost           /tmp/crontab.*  set backupcopy=yes
    augroup END
