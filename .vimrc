" Based on .vimrc by:
"   Tobias Schlitt <toby@php.net>
"   Ciaran McCreesh <ciaranm at gentoo.org>
"   https://github.com/myusuf3/dotfiles/blob/master/vimrc


" Remove any trailing whitespace that is in the file, then return
" to the prior cursor position.
autocmd BufWrite * if ! &bin | let prevline = line('.') | let prevcol = col('.') | silent! %s/\s\+$//ge | cal cursor(prevline, prevcol) | endif

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

" Visual selection
" Move to the first word of the line, select everything until the first space
map vts 0wvt<space>

" Folds
function EnableFolds()
  " Handle case where a new split is created from an existing buffer, where
  " all folds have been expanded, and the intent is to both showing the same
  " buffer. Instead of using an overbroad auto-command in filetype.vim,
  " we'll run it on-demand when trying to perform a fold operation.
  " (copied from *.go handling in filetype.vim)
  if &foldenable == 0
       setlocal foldenable
   endif
   if &foldmethod != "syntax"
       setlocal foldmethod=syntax
   endif
   if &foldlevel != 0
       setlocal foldlevel=0
   endif
   if &foldnestmax != 1
      setlocal foldnestmax=1
   endif
endfunction
function DisableFolds()
    setlocal nofoldenable
    setlocal foldmethod=manual
endfunction
" Toggle folding levels (ex. in function)
map <silent> ff :call EnableFolds()<CR>zA
" Open all in file
map <silent> FF :call DisableFolds()<CR>
" Close all in file
map <silent> GG zM
" Close all but current (function)
map <silent> fe :call EnableFolds()<CR>zMzA
" Open all folds before easymotion search to avoid hang
map <silent> <leader><leader> zR<Plug>(easymotion-prefix)
" Less distracting fold markers
hi Folded cterm=NONE ctermfg=234 ctermbg=NONE

" Highlight search matches
hi Search cterm=NONE ctermfg=white ctermbg=92

" Highlight visual mode selections
hi Visual cterm=NONE ctermfg=white ctermbg=92

" Highlight incremental search matches
hi IncSearch cterm=NONE ctermfg=white ctermbg=129

" Highlight line numbers
hi LineNr cterm=NONE ctermfg=239 ctermbg=black
hi CursorLineNr cterm=NONE ctermfg=244 ctermbg=black

" Use a "transparent" highlight to avoid an underline in BufExplorer
hi CursorLine cterm=NONE ctermfg=NONE ctermbg=NONE

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

" Reduce color variation in JavaScript
hi jsGlobalObjects cterm=NONE ctermfg=white ctermbg=NONE
hi jsOf cterm=NONE ctermfg=white ctermbg=NONE
hi jsOperator cterm=NONE ctermfg=white ctermbg=NONE
hi jsThis cterm=NONE ctermfg=white ctermbg=NONE
hi jsTernaryIfOperator cterm=NONE ctermfg=white ctermbg=NONE
hi jsDocTags cterm=NONE ctermfg=247 ctermbg=NONE
hi def link jsDocType jsDocTags
hi def link jsDocParam jsDocTags
hi def link jsDocTypeNoParam jsDocTags
hi def link jsBooleanTrue goPredefinedIdentifiers
hi def link jsBooleanFalse jsBooleanTrue
hi def link jsClass goDeclaration
hi def link jsStorageClass goDeclaration
hi def link jsConditional goConditional
hi def link jsExceptions goConditional
hi def link jsException jsExceptions
hi def link jsFunction goDeclaration
hi def link jsArrowFunction goDeclaration
hi def link jsNull goPredefinedIdentifiers
hi def link jsNumber goDecimalInt
hi def link jsFloat goFloat
hi def link jsRepeat goRepeat
hi def link jsReturn goStatement
hi def link jsStatement goStatement
hi def link jsLabel goStatement
hi def link jsUndefined goPredefinedIdentifiers
hi def link jsTemplateVar jsTemplateString

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

" Switch to previous/next tab.
map <silent> <C-J> :tabprev<CR>
map <silent> <C-K> :tabnext<CR>

" Switch to previous buffer with backspace.
map <leader><bs> :b#<CR>

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
map <silent> <C-T> :Tagbar<CR>

" Toggle line numbers.
nmap <silent> <C-N> :set invnumber<CR>

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
" skip blank windows
set sessionoptions-=blank
" skip options/mappings
set sessionoptions-=options
set sessionoptions-=localoptions
" skip help windows
set sessionoptions-=help

" BufExplorer
let g:bufExplorerSplitOutPathName = 1
let g:bufExplorerShowRelativePath = 1
map <silent> <C-\> :BufExplorer<CR>
hi def link bufExplorerMapping bufExplorerHelp

" Always show the status bar (vs. only when viewing multiple files).
set laststatus=2

" Exit insert mode
" (Use qq instead of the common jj to avoid conflicts with fast 'j' presses use in visual
" mode to expand the block down.)
map q <Nop>
imap qq <Esc>
vmap qq <Esc>
" Clear the current command-line and reutrn to normal mode.
cmap qq <C-E><C-U><Esc>

" Opens the split in a new tab. Kind like 'distraction free' mode. (f)
" https://github.com/Wolfy87/vim-config/commit/707e062fe1fb756c84aa3ffe7b0652c4a0676970
nmap <silent> <leader>f :tab sp<CR>
nmap <silent> <leader>c :tabclose<CR>

" Clear highlighting in normal mode with return key
nnoremap <silent> <CR> :noh<CR>

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

" Move to the next error/warning cite
nmap <silent> <C-L> :lne<CR>

" Change the cwd to the file's
nmap <silent> <C-C> :cd %:p:h<CR>

" python-mode
"
" Disable default behavior of enabling line numbers
" (https://github.com/klen/python-mode/issues/356#issuecomment-33260767)
autocmd FileType python setlocal nonumber

" vim-go
" Use the current package name for new files, not always `main`
let g:go_template_use_pkg = 1
" Call :GoFmt manually via mapping until fold-closing regression is fixed.
let g:go_fmt_autosave = 0
" Use a custom mapping instead
let g:go_def_mapping_enabled = 0
map <silent> <C-D> :GoDef<CR>
" Replacement for vim-go bug where GoFmt closes folds, even with its
" experimental mode enabled (as of vim v8.0.0363, vim-go b9c8156).)
function SaveGo()
    let foldhype = &foldenable
    if foldhype
        call DisableFolds()
    endif
    mkview!
    GoImports
    silent! loadview
    if foldhype
        call EnableFolds()
    else
        " Workaround GoFmt somehow re-enabling folds
        call DisableFolds()
    endif
endfunction
nmap <silent> <C-G> :call SaveGo()<CR>
" Reduce color distraction
hi def link goBuiltins goDeclaration
hi def link goRepeat goDeclaration
hi def link goStatement goDeclaration
hi def link goConditional goDeclaration
hi def link goLabel goDeclaration
hi def link goPredefinedIdentifiers goString
hi def link goFormatSpecifier goString
hi def link goBoolean goString
hi def link goDecimalInt goString
hi def link goHexadecimalInt goString
hi def link goOctalInt goString
hi def link goFloat goString
hi def link goCharacter goString
hi def link goEscapeC goString
hi def link goDeclType goType
hi def link goSignedInts goType
hi def link goUnsignedInts goType
hi def link goFloats goType
hi def link goExtraType goType
hi def link goDirective goDeclaration
hi goDeclaration cterm=NONE ctermfg=240 ctermbg=NONE
hi goType cterm=NONE ctermfg=white ctermbg=NONE
hi goFunction cterm=NONE ctermfg=white ctermbg=NONE
" Avoid flashes of red because gofmt, plus the whitespace-trimming BufWrite
" in this file, will fix any leading/trailing extra-space issues.
hi goSpaceError cterm=NONE ctermfg=NONE ctermbg=NONE
" Unset 'go#complete#Complete' for neocomplete
setlocal omnifunc=

" neocomplete
" - Use <ESC>/`qq` alias to accept inserted candidate, ex. when scrolling them.
" - https://github.com/Shougo/neocomplete.vim/wiki/neocomplete-migration-guide
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#sources#min_keyword_length = 4
let g:neocomplete#manual_completion_start_length = 4
let g:neocomplete#disable_auto_complete = 1
let g:neocomplete#max_list = 20
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#within_comment = 1
" Use manual completion but cover corner cases, etc.
function! s:neocomplete_on_tab()
    " Scroll down/forward if already displayed.
    if pumvisible()
        return "\<C-n>"
    endif
    " Don't trigger at the start of a line.
    if col('.') == 1
        return "\<tab>"
    endif
    " Don't trigger after whitespace.
    if matchstr(getline('.'), '\%' . (col('.')-1) . 'c.') =~ '\s\+'
        return "\<tab>"
    endif
    " Trigger auto-completion.
    return neocomplete#start_manual_complete()
endfunction
inoremap <silent> <expr><TAB> <SID>neocomplete_on_tab()
" Scroll up/backward.
inoremap <silent> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" Select candidate via return key, mainly for when there's only one and
" it's auto-selected by not inserted.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" Prevent pane from popping up with the same signature info as the
" autocompletion content.
set completeopt-=preview

" gundo
nmap <silent> <leader>g :GundoToggle<CR>

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

" Workaround for https://github.com/jiangmiao/auto-pairs/issues/164#issuecomment-280999007
let g:AutoPairsUseInsertedCount = 1

" Enable use of alt/option key in bindings on Mac when "Use Option as Meta key" is
" turned on in Terminal.
" https://www.progclub.org/blog/2014/12/06/fixing-meta-keys-in-vim-via-mac-os-x-terminal-app/
let c='a'
while c <= 'z'
    exec "set <M-".tolower(c).">=\e".c
    exec "imap \e".c." <M-".tolower(c).">"
    let c = nr2char(1+char2nr(c))
endw

" Move current line, in normal mode, up/down with meta+j/k keys.
" http://vim.wikia.com/wiki/Moving_lines_up_or_down
" https://github.com/vim/vim/issues/687#issuecomment-196500745
" (Mac: requires above "Use Option as Meta key" fix.)
" Note: if <ESC> is pressed and then quickly j/k, it has the same effect.
nnoremap <silent> <M-j> :let fdm_sav=&fdm\|:set fdm=manual\|:m .+1<CR>:let &fdm=fdm_sav<CR>==
nnoremap <silent> <M-k> :let fdm_sav=&fdm\|:set fdm=manual\|:m .-2<CR>:let &fdm=fdm_sav<CR>==

" Don't automatically open folds when cycling through search matches.
set foldopen-=search
set foldopen-=mark

" Only show the mode in powerline
set noshowmode
