" Based on .vimrc by:
"   Tobias Schlitt <toby@php.net>
"   Ciaran McCreesh <ciaranm at gentoo.org>
"   https://github.com/myusuf3/dotfiles/blob/master/vimrc

" Remove any trailing whitespace that is in the file
autocmd BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" viminfo
" '0: don't save marks
" f0: don't save marks
" <0: don't save registers
set viminfo='0,f0,<0

set term=xterm-256color
set termencoding=utf-8

" http://nvie.com/posts/how-i-boosted-my-vim/
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set title                " change the terminal's title
set noerrorbells         " don't beep

set modelines=0
set nomodeline

" Search case-insensitive by default ...
set ignorecase
" ... when the query contains no upper-case
set smartcase

" Disable visual bell
set noeb vb t_vb=

set nofoldenable

" Highlight search matches (original fg, dark grey bg)
hi Search cterm=NONE ctermfg=white ctermbg=darkgrey

" Highlight visual mode selections (original fg, dark grey bg)
hi Visual cterm=NONE ctermfg=white ctermbg=darkgrey

" Highlight incremental serach matches (white fg, dark grey bg)
hi IncSearch cterm=NONE ctermfg=white ctermbg=blue

" Highlight line numbers
hi LineNr cterm=NONE ctermfg=239 ctermbg=black
hi CursorLineNr cterm=NONE ctermfg=244 ctermbg=black

" Highlight line
set cursorline
hi CursorLine cterm=NONE ctermfg=NONE ctermbg=235
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Location list paths (match prompt color for cwd)
hi Directory cterm=NONE ctermfg=magenta ctermbg=black

" tildes
hi NonText cterm=none ctermfg=233 ctermbg=black

" Easier to read exact error/warning sites marked by syntastic which
" links Spell* groups to its own in plugin/syntastic/highlighting.vim
hi SpellCap cterm=NONE ctermfg=NONE ctermbg=236
hi SpellBad cterm=NONE ctermfg=NONE ctermbg=236

" Less distracting when syntastic signs are present
hi SignColumn cterm=NONE ctermfg=4 ctermbg=black

hi comment ctermfg=darkgray
hi string cterm=NONE ctermfg=136 ctermbg=NONE

" Change the autocompletion menu colors
hi Pmenu cterm=NONE ctermfg=red ctermbg=black
hi PmenuSel cterm=NONE ctermfg=green ctermbg=black

" Highlight only the character that marks the line-length limit boundary.
hi ColorColumn cterm=none ctermfg=242 ctermbg=NONE

" Reduce veritical split visibility
hi VertSplit cterm=NONE ctermfg=black ctermbg=black
" (Bottom of the vertical split)
hi StatusLine cterm=NONE ctermfg=black ctermbg=black
hi StatusLineNC cterm=NONE ctermfg=black ctermbg=black

" Increase readability of quickfix lines
hi qfFileName cterm=NONE ctermfg=lightgray ctermbg=NONE
hi qfSeparator cterm=NONE ctermfg=black ctermbg=NONE
hi qfLineNr cterm=NONE ctermfg=darkgreen ctermbg=NONE
hi qfError cterm=NONE ctermfg=darkgray ctermbg=NONE

" Increase readability of gitcommit
hi diffAdded cterm=NONE ctermfg=green ctermbg=NONE
hi diffRemoved cterm=NONE ctermfg=red ctermbg=NONE
hi diffSubName cterm=NONE ctermfg=darkgrey ctermbg=NONE
hi diffFile cterm=NONE ctermfg=cyan ctermbg=NONE
hi gitcommitComment cterm=NONE ctermfg=234 ctermbg=NONE
hi gitcommitOnBranch cterm=NONE ctermfg=234 ctermbg=NONE
hi gitcommitHeader cterm=NONE ctermfg=234 ctermbg=NONE
hi gitcommitBranch cterm=NONE ctermfg=cyan ctermbg=NONE
hi gitcommitType cterm=NONE ctermfg=white ctermbg=NONE
hi gitcommitSelectedFile cterm=NONE ctermfg=cyan ctermbg=NONE
hi gitcommitUntrackedFile cterm=NONE ctermfg=gray ctermbg=NONE
hi gitcommitSummary cterm=NONE ctermfg=cyan ctermbg=NONE

" Reduce tab bar distraction
hi TabLineFill cterm=NONE ctermfg=NONE ctermbg=NONE
hi TabLine cterm=NONE ctermfg=234 ctermbg=NONE
hi TabLineSel cterm=NONE ctermfg=white ctermbg=NONE
" (For the per-tab window counter. However other styles, ex. m {arkdown, will inherit
" from Title for headings.)
hi Title cterm=NONE ctermfg=darkgray ctermbg=NONE

" Reduce color variation in markdown
hi mkdCode cterm=NONE ctermfg=136 ctermbg=NONE
hi mkdURL cterm=NONE ctermfg=136 ctermbg=NONE
hi mkdInlineURL cterm=NONE ctermfg=136 ctermbg=NONE
hi mkdLink cterm=NONE ctermfg=136 ctermbg=NONE
hi mkdDelimiter cterm=NONE ctermfg=136 ctermbg=NONE

hi MatchParen cterm=none ctermbg=242 ctermfg=NONE

" Print syntax highlighting group used at cursor
" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" turn off any existing search
au VimEnter * nohls

set fenc=utf-8
set fencs=utf-8
set encoding=utf-8

" Allow future highlights
set hlsearch

" Don't create backups
set nobackup
set nowritebackup
set noswapfile

" Make backspace delete lots of things
set backspace=indent,eol,start

" Allow edit buffers to be hidden
set hidden

set autoindent
set smartindent
set smarttab

" Set standard setting for PEAR coding standards
set tabstop=2
set shiftwidth=2

" Auto expand tabs to spaces
set expandtab
set softtabstop=2

" Linewidth to endless
set textwidth=0

" Show cursor position in lower-right corner
set ruler

" Searching
set incsearch

" Allow edit buffers to be hidden
set hidden

" Jump 4 lines when running out of the screen
set scrolljump=4

" Indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=3

" Correct indentation after opening a phpdocblock and automatic * on every
" line
set formatoptions=qroct

" Disable F1 help
nmap <F1> <nop>

" Switch to the Buffer Explorer list
map <C-\> :BufExplorer<CR>

" Switch to previous/next tab.
map <C-J> :tabprev<CR>
map <C-K> :tabnext<CR>

" Disable incrementing/decrementing numbers in the current line.
nmap <C-A> <nop>
nmap <C-X> <nop>
set nrformats=

" ctrlp plugin configuration
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'find %s -not -regex ".*\/vendor.*" -not -regex ".*\/\..*\/.*" -not -regex ".*\/coverage.*" -not -regex ".*\/log.*" -not -regex ".*\/tmp.*" -not -regex ".*\/cache.*" -not -regex ".*\.min\..*" -not -regex ".*\/target.*" -not -regex ".*\/dist.*" -not -regex ".*SNAPSHOT.*" -not -regex ".*\/release.*" -not -regex ".*\/jsgen.*" -not -regex ".*\/node_modules.*" -not -regex ".*\/components.*" -not -regex ".*\/instrumented.*" -type f'
map <C-O> :CtrlPClearCache<CR>
"
" Reduce default 1s delay so ctrlp-p window opens faster.
set timeoutlen=200

" Toggle tag bar
map <C-T> :Tagbar<CR>

" Toggle line numbers.
nmap <C-N> :set invnumber<CR>

syntax enable

filetype plugin indent on

let $VIMRUNTIME = "~/.vim"

let g:tagbar_width = 30
let g:tagbar_left = 1
let g:tagbar_autofocus = 1

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

abbreviate teh the
abbreviate whitesapce whitespace
abbreviate sapce space
abbreviate stirng string
abbreviate expection exception
abbreviate Expection Exception

execute pathogen#infect()

" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable built-in manual keyword lookup
map <S-K> <nop>

" vim-session
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 5
let g:session_autosave_silent = 'yes'
let g:session_command_aliases = 1
" skip globals
set sessionoptions-=globals
" skip manually created folds
set sessionoptions-=folds
" skip blank windows
set sessionoptions-=blank
" skip options/mappings
set sessionoptions-=options
set sessionoptions-=localoptions
" skip help windows
set sessionoptions-=help

" BufExplorer
"
" Ex. to deal with index.js files from many modules
let g:bufExplorerSplitOutPathName = 0

" Always show the status bar (vs. only when viewing multiple files).
set laststatus=2

" Opens the split in a new tab. Kind like 'distraction free' mode. (f)
" https://github.com/Wolfy87/vim-config/commit/707e062fe1fb756c84aa3ffe7b0652c4a0676970
nmap <leader>f :tab sp<CR>
nmap <leader>c :tabclose<CR>

" Clear highlighting on escape in normal mode
" http://stackoverflow.com/a/1037182
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

set lazyredraw

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_yaml_checkers = ['yamlxs']
let g:syntastic_python_flake8_args='--ignore=E901'
let g:syntastic_aggregate_errors = 1
" Don't conflict with vim-go/gometalinter checks
let g:syntastic_go_checkers = []
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" syntastic-compatible way to close a buffer and its location list
nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
cabbrev <silent> bd lclose\|bdelete

" Move to the next error/warning cite
nmap <C-L> :lne<CR>

" Change the cwd to the file's
nmap <C-C> :cd %:p:h<CR>

" python-mode
"
" Disable default behavior of enabling line numbers
" (https://github.com/klen/python-mode/issues/356#issuecomment-33260767)
autocmd FileType python setlocal nonumber

" vim-go
nmap <C-G> :GoImports<CR>
"
" Avoid flashes of red because gofmt, plus the whitespace-trimming BufWrite
" in this file, will fix any leading/trailing extra-space issues.
hi goSpaceError cterm=NONE ctermfg=NONE ctermbg=NONE

" YouCompleteMe
"
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
" Prevent pane from popping up with the same signature info as the
" autocompletion content.
set completeopt-=preview
let g:ycm_add_preview_to_completeopt =  0
" Match the version YCM was compiled in.
let g:ycm_server_python_interpreter = '/usr/bin/python2'

" gundo
nmap <leader>g :GundoToggle<CR>

" Ex. in python add space after each '#' to avoid lint warnings.
let g:NERDSpaceDelims = 1

let local_vimrc_path = $HOME . "/.vimrc.local"
if filereadable(local_vimrc_path)
    exec "source " . local_vimrc_path
endif

" https://gist.github.com/skanev/1068214
command! CloseHiddenBuffers call s:CloseHiddenBuffers()
function! s:CloseHiddenBuffers()
  let open_buffers = []

  for i in range(tabpagenr('$'))
    call extend(open_buffers, tabpagebuflist(i + 1))
  endfor

  for num in range(1, bufnr("$") + 1)
    if buflisted(num) && index(open_buffers, num) == -1
      exec "bdelete ".num
    endif
  endfor
endfunction
