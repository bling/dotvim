" vim: fdm=marker

" setup & neobundle {{{
    set nocompatible
    set rtp+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
" }}}

" functions {{{
    function! Preserve(command)
        " preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        execute a:command
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction

    function! StripTrailingWhitespace()
        call Preserve("%s/\\s\\+$//e")
    endfunction

    function! EnsureExists(path)
        if !isdirectory(expand(a:path))
            call mkdir(expand(a:path))
        endif
    endfunction
" }}}

" base configuration {{{
    filetype on
    filetype plugin on
    filetype indent on
    syntax enable

    set timeoutlen=300                                  "mapping timeout
    set ttimeoutlen=50                                  "keycode timeout

    set mouse=a                                         "enable mouse
    set mousehide                                       "hide when characters are typed
    set history=1000                                    "number of command lines to remember
    set ttyfast                                         "assume fast terminal connection
    set viewoptions=folds,options,cursor,unix,slash     "unix/windows compatibility
    set encoding=utf-8                                  "set encoding for text
    set clipboard=unnamed                               "sync with OS clipboard
    set hidden                                          "allow buffer switching without saving
    set autoread                                        "auto reload if file saved externally
    set fileformats+=mac                                "add mac to auto-detection of file format line endings
    set nrformats-=octal                                "always assume decimal numbers
    set showcmd
    set tags=tags;/
    set showfulltag
    set keywordprg=":help"                              "remap K to vim help
    if executable('zsh')
        set shell=zsh
    endif

    " whitespace
    set backspace=indent,eol,start                      "allow backspacing everything in insert mode
    set autoindent                                      "automatically indent to match adjacent lines
    set smartindent                                     "smart indenting for additional languages
    set expandtab                                       "spaces instead of tabs
    set smarttab                                        "use shiftwidth to enter tabs
    set tabstop=4                                       "number of spaces per tab for display
    set softtabstop=4                                   "number of spaces per tab in insert mode
    set shiftwidth=4                                    "number of spaces when indenting
    set virtualedit=onemore                             "allow cursor one beyond end of line
    set list                                            "highlight whitespace
    set listchars=tab:▸\ ,trail:.,extends:❯,precedes:❮
    set shiftround
    set linebreak
    set showbreak=…

    set foldenable                                      "enable folds by default
    set scrolloff=5                                     "always show content after scroll
    set scrolljump=5                                    "minimum number of lines to scroll
    set display+=lastline
    set wildmenu                                        "show list for autocomplete
    set wildmode=list:longest:full                      "priority for tab completion
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store

    set splitbelow
    set splitright

    " disable sounds
    set noerrorbells
    set novisualbell
    set t_vb=

    " searching
    set hlsearch                                        "highlight searches
    set incsearch                                       "incremental searching
    set ignorecase                                      "ignore case for searching
    set smartcase                                       "do case-sensitive if there's a capital letter
    set showmatch                                       "automatically highlight matching braces/brackets/etc.

    " vim file/folder management {{{
        " persistent undo
        set undofile
        set undodir=~/.vim/.cache/undo

        " backups
        set backup
        set backupdir=~/.vim/.cache/backup
        set directory=~/.vim/.cache/swap

        call EnsureExists('~/.vim/.cache')
        call EnsureExists(&undodir)
        call EnsureExists(&backupdir)
        call EnsureExists(&directory)
    " }}}
" }}}

" ui configuration {{{
    set matchtime=2                                     "tens of a second to show matching parentheses
    set laststatus=2
    set number
    set cursorline

    if has('gui_running')
        set lines=999
        set columns=999
        set guioptions+=t                               "tear off menu items
        set guioptions-=T                               "toolbar icons

        if has('gui_macvim')
            set gfn=Ubuntu_Mono_for_Powerline:h14
        endif

        if has('gui_win32')
            set gfn=Ubuntu_Mono_for_Powerline:h10
        endif
    else
        set t_Co=256

        " difference cursors for insert vs normal mode
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
" }}}

" autocmd {{{
    autocmd FileType js,scss,css autocmd BufWritePre <buffer> call StripTrailingWhitespace()

    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline

    " go back to previous position of cursor if any
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe 'normal! g`"zvzz' |
        \ endif

    " enable omni completion
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

    autocmd FileType javascript setlocal foldmethod=syntax foldlevelstart=1
" }}}

" mappings {{{
    let mapleader = ","
    let g:mapleader = ","

    " formatting shortcuts
    nmap <leader>fef :call Preserve("normal gg=G")<CR>
    nmap <leader>f$ :call StripTrailingWhitespace()<CR>
    vmap <leader>s :sort<cr>

    " remap arrow keys
    nnoremap <up> :tabnext<CR>
    nnoremap <down> :tabprev<CR>
    nnoremap <left> :bprev<CR>
    nnoremap <right> :bnext<CR>
    inoremap <up> <nop>
    inoremap <down> <nop>
    inoremap <left> <nop>
    inoremap <right> <nop>

    " sane regex
    nnoremap / /\v
    vnoremap / /\v

    " screen line scroll
    nnoremap <silent> j gj
    nnoremap <silent> k gk

    " reselect visual block after indent
    vnoremap < <gv
    vnoremap > >gv

    " find current word in quickfix
    nnoremap <leader>fw :execute "vimgrep ".expand("<cword>")." %"<cr>:copen<cr>
    " find last search in quickfix
    nnoremap <leader>ff :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>

    " shortcuts for windows
    nnoremap <leader>v <C-w>v<C-w>l
    nnoremap <leader>s <C-w>s
    nnoremap <leader>vsa :vert sba<cr>
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " tab shortcuts
    map <leader>tn :tabnew<CR>
    map <leader>tc :tabclose<CR>

    " make Y consistent with C and D.  See :help Y.
    nnoremap Y y$

    " general
    nmap <leader>l :set list! list?<cr>
    noremap <space> :set hlsearch! hlsearch?<cr>
" }}}

" plugin/mapping configuration {{{
    " bundles: plugins {{{
        NeoBundle 'Lokaltog/powerline', { 'rtp': 'powerline/bindings/vim' }
        NeoBundle 'Lokaltog/vim-easymotion'

        NeoBundle 'tpope/vim-surround'
        NeoBundle 'tpope/vim-repeat'

        NeoBundle 'mattn/zencoding-vim'
        NeoBundle 'mattn/gist-vim', { 'depends': 'mattn/webapi-vim' }

        NeoBundle 'paradigm/vim-multicursor'
        NeoBundle 'kshenoy/vim-signature'
        NeoBundle 'guns/xterm-color-table.vim'
        NeoBundle 'sjl/splice.vim'

        NeoBundle 'myusuf3/numbers.vim'
        if !has('gui_running')
            NeoBundleDisable numbers.vim
        endif
    " }}}
    " bundles: vim-scripts {{{
        NeoBundle 'vimwiki'
        NeoBundle 'bufkill.vim'
        NeoBundle 'matchit.zip'
    " }}}
    " bundles: color schemes {{{
        NeoBundle 'nanotech/jellybeans.vim'
        NeoBundle 'tomasr/molokai'
        NeoBundle 'chriskempson/vim-tomorrow-theme'
        NeoBundle 'w0ng/vim-hybrid'
    " }}}
    " bundles: languages {{{
        NeoBundle 'pangloss/vim-javascript'
        NeoBundle 'groenewege/vim-less'
        NeoBundle 'mmalecki/vim-node.js'
        NeoBundle 'leshill/vim-json'
        NeoBundle 'tpope/vim-markdown'
        NeoBundle 'cakebaker/scss-syntax.vim'
        NeoBundle 'hail2u/vim-css3-syntax'
        NeoBundle 'ap/vim-css-color'
        NeoBundle 'othree/html5.vim'
    " }}}
    " ack/ag {{{
        if executable('ack') || executable('ag')
            NeoBundle 'mileszs/ack.vim'
            if executable('ag')
                let g:ackprg="ag --nogroup --column --smart-case --follow"
            endif
            map <leader>/ :Ack 
        endif
    " }}}
    " easygrep {{{
        NeoBundle 'EasyGrep'
        let g:EasyGrepRecursive=1
        let g:EasyGrepAllOptionsInExplorer=1
        let g:EasyGrepCommand=1
    " }}}
    " fugitive {{{
        NeoBundle 'tpope/vim-fugitive'
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>gr :Gremove<CR>
    " }}}
    " solarized {{{
        NeoBundle 'altercation/vim-colors-solarized'
        let g:solarized_contrast="high"
        let g:solarized_termcolors=256
        let g:solarized_visibility="high"
    " }}}
    " buffergator {{{
        NeoBundle 'jeetsukumaran/vim-buffergator'
        let g:buffergator_suppress_keymaps=1
        nnoremap <leader>b :BuffergatorToggle<cr>
        nnoremap <leader>t :BuffergatorTabsToggle<cr>
    " }}}
    " nerdtree {{{
        NeoBundle 'scrooloose/nerdtree'
        let NERDTreeShowHidden=1
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowLineNumbers=1
        let NERDTreeChDirMode=0
        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.git','\.hg']
        map <F2> :NERDTreeToggle<CR>
        map <F3> :NERDTreeFind<CR>
    " }}}
    " nerdcommenter {{{
        NeoBundle 'scrooloose/nerdcommenter'
        map \\ <plug>NERDCommenterToggle
    "}}}
    " syntastic {{{
        NeoBundle 'scrooloose/syntastic'
        let g:syntastic_error_symbol = '✗'
        let g:syntastic_style_error_symbol = '✠'
        let g:syntastic_warning_symbol = '∆'
        let g:syntastic_style_warning_symbol = '≈'
    " }}}
    " ctrlp {{{
        NeoBundle 'kien/ctrlp.vim'
        "let g:ctrlp_clear_cache_on_exit=0
        let g:ctrlp_max_height=40
        let g:ctrlp_max_files=2000
        let g:ctrlp_show_hidden=1
        let g:ctrlp_follow_symlinks=1
        let g:ctrlp_working_path_mode=0
        let g:ctrlp_cache_dir = '~/.vim/.cache/ctrlp'

        map <leader>p :CtrlPBufTag<cr>
        map <leader>pt :CtrlPTag<cr>
        map <leader>pl :CtrlPLine<cr>
        map <leader>pb :CtrlPBuffer<cr>
    " }}}
    " yankring {{{
        NeoBundle 'YankRing.vim'
        let g:yankring_replace_n_nkey = '<C-BS>'
        let g:yankring_replace_n_pkey = '<BS>'
        let g:yankring_history_dir='~/.vim/.cache'
        function! YRRunAfterMaps()
            nnoremap Y :<C-U>YRYankCount 'y$'<CR>
        endfunction
        map <leader>y :YRShow<CR>
    " }}}
    " buftabs {{{
        NeoBundle 'buftabs'
        let g:buftabs_only_basename=1
    " }}}
    " tabular {{{
        NeoBundle 'godlygeek/tabular'
        nmap <Leader>a& :Tabularize /&<CR>
        vmap <Leader>a& :Tabularize /&<CR>
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    " }}}
    " gundo {{{
        NeoBundle 'sjl/gundo.vim'
        let g:gundo_right=1
        nnoremap <silent> <F5> :GundoToggle<CR>
    " }}}
    " unimpaired {{{
        NeoBundle 'tpope/vim-unimpaired'
        nmap <c-up> [e
        nmap <c-down> ]e
        vmap <c-up> [egv
        vmap <c-down> ]egv
    " }}}
    " golden-ratio {{{
        NeoBundle 'roman/golden-ratio'
        map <silent> <leader>gr <Plug>(golden_ratio_resize)<cr>
    " }}}
    " jsbeautify {{{
        NeoBundle 'maksimr/vim-jsbeautify'
        nmap <leader>fjs :call JsBeautify()<CR>
    " }}}
    " ultisnips {{{
        "NeoBundle 'SirVer/ultisnips'
        "let g:UltiSnipsExpandTrigger="<tab>"
        "let g:UltiSnipsJumpForwardTrigger="<tab>"
        "let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    " }}}
    " indent guides {{{
        NeoBundle 'nathanaelkane/vim-indent-guides'
        let g:indent_guides_guide_size=1
        let g:indent_guides_start_level=1
        let g:indent_guides_enable_on_vim_startup=1
        let g:indent_guides_color_change_percent=5
        if !has('gui_running')
            let g:indent_guides_auto_colors=0
            autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
            autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236
        endif
    " }}}
    " shougo plugins {{{
        " unite {{{
            NeoBundle 'Shougo/unite.vim'
            let g:unite_data_directory='~/.vim/.cache/unite'
        " }}}
        " neosnippet {{{
            NeoBundle 'Shougo/neosnippet'
            let g:neosnippet#snippets_directory='~/.vim/snippets'
            let g:neosnippet#enable_snipmate_compatibility=1
        " }}}
        " neocomplcache {{{
            NeoBundle 'Shougo/neocomplcache'

            let g:neocomplcache_enable_at_startup = 1
            let g:neocomplcache_enable_auto_delimiter = 1
            let g:neocomplcache_force_overwrite_completefunc = 1
            let g:neocomplcache_temporary_dir='~/.vim/.cache/neocon'

            " Proper tab completion
            imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<C-n>" : "\<TAB>")
            smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

            " Define dictionary
            let g:neocomplcache_dictionary_filetype_lists = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }

            " Define keyword
            if !exists('g:neocomplcache_keyword_patterns')
                let g:neocomplcache_keyword_patterns = {}
            endif
            let g:neocomplcache_keyword_patterns._ = '\h\w*'

            " Plugin key-mappings
            imap <C-k> <Plug>(neosnippet_expand_or_jump)
            smap <C-k> <Plug>(neosnippet_expand_or_jump)
            inoremap <expr><C-g> neocomplcache#undo_completion()
            inoremap <expr><C-l> neocomplcache#complete_common_string()
            inoremap <expr><CR> neocomplcache#complete_common_string()

            " <CR>: close popup
            " <s-CR>: close popup and save indent.
            inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()"\<CR>" : "\<CR>"
            inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

            " <C-h>, <BS>: close popup and delete backword char.
            inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
            inoremap <expr><C-y> neocomplcache#close_popup()

            " Enable heavy omni completion
            if !exists('g:neocomplcache_omni_patterns')
                let g:neocomplcache_omni_patterns = {}
            endif
            let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

            " For snippet_complete marker
            if has('conceal')
                "set conceallevel=2 concealcursor=i
            endif
    " }}}
        " vimshell {{{
            if executable('make')
                NeoBundle 'Shougo/vimproc', {
                    \ 'build': {
                        \ 'mac': 'make -f make_mac.mak',
                        \ 'windows': 'make -f make_mingw32.mak',
                        \ 'unix': 'make -f make_unix.mak',
                    \ },
                \ }
                NeoBundle 'Shougo/vimshell'
            endif

            let g:vimshell_editor_command="/usr/local/bin/vim"
            let g:vimshell_right_prompt='getcwd()'
            let g:vimshell_temporary_directory='~/.vim/.cache/vimshell'

            nnoremap <leader>c :VimShell -split<cr>
        "}}}
    " }}}
    NeoBundleCheck
" }}}

" theme {{{
    if has("gui_running")
        set background=dark
        colorscheme Tomorrow-Night
    else
        set background=dark
        colorscheme hybrid
    endif
" }}}

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
