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

set modelines=0
set nomodeline

" Search case-insensitive by default ...
set ignorecase
" ... when the query contains no upper-case
set smartcase

" Disable visual bell
set noeb vb t_vb=

set nofoldenable

set cursorline
hi CursorLine cterm=NONE ctermfg=NONE ctermbg=233

" Highlight search matches (original fg, dark grey bg)
hi Search cterm=NONE ctermfg=white ctermbg=darkgrey

" Highlight visual mode selections (original fg, dark grey bg)
hi Visual cterm=NONE ctermfg=white ctermbg=darkgrey

" Highlight incremental serach matches (white fg, dark grey bg)
hi IncSearch cterm=NONE ctermfg=white ctermbg=blue

" Highlight line numbers
hi LineNr cterm=NONE ctermfg=239 ctermbg=black
hi CursorLineNr cterm=NONE ctermfg=244 ctermbg=black

" Location list paths (match prompt color for cwd)
hi Directory cterm=NONE ctermfg=magenta ctermbg=black

hi MatchParen cterm=none ctermbg=darkgrey ctermfg=white

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

" Only show CursorLine the active buffer
" http://stackoverflow.com/a/12018552
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" turn off any existing search
au VimEnter * nohls

set fenc=utf-8
set fencs=utf-8
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

" ctrlp plugin configuration
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'find %s -not -regex ".*\/vendor.*" -not -regex ".*\/\..*\/.*" -not -regex ".*\/coverage.*" -not -regex ".*\/log.*" -not -regex ".*\/tmp.*" -not -regex ".*\/cache.*" -not -regex ".*\.min\..*" -not -regex ".*\/target.*" -not -regex ".*\/dist.*" -not -regex ".*SNAPSHOT.*" -not -regex ".*\/release.*" -not -regex ".*\/jsgen.*" -not -regex ".*\/node_modules.*" -not -regex ".*\/components.*" -not -regex ".*\/instrumented.*" -type f'
map <C-O> :CtrlPClearCache<CR>

" Open NERDtree file explorer
map <C-T> :NERDTreeToggle<CR>

" Don't make a # force column zero.
:inoremap # X<BS>#

" In normal mode, jj escapes
:inoremap jj <Esc>

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

let g:tagbar_width = 30
let g:tagbar_left = 1
let g:tagbar_autofocus = 1

abbreviate teh the
abbreviate whitesapce whitespace
abbreviate sapce space
abbreviate stirng string
abbreviate expection exception
abbreviate Expection Exception

execute pathogen#infect()

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

" Disable built-in manual keyword lookup
map <S-K> <nop>

" vim-session
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_command_aliases = 1

" BufExplorer
"
" Ex. to deal with index.js files from many modules
let g:bufExplorerSplitOutPathName = 0
let g:bufExplorerShowTabBuffer = 1

" Always show the status bar (vs. only when viewing multiple files).
set laststatus=2

" Opens the split in a new tab. Kind like 'distraction free' mode. (f)
" https://github.com/Wolfy87/vim-config/commit/707e062fe1fb756c84aa3ffe7b0652c4a0676970
nmap <leader>f :tab sp<CR>
nmap <leader>c :tabclose<CR>

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

set nottyfast
set lazyredraw

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_yaml_checkers = ['yamlxs']

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
"
" Prevent two location lists from popping up on save if `gofmt` fails
" Delegate post-save checks to syntastic
autocmd BufWritePost *.go silent :GoImports
autocmd BufWritePost *.go silent :GoMetaLinter

" - Disable gotype until there is better vendor support.
" - Disable structcheck/varcheck/errcheck/aligncheck because they're
"   relatively slow. Run them from Makefile.
let g:go_metalinter_command = "gometalinter --disable=gotype --disable=structcheck --disable=varcheck --disable=errcheck --disable=aligncheck"

" YouCompleteMe
"
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
" Prevent pane from popping up with the same signature info as the
" autocompletion content.
set completeopt-=preview
let g:ycm_add_preview_to_completeopt =  0
