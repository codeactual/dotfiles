" my filetype file
    if exists("did_load_filetypes")
      finish
    endif
    augroup filetypedetect
      au BufRead,BufNewFile **/fpath/* setfiletype zsh|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au BufRead,BufNewFile *.zsh setfiletype zsh|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    *.yaml,*.yml         setfiletype yaml|set softtabstop=2|set tabstop=2|set shiftwidth=2|set nonumber
      au! BufRead,BufNewFile    *.md         setfiletype mkd|set softtabstop=2|set tabstop=2|set shiftwidth=2|set nonumber
      au! BufRead,BufNewFile    *.go         setfiletype go|set softtabstop=4|set tabstop=4|set shiftwidth=4|set nonumber
      au! BufRead,BufNewFile    *.py         setfiletype python|set softtabstop=4|set tabstop=4|set shiftwidth=4|set nonumber
      au! BufRead,BufNewFile    *.phtml         setfiletype php|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    *.html         setfiletype html|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    *.css         setfiletype css|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    *.js         setfiletype javascript|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    *.json         setfiletype json|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    *.handlebars         setfiletype html|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    *.php           setfiletype php|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    *.php-dist      setfiletype php|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    *.wiki          setfiletype text|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufRead,BufNewFile    php-fpm.conf          setfiletype dosini|set softtabstop=2|set tabstop=2|set shiftwidth=2
      au! BufReadPost           /tmp/crontab.*  set backupcopy=yes
      au BufRead,BufNewFile     */nginx/* if &ft == '' | setfiletype nginx | endif
      au BufRead,BufNewFile     */\(etc\|conf\)d/*.conf if &ft == '' | setfiletype toml | endif
    augroup END
