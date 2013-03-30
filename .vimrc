" Based on .vimrc by:
"   Tobias Schlitt <toby@php.net>
"   Ciaran McCreesh <ciaranm at gentoo.org>
"   https://github.com/myusuf3/dotfiles/blob/master/vimrc

" Remove any trailing whitespace that is in the file
autocmd BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" http://nvie.com/posts/how-i-boosted-my-vim/
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set title                " change the terminal's title
set noerrorbells         " don't beep

" Disable visual bell
set noeb vb t_vb=

set nofoldenable

" Highlight search matches (original fg, dark grey bg)
hi Search cterm=NONE ctermfg=white ctermbg=darkgrey

" Highlight visual mode selections (original fg, dark grey bg)
hi Visual cterm=NONE ctermfg=white ctermbg=darkgrey

" Highlight incremental serach matches (white fg, dark grey bg)
hi IncSearch cterm=NONE ctermfg=white ctermbg=238

" Highlight line numbers
hi LineNr cterm=NONE ctermfg=234 ctermbg=black

hi MatchParen cterm=none ctermbg=darkgrey ctermfg=white

" Set some syntax highlight colors
hi comment ctermfg=lightblue
hi constant ctermfg=darkred

" Change the autocompletion menu colors
hi Pmenu ctermfg=lightgray ctermbg=black
hi PmenuSel ctermfg=black ctermbg=lightgray

" turn off any existing search
au VimEnter * nohls

set tags=~/.vim/mytags/all

set fenc=utf-8
set encoding=utf-8

" Allow future highlights
set hlsearch

" q: sucks
nmap q: :q

" Shortcuts
nmap tn :tabnew

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

" Highlight matching parens
set showmatch

" Searching
set incsearch

" Use the cool tab complete menu
set wildmenu
set wildignore=*.bak,*.bz2,*.class,*.gif,*.git,*.gz,*.jar,*.jpg,*.lock,*.log,*.o,*.png,*.pyc,*.so,*.svn,*.swp,*.tgz,*.tmp,*.zip,*~

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

" press f9 to check the current file for php syntax errors
map <C-P> :w<CR>:!php -l %<CR>

" Switch to the Buffer Explorer list
map <C-\> :BufExplorer<CR>

" Switch to previous/next tab.
map <C-J> :tabprev<CR>
map <C-K> :tabnext<CR>

" ctrlp plugin configuration
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|target\|dist\|jsgen\|\.svn\|release\|\.min\|docroot\|instrumented\|tmp'
map <C-O> :CtrlPClearCache<CR>

" Open NERDtree file explorer
map <C-T> :NERDTreeToggle<CR>

" The completion dictionary is provided by Rasmus:
" http://lerdorf.com/funclist.txt
set dictionary-=~/.vim/funclist.txt dictionary+=~/.vim/funclist.txt
" Use the dictionary completion
set complete-=k complete+=k

" if we want to try autocompletion
function InsertTabWrapper()
   let col = col('.') - 1
   if !col || getline('.')[col - 1] !~ '\k'
       return "\<tab>"
   else
       return "\<c-p>"
   endif
endfunction

" Don't make a # force column zero.
:inoremap # X<BS>#

" In normal mode, jj escapes
:inoremap jj <Esc>

" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
function ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
   return "\<Right>"
 else
   return a:char
 endif
endf

function TogglePasteMode()
       if &paste
            set nopaste
       else
            set paste
       endif
endfunction

nmap <C-M> :call TogglePasteMode()<CR>

" Toggle line numbers.
nmap <C-N> :set invnumber<CR>

syntax enable

filetype plugin indent on

let $VIMRUNTIME = "~/.vim"

highlight RedundantWhitespace ctermbg=red guibg=red
match RedundantWhitespace /\s\+$\| \+\ze\t/

" autocmd VimEnter * nested TagbarOpen

let g:tagbar_width = 30

abbreviate teh the
abbreviate whitesapce whitespace
abbreviate sapce space
abbreviate stirng string
abbreviate expection exception
abbreviate Expection Exception

call pathogen#infect()

" web-indent
let g:js_indent_log = 0

" vim-css-color
let g:cssColorVimDoNotMessMyUpdatetime = 1

" Open NERDtree if there's no initial file to open
" autocmd vimenter * if !argc() | only | NERDTree | endif

" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" vim-session
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_command_aliases = 1

" Always show the status bar (vs. only when viewing multiple files).
set laststatus=2
