"himaaaatti's vimrc

"encoding
set encoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,mac,dos

"backSpace
set backspace=start,eol,indent
set backspace=2

"colorscheme
" syntax on
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
" set statusline+=%
" set statusline +=\ % { noscrollbar #statusline() }
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

"TODO:おそい ricty
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
"TODO:backupについて考える
set noswapfile
set nobackup

"fold
" set foldenable
" set foldcolumn=3
" set foldmethod=syntax
" set foldlevel=0

nnoremap <Space>a za
nnoremap <Space>A zA
nnoremap <Space>R zR

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
nnoremap [Mark]l :<C-u>Unite mark<CR>
" nnoremap <silent> [unite]ml  :<C-u>Unite mark<CR>

"TODO: :nohlsearch

"other
set autoindent
set cindent
set history=1000
set undofile
set undodir=~/.vim/undo
set undolevels=1000

"TODO: groupでかこむ
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
autocmd BufReadPost * delmarks!

"set prefix key
let g:mapleader=","

"keymap
"inoremap <Left> <Nop>
"inoremap <Right> <Nop>
"inoremap <Up> <Nop>
"inoremap <Down> <Nop>
"noremap <Left> <Nop>
"noremap <Right> <Nop>
"noremap <Up> <Nop>
"noremap <Down> <Nop>

nnoremap ZQ <Nop>
nnoremap Q gq
nnoremap <Space>w ZZ

nnoremap ; :
nnoremap : ;

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <S-Left> <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up> <C-w>-<CR>
nnoremap <S-Down> <C-w>+<CR>

nnoremap <Tab> %
vnoremap <Tab> %

nnoremap <Space>h :<C-u>vertical belowright help<Space>
" nnoremap <silent> <Space>ht :tab help <C-R><C-W><CR>

nnoremap <Leader>ev :tabnew $MYVIMRC<CR>

"Tab
nnoremap <Space>n :tabnew<Space>
nnoremap <Space>j gT
nnoremap <Space>k gt
nnoremap gt <Nop>
nnoremap gT <Nop>

nnoremap <Space>tj :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>

"autocmd
autocmd FileType python setl foldmethod=indent
autocmd FileType c setl cindent

autocmd BufWritePre * :%s/\s\+$//e

augroup filetypedetect
    au BufRead,BufNewFile *.s setfiletype gas
augroup END

"-------------------------------
"   Plugin
"-------------------------------
" filetype off

if !isdirectory(expand('~/.vim/bundle/neobundle.vim'))
    echo 'No NeoBundle'
    syntax enable
    colorscheme desert
    finish
endif

if has('vim_starting')
    "  set runtimepath+=d:/tool/vim/.bundle/neobundle.vim
    "  "  call neobundle#rc(expand('d:/tool/vim/.bundle'))
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin()

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc',{
    \ 'build' : {
            \ 'unix' : 'make -f make_unix.mak',
            \ },
            \}

NeoBundle 'Shougo/unite.vim'

if has('lua')
    NeoBundle 'Shougo/neocomplete'
else
    NeoBundle 'Shougo/neocomplcache'
endif

NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'kana/vim-smartinput'
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
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'itchyny/calendar.vim'
NeoBundle 'sjl/gundo.vim'
" NeoBundle 'vim-scripts/TaskList.vim'
NeoBundle 'junkblocker/unite-tasklist'
NeoBundle 'daisuzu/translategoogle.vim'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'vim-scripts/c.vim'
NeoBundle 'rhysd/vim-clang-format'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'lambdalisue/vim-gista'
NeoBundle 'sudo.vim'
NeoBundle 'louchen1990/rainbow'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'boolfool/vim-sudden-death'
NeoBundle 'sk1418/blockit'
NeoBundle 'osyo-manga/vim-marching'
NeoBundle 'mattn/gist-vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'koron/codic-vim'
NeoBundle 'mopp/smartnumber.vim'
NeoBundle 'mrk21/yaml-vim'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'gcavallanti/vim-noscrollbar'
NeoBundle 'haya14busa/vim-easymotion'

" haskell
" NeoBundle 'dag/vim2hs'
" NeoBundle 'eagletmt/ghcmod-vim'
" NeoBundle 'eagletmt/neco-ghc'

"scheme
NeoBundle 'amdt/vim-niji'
NeoBundle 'aharisu/vim_goshrepl'

call neobundle#end()
filetype plugin indent on

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

nnoremap <silent> <Space>y  :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]f  :<C-u>Unite file file_mru bookmark<CR>
nnoremap <silent> <Space>b  :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]r  :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]ma  :<C-u>Unite mapping<CR>
nnoremap <silent> [unite]me  :<C-u>Unite output:message<CR>
"nnoremap <silent> [unite]mr :<C-u>Unite output:marks<CR>

"platina searcher
nnoremap <silent><Space>p :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
let g:unite_source_grep_default_opts = '-iRHn --exclude-from=tags'
if executable('pt')
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor'
    let g:unite_source_grep_recursive_opt = ''
endif
" search current word
nnoremap <silent><Space>ap :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>

"Unite-Mark
" nnoremap <silent> [unite]ml  :<C-u>Unite mark<CR>

if has('lua')
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

"     inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"     function! s:my_cr_function()
"       return neocomplete#close_popup() . "\<CR>"
"     endfunction

"     inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-e>  neocomplete#cancel_popup()

    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns  =  {}
    endif

else
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_smart_case = 1

    let g:neocomplcache_min_keyword_length = 2
    let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

    let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
        \ 'php' : '~/.vim/dict/php.dict',
        \ 'c' : '~/.vim/dict/c.dict',
        \ 'cpp' : '~/.vim/dict/cpp.dict',
        \ 'java' : '~/.vim/dict/java.dict'
        \}

    inoremap <expr><C-g>    neocomplcache#undo_completion()
    inoremap <expr><C-l>    neocomplcache#complete_check()

"     inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"     function! s:my_cr_function()
"       return neocomplcache#smart_close_popup() . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"     endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
"     inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"     inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplcache#close_popup()
    inoremap <expr><C-e>  neocomplcache#cancel_popup()


    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
      let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2

let g:neocomplete#sources#dictionary#dictionaries  =  {
    \ 'default' : '',
    \ 'php' : '~/.vim/dict/php.dict',
    \ 'c' : '~/.vim/dict/c.dict',
    \ 'cpp' : '~/.vim/dict/cpp.dict',
    \ 'java' : '~/.vim/dict/java.dict',
    \ 'scala' : '~/.vim/dict/scala.dict'
    \}

inoremap <expr><C-g>    neocomplete#undo_completion()
inoremap <expr><C-l>    neocomplete#complete_common_string()

" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
"   return neocomplete#close_popup() . "\<CR>"
" endfunction

" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-e>  neocomplete#cancel_popup()

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


endif

"NeoSnnipet
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)
xmap <C-l>  <Plug>(neosnippet_start_unite_snippet_target)

"indent-guides
" let g:indent_guides_indent_levels=30
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
" hi IndentGuidesOdd  guibg=red   ctermbg=3
" hi IndentGuidesEven guibg=lightblue  ctermbg=4
hi IndentGuidesOdd ctermbg=183
hi IndentGuidesEven ctermbg=31
" let g:indent_guides_color_change_percent = 10

"Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_python_checkers = ['flake8']
"c++11
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11'


"EnhCommentify
"let g:EnhCommentifyRespectIndent = 'Yes'
let g:EnhCommentifyPretty = 'Yes'
let g:EnhCommentifyUseBlockIndent = 'Yes'
let g:EnhCommentifyCommentsOp = 'yes'
"TODO:scrooloose/nerdcommenter

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
"TODO:rhysd/vim-operator-surround

"Vim-AutoSave
let g:auto_save = 1

"VimFiler
let g:vimfiler_edit_action = 'tabopen'
let g:vimfiler_enable_auto_cd = 1
" nnoremap <Space>v :VimFiler -split -simple -winwidth=35 -quit<CR>

nnoremap <Space>v :<C-u>VimFiler -explorer<CR>

"Fugitive
" noremap [Fugitive] <Nop>
" nmap <Space>g [Fugitive]

" nnoremap [Fugitive]g :<C-u>Git<Space>
" nnoremap [Fugitive]s :<C-u>Gstatus<CR>
" nnoremap [Fugitive]a :<C-u>Gwrite<CR>
" nnoremap [Fugitive]c :<C-u>Gcommit<CR>
" nnoremap [Fugitive]b :<C-u>Gblame<CR>
" nnoremap [Fugitive]p :<C-u>Git<Space>pull<CR>

"Callender

"Gundo
nnoremap <Leader>u :<C-u>GundoToggle<CR>

"unite-tasklist
" nnoremap <Leader>T :<C-u>TaskList<CR>

"googletranslate
let g:translategoogle_default_sl = 'ja'
let g:translategoogle_default_tl = 'en'
nnoremap <Space>g :<C-u>TranslateGoogle<CR>

"calendarvim
nnoremap <Space>c :<C-u>Calendar<CR>
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

"a.vim
nnoremap <Space>a :<C-u>AT<CR>

" haskell
" ghcmod-vim
" augroup ghcmodcheck
"     autocmd! BufWritePost <buffer> GhcModCheckAsync
" augroup END
"

"clang-fomat
let g:clang_format#command="clang-format-3.5"
let g:clang_format#code_style="chromium"
let g:clang_format#style_options = {
    \ "BreakBeforeBraces" : "Stroustrup",
    \ "AlwaysBreakTemplateDeclarations" : "true",
    \ "AccessModifierOffset" : -4,
    \ "Standard" : "C++11",
    \ "IndentWidth" : 4
    \}
autocmd FileType c,cpp,objc nnoremap <Space>f vi{:ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <Space>f i{:ClangFormat<CR>

" vim-gista
let g:gista#github_user = 'himaaaatti'

" scheme
let lisp_rainbow=1

" taglist
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
nnoremap <silent><space>tl :TlistToggle<CR>

" easymotion
"TODO: set complete
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_migemo = 1
