" vim: fdm=marker

" setup & neobundle {{{
    set nocompatible
    set rtp+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
" }}}

" bundles {{{
    " bundles: core {{{
        NeoBundle 'MarcWeber/vim-addon-mw-utils'
        NeoBundle 'tomtom/tlib_vim'
    " }}}

    " bundles: plugins {{{
        NeoBundle 'kien/ctrlp.vim'
        NeoBundle 'Lokaltog/vim-powerline', {
            \ 'rev': 'develop',
            \ 'type__shallow': 0
        \ }
        NeoBundle 'Lokaltog/vim-easymotion'
        NeoBundle 'myusuf3/numbers.vim', { 'gui': 1 }
        NeoBundle 'tpope/vim-fugitive'
        NeoBundle 'tpope/vim-surround'
        NeoBundle 'tpope/vim-repeat'
        NeoBundle 'scrooloose/syntastic'
        NeoBundle 'scrooloose/nerdcommenter'
        NeoBundle 'scrooloose/nerdtree'
        NeoBundle 'paradigm/vim-multicursor'

        NeoBundle 'mileszs/ack.vim'
        NeoBundle 'sjl/gundo.vim'
        NeoBundle 'kshenoy/vim-signature'
        NeoBundle 'godlygeek/tabular'
        NeoBundle 'PAntoine/TimeKeeper'

        NeoBundle 'mattn/zencoding-vim'
        NeoBundle 'mattn/webapi-vim'
        NeoBundle 'mattn/gist-vim'

        NeoBundle 'Shougo/vimproc', {
            \ 'build': {
                \ 'mac': 'make -f make_mac.mak',
                \ 'windows': 'make -f make_mingw32.mak',
                \ 'unix': 'make -f make_unix.mak',
            \ },
        \ }
        NeoBundle 'Shougo/vimshell'
        NeoBundle 'Shougo/unite.vim'

        if executable('ctags')
            NeoBundle 'majutsushi/tagbar'
        endif
    " }}}

    " bundles: vim-scripts {{{
        NeoBundle 'vimwiki'
        NeoBundle 'bufkill.vim'
        NeoBundle 'buftabs'
        NeoBundle 'EasyGrep'
    " }}}

    " bundles: autocomplete {{{
        "NeoBundle 'garbas/vim-snipmate'
        "NeoBundle 'ervandew/supertab'

        NeoBundle 'Shougo/neocomplcache'
        NeoBundle 'Shougo/neosnippet'

        NeoBundle 'honza/snipmate-snippets'
    " }}}

    " bundles: color schemes {{{
        NeoBundle 'altercation/vim-colors-solarized'
        NeoBundle 'vim-scripts/Colour-Sampler-Pack'
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
        NeoBundle 'maksimr/vim-jsbeautify'
    " }}}

    NeoBundleCheck
" }}}

" base configuration {{{
    filetype on
    filetype plugin on
    filetype indent on
    syntax enable

    set timeoutlen=200                                  "time to wait between key presses
    set mouse=a                                         "enable mouse
    set mousehide                                       "hide when characters are typed
    set history=1000
    set ttyfast                                         "assume fast terminal connection
    set viewoptions=folds,options,cursor,unix,slash     "unix/windows compatibility
    set encoding=utf-8                                  "set encoding for text
    set clipboard=unnamed                               "sync with OS clipboard
    set hidden                                          "allow buffer switching without saving
    "set spell                                           "i can haz spelling?
    set autoread                                        "auto reload if file saved externally
    set shell=zsh

    " whitespace
    set backspace=indent,eol,start                      "allow backspacing everything in insert mode
    set autoindent                                      "automatically indent to match adjacent lines
    set smartindent                                     "smart indenting for additional languages
    set expandtab                                       "spaces instead of tabs
    set tabstop=4                                       "number of spaces per tab for display
    set softtabstop=4                                   "number of spaces per tab in insert mode
    set shiftwidth=4                                    "number of spaces when indenting
    set virtualedit=onemore                             "allow cursor one beyond end of line
    set list                                            "highlight whitespace
    set listchars=tab:▸\ ,trail:.,extends:#,nbsp:.      "highlight problematic whitespace

    set showmatch                                       "automatically highlight matching braces/brackets/etc.
    set foldenable                                      "enable folds by default
    set scrolloff=10                                    "always show content after scroll
    set scrolljump=5                                    "minimum number of lines to scroll

    " disable sounds
    set noerrorbells
    set novisualbell
    set t_vb=

    " searching
    set hlsearch                                        "highlight searches
    set incsearch                                       "incremental searching
    set ignorecase                                      "ignore case for searching
    set smartcase                                       "do case-sensitive if there's a capital letter
    if executable('ack')
        set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
        set grepformat=%f:%l:%c:%m
    endif
    if executable('ag')
        set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
        set grepformat=%f:%l:%c:%m
    endif

    " windows
    "set winwidth=150                                    "suggested window width
    "set winheight=10                                    "dummy setting to match winminheight
    "set winminheight=10                                 "the minimum height for any window
    "set winminwidth=10                                  "the minimum width for any window
    "set winheight=999                                   "the suggest height for any window

    set wildmenu                                        "show list for autocomplete
    set wildmode=list:longest:full                      "priority for tab completion
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*

    " make sure these folders exist
    silent !mkdir ~/.vim/undo > /dev/null 2>&1
    silent !mkdir ~/.vim/backup > /dev/null 2>&1
    silent !mkdir ~/.vim/swap > /dev/null 2>&1

    " persistent undo
    set undofile
    set undodir=~/.vim/undo

    " backups
    set backup
    set backupdir=~/.vim/backup
    set directory=~/.vim/swap
" }}}

" ui configuration {{{
    set background=light
    colorscheme solarized
    let g:solarized_contrast="high"
    let g:solarized_termcolors=256
    let g:solarized_visibility="high"

    if has('gui_running')
        " maximize
        set lines=999
        set columns=999

        if has('gui_macvim')
            set gfn=Ubuntu_Mono_for_Powerline:h14
        endif

        if has('gui_win32')
            set gfn=Envy_Code_R_VS:h10
        endif
    else
        set t_Co=256
        set number

        " difference cursors for insert vs normal mode
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
" }}}

" plugin configuration {{{
    " ack {{{
        if executable('ag')
            let g:ackprg="ag --nogroup --column --smart-case --follow --nocolor"
        endif
    " }}}

    " easygrep {{{
        let g:EasyGrepRecursive=1
        let g:EasyGrepAllOptionsInExplorer=1
        let g:EasyGrepCommand=1
    " }}}

    " timekeeper {{{
        if filereadable(expand("~/.timekeeper.tmk"))
            let g:TimeKeeperStartOnLoad=1
        endif
    " }}}

    " nerdtree {{{
        let NERDTreeShowHidden=1
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowLineNumbers=1
        let NERDTreeChDirMode=0
        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.git','\.hg']
    " }}}

    " syntastic {{{
        let g:syntastic_error_symbol = '✗'
        let g:syntastic_style_error_symbol = '✠'
        let g:syntastic_warning_symbol = '∆'
        let g:syntastic_style_warning_symbol = '≈'
    " }}}

    " ctrlp {{{
        let g:ctrlp_cmd = 'CtrlPMixed'
        let g:ctrlp_by_filename=1
        "let g:ctrlp_clear_cache_on_exit=0
        let g:ctrlp_max_height=15
        let g:ctrlp_max_files=2000
        let g:ctrlp_show_hidden=1
        let g:ctrlp_follow_symlinks=1
        let g:ctrlp_working_path_mode=0
        let g:ctrlp_cache_dir = $HOME.'/.vim/cache/ctrlp'
    " }}}

    " powerline settings {{{
        set laststatus=2
        let g:Powerline_symbols = 'fancy'
    " }}}

    " buftabs {{{
        let g:buftabs_only_basename=1
    " }}}

    " vimshell {{{
        let g:vimshell_editor_command="/usr/local/bin/vim"
    "}}}

    " neocomplcache {{{
        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_enable_camel_case_completion = 1
        let g:neocomplcache_enable_smart_case = 1
        let g:neocomplcache_enable_underbar_completion = 1
        let g:neocomplcache_enable_auto_delimiter = 1
        let g:neocomplcache_max_list = 15
        let g:neocomplcache_force_overwrite_completefunc = 1
        let g:neocomplcache_max_menu_width = 999
        "let g:neocomplcache_auto_completion_start_length=1

        " Proper tab completion
        imap <silent><expr><TAB> neosnippet#expandable_or_jumpable() ?
                    \ "\<Plug>(neosnippet_expand_or_jump)" :
                    \ (pumvisible() ? "\<C-n>" : "\<TAB>")
        smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                    \ "\<Plug>(neosnippet_expand_or_jump)"
                    \: "\<TAB>"

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

        " <TAB>: completion
        "inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
        "inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

        " <CR>: close popup
        " <s-CR>: close popup and save indent.
        inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()"\<CR>" : "\<CR>"
        inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y> neocomplcache#close_popup()

        " Enable omni completion
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

        " Enable heavy omni completion
        if !exists('g:neocomplcache_omni_patterns')
            let g:neocomplcache_omni_patterns = {}
        endif
        let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
        let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

        " use honza's snippets
        let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets'
        let g:neosnippet#enable_snipmate_compatibility=1

        " For snippet_complete marker
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif
    " }}}
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
" }}}

" autocmd {{{
    autocmd FileType js,scss,css autocmd BufWritePre <buffer> call StripTrailingWhitespace()

    au WinLeave * set nocursorline
    "au WinLeave * set nocursorcolumn

    au WinEnter * set cursorline
    "au WinEnter * set cursorcolumn

    "automatically close quick-fix on select
    "autocmd FileType qf nmap <buffer> <cr> <cr>:ccl<cr>
" }}}

" mappings {{{
    let mapleader = ","
    let g:mapleader = ","

    " formatting shortcuts
    nmap <leader>fef :call Preserve("normal gg=G")<CR>
    nmap <leader>f$ :call StripTrailingWhitespace()<CR>
    nmap <leader>fjs :call JsBeautify()<CR>

    " remap arrow keys {{{
        nnoremap <up> :tabnext<CR>
        nnoremap <down> :tabprev<CR>
        nnoremap <left> :bprev<CR>
        nnoremap <right> :bnext<CR>
        inoremap <up> <nop>
        inoremap <down> <nop>
        inoremap <left> <nop>
        inoremap <right> <nop>
    " }}}

    " screen line scroll
    nnoremap j gj
    nnoremap k gk

    " reselect visual block after indent
    vnoremap < <gv
    vnoremap > >gv

    " shortcuts for split screen
    nnoremap <leader>v <C-w>v<C-w>l
    nnoremap <leader>s <C-w>s
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " tab shortcuts {{{
        map <leader>tn :tabnew<CR>
        map <leader>tc :tabclose<CR>
        map <leader>t0 0gt
        map <leader>t1 1gt
        map <leader>t2 2gt
        map <leader>t3 3gt
        map <leader>t4 4gt
        map <leader>t5 5gt
        map <leader>t6 6gt
        map <leader>t7 7gt
        map <leader>t8 8gt
        map <leader>t9 9gt
    " }}}

    " nerdtree
    map <leader>ee :NERDTreeToggle<CR>
    map <leader>ef :NERDTreeFind<CR>

    " fugitive {{{
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
    " }}}

    " tagbar
    nnoremap <silent> <F9> :TagbarToggle<CR>

    " gundo
    nnoremap <silent> <F5> :GundoToggle<CR>

    " ctrlp
    map <leader>p :CtrlPBufTag<cr>

    " multicursor
    nnoremap _ :<c-u>call MultiCursorPlaceCursor()<cr>
    nnoremap __ :<c-u>call MultiCursorManual()<cr>
    let g:multicursor_quit = "<C-c>"

    " nerdcommenter
    map \\ <plug>NERDCommenterToggle

    " general
    map <leader>a :Ack 
    nmap <leader>l :set list! list?<cr>
    noremap <space> :set hlsearch! hlsearch?<cr>
    map <Leader>fr ^l"ayt/^v$h"byu:vsp<CR>:args `ack -l <C-R>a`<CR>:argdo %s<C-R>bgce \| update<CR>
" }}}

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

