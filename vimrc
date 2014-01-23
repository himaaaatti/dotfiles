"himaaaatti's vimrc

"use vim setting
set nocompatible

"encoding
set encoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,mac,dos

"backSpace
set backspace=start,eol,indent
set backspace=2

"colorscheme
syntax on
colorscheme 256-jungle

"tab
set expandtab
set shiftwidth=4
set smarttab
set softtabstop=4
set tabstop=4

"status line
set laststatus=2
set statusline=%F%r%= 
set statusline+=%{fugitive#statusline()}
set statusline+=\ [%n]
set statusline+=\ (%l,%c) 

"appearance
set number
set title
set cursorline
set cmdheight=1
set scrolloff=3
set showmatch
set matchtime=1
set showcmd
set showmode
set nowrap

highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

"search
set incsearch
set hlsearch
set ignorecase
set smartcase
set wildmenu


"file
set autoread
set noswapfile
set nobackup

"fold
set foldenable
set foldcolumn=2
set foldmethod=syntax
set foldlevel=2

nnoremap [Fold] <Nop>
nmap <Space>f [Fold]

nnoremap [Fold]a za
nnoremap [Fold]A zA
nnoremap [Fold]R zR


"mark
nnoremap [Mark] <Nop>
nmap m [Mark]

if !exists('g:markrement_char')
    let g:markrement_char = [
    \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    \ ]
endif
nnoremap <silent>[Mark]m :<C-u>call <SID>AutoMarkrement()<CR>
function! s:AutoMarkrement()
    if !exists('b:markrement_pos')
        let b:markrement_pos = 0
    else
        let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_char)
    endif
    execute 'mark' g:markrement_char[b:markrement_pos]
    echo 'marked' g:markrement_char[b:markrement_pos]
endfunction

nnoremap [Mark]n ]`
nnoremap [Mark]p [`

"other
set autoindent
set cindent
set history=1000
set undodir=~/.vim/undo
set undofile
set undolevels=1000

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
autocmd BufReadPost * delmarks!

"set prefix key
let g:mapleader=";"


"keymap
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>

nnoremap ZQ <Nop>
nnoremap Q gq
nnoremap <Space>w ZZ

nnoremap ; :
nnoremap : ;

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap <Space>h :<C-u>vertical belowright help<Space>


"Tab
nnoremap <Space>n :tabnew<Space>
nnoremap <Space>j gT
nnoremap <Space>k gt
nnoremap gt <Nop>
nnoremap gT <Nop>


"autocmd
autocmd FileType python setl foldmethod=indent
autocmd FileType c setl cindent


"-------------------------------
"   Plugin
"-------------------------------
filetype off

if has('vim_starting')
    "  set runtimepath+=d:/tool/vim/.bundle/neobundle.vim
    "  "  call neobundle#rc(expand('d:/tool/vim/.bundle'))
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle'))
endif


NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc',{
            \   'build' :{
            \       'unix' : 'make -f make_unix.mak',
            \   },
            \}

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-scripts/EnhCommentify.vim'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'vim-scripts/vim-auto-save'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'bling/vim-airline'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tacroe/unite-mark'
NeoBundle 'tpope/vim-fugitive.git'
NeoBundle 'itchyny/calendar.vim'

filetype plugin on
filetype indent on

"Unite
let g:unite_data_directory = expand('~/.vim/Unite')
let g:unite_source_history_yank_enable = 1
let g:unite_enable_start_insert = 1
let g:unite_enable_short_source_names = 1
let g:unite_split_rule = 'botright'
let g:unite_prompt = '>>'

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
"     nmap <buffer> <ESC> <Plug>(unite_exit)
    imap <buffer> <ESC> <Plug>(unite_exit)
endfunction

nnoremap [unite] <Nop>
nmap <Space>u [unite]

nnoremap <silent> [unite]y  :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]f  :<C-u>Unite file file_mru bookmark<CR>
nnoremap <silent> [unite]b  :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]r  :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]ma  :<C-u>Unite mapping<CR>
nnoremap <silent> [unite]me  :<C-u>Unite output:message<CR>
"nnoremap <silent> [unite]mr :<C-u>Unite output:marks<CR>

"Unite-Mark
nnoremap <silent> [unite]ml  :<C-u>Unite mark<CR>


"NeoComplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2

let g:neocomplete#sources#dictionary#dictionaries  =  {
    \ 'default' : '',
    \ 'php' : '~/.vim/dict/php.dict',
    \ 'c' : '~/.vim/dict/c.dict',
    \ 'cpp' : '~/.vim/dict/cpp.dict',
    \ 'java' : '~/.vim/dict/java.dict'
    \}

inoremap <expr><C-g>    neocomplete#undo_completion()
inoremap <expr><C-l>    neocomplete#complete_common_string()

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
endfunction

inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-e>  neocomplete#cancel_popup()

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns  =  {}
endif


"NeoSnnipet
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)
xmap <C-l>  <Plug>(neosnippet_start_unite_snippet_target)

"Indent Guides
let g:indent_guides_indent_levels = 30
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  guibg=red   ctermbg=3
hi IndentGuidesEven guibg=lightblue  ctermbg=4
" hi IndentGuidesEven guibg=green ctermbg=4

let g:indent_guides_color_change_percent = 10


"Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2


"EnhCommentify
"let g:EnhCommentifyRespectIndent = 'Yes'
let g:EnhCommentifyPretty = 'Yes'
let g:EnhCommentifyUseBlockIndent = 'Yes'
let g:EnhCommentifyCommentsOp = 'yes'


"Vim-Airline
let g:airline#extensions#tabline#enabled  =  1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1

"Vim-Anzu
nmap n  <Plug>(anzu-n-with-echo)
nmap N  <Plug>(anzu-N-with-echo)
nmap *  <Plug>(anzu-star-with-echo)
nmap #  <Plug>(anzu-sharp-with-echo)

"QuickRun
let g:quickrun_config = {
\   '_':{
\       'runner': 'vimproc',
\       'runner/vimproc/updatetime': 60,
\       'vsplit': '',
\       'hook/typt/enable': 1,
\       'outputter/buffer/close_on_empty': 1
\   },
\}



"Vim-Surround


"Vim-AutoSave
let g:auto_save = 1


"VimFiler
let g:vimfiler_edit_action = 'tabopen'
let g:vimfiler_enable_auto_cd = 1
" nnoremap <Space>v :VimFiler -split -simple -winwidth=35 -quit<CR>

nnoremap <Space>v :<C-u>VimFiler -explorer -quit<CR>


"Fugitive
noremap [Fugitive] <Nop>
nmap <Space>g [Fugitive]

nnoremap [Fugitive]g :<C-u>Git<Space>
nnoremap [Fugitive]s :<C-u>Gstatus<CR>
nnoremap [Fugitive]a :<C-u>Gwrite<CR>
nnoremap [Fugitive]c :<C-u>Gcommit<CR>
nnoremap [Fugitive]b :<C-u>Gblame<CR>

"Callender 
