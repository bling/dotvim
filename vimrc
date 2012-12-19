" vim: set foldmarker=[[,]] foldlevel=0 foldmethod=marker :

" setup & vundle [[
    set nocompatible
    filetype off
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
" ]]

" bundles [[

    " bundles: core [[
        Bundle 'gmarik/vundle'
        Bundle 'MarcWeber/vim-addon-mw-utils'
        Bundle 'tomtom/tlib_vim'
    " ]]

    " bundles: plugins [[
        Bundle 'kien/ctrlp.vim'
        Bundle 'Lokaltog/vim-powerline'
        Bundle 'Lokaltog/vim-easymotion'
        Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
        "Bundle 'nathanaelkane/vim-indent-guides'
        Bundle 'tpope/vim-fugitive'
        Bundle 'tpope/vim-surround'
        Bundle 'scrooloose/syntastic'
        Bundle 'scrooloose/nerdcommenter'
        Bundle 'scrooloose/nerdtree'
        Bundle 'ervandew/supertab'
        Bundle 'honza/snipmate-snippets'
        Bundle 'garbas/vim-snipmate'
        Bundle 'ap/vim-css-color'
        Bundle 'myusuf3/numbers.vim'
        if executable('ctags')
            Bundle 'majutsushi/tagbar'
        endif
    " ]]

    " bundles: color schemes [[
        Bundle 'altercation/vim-colors-solarized'
        Bundle 'vim-scripts/Colour-Sampler-Pack'
    " ]]

    " bundles: languages [[
        Bundle 'pangloss/vim-javascript'
        Bundle 'groenewege/vim-less'
        Bundle 'mmalecki/vim-node.js'
        Bundle 'leshill/vim-json'
        Bundle 'tpope/vim-markdown'
        Bundle 'cakebaker/scss-syntax.vim'
        Bundle 'hail2u/vim-css3-syntax'
    " ]]

" ]]

" base configuration [[
    filetype on
    filetype plugin on
    filetype indent on
    syntax enable

    set mouse=a                                         "enable mouse
    set mousehide                                       "hide when characters are typed
    set history=1000
    set relativenumber                                  "show line numbers relative to current line
    set ttyfast                                         "assume fast terminal connection
    set viewoptions=folds,options,cursor,unix,slash
    set encoding=utf-8                                  "set encoding for text
    set clipboard=unnamed                               "sync with OS clipboard
    set hidden                                          "allow buffer switching without saving
    set spell                                           "i can haz spelling?
    set wildmenu                                        "show list for autocomplete
    set wildmode=list:longest:full                      "priority for tab completion

    " whitespace
    set backspace=indent,eol,start                      "allow backspacing everything in insert mode
    set autoindent                                      "automatically indent to match adjacent lines
    set smartindent                                     "smart indenting for additional languages
    set expandtab                                       "spaces instead of tabs
    set tabstop=4                                       "number of spaces per tab for display
    set softtabstop=4                                   "number of spaces per tab in insert mode
    set shiftwidth=4                                    "number of spaces when indenting
    set list                                            "highlight whitespace
    set listchars=tab:▸\ ,trail:.,extends:#,nbsp:.      "highlight problematic whitespace

    " disable sounds
    set noerrorbells
    set novisualbell
    set t_vb=
    set tm=500

    " searching
    set hlsearch                                        "highlight searches
    set incsearch                                       "incremental searching
    set ignorecase                                      "ignore case for searching
    set smartcase                                       "do case-sensitive if there's a capital letter

    " backups
    set backup
    set backupdir=~/.vim/backup
    set directory=~/.vim/swap
" ]]

" ui configuration [[
    if has('gui_running')
        " maximize
        set lines=999
        set columns=999

        if has('gui_macvim')
            set transparency=2
        endif
    else
        set t_Co=256
    endif

    set gfn=Monaco:h13

    let g:solarized_contrast="high"
    let g:solarized_termcolors=256
    let g:solarized_visibility="low"
    colorscheme solarized

    set background=dark                                           "assume dark background
    set cursorline                                                "highlight the current line
    set showmatch                                                 "automatically highlight matching braces/brackets/etc.
    set foldenable
" ]]

" plugin configuration [[

    " nerdtree [[
        let NERDTreeShowHidden=1
        let NERDTreeQuitOnOpen=0
        let NERDTreeChDirMode=2
        let NERDTreeIgnore=['\.git','\.hg']
    " ]]

    " ctrlp [[
        let g:ctrlp_by_filename=1
        let g:ctrlp_clear_cache_on_exit=0
        let g:ctrlp_show_hidden=1
        let g:ctrlp_cache_dir = $HOME.'/.vim/cache/ctrlp'
        let g:ctrlp_custom_ignore = {
            \ 'dir' : '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$' }
    " ]]

    " indent guides [[
        let g:indent_guides_auto_colors = 1
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
    " ]]

    " powerline settings [[
        set laststatus=2
    " ]]
" ]]

" functions [[
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

    function! InitFolders()
        let folder = $HOME . '/.vim/backup'
        if !isdirectory(folder)
            call mkdir(folder)
        endif
        let folder = $HOME . '/.vim/swap'
        if !isdirectory(folder)
            call mkdir(folder)
        endif
    endfunction
    call InitFolders()
" ]]

" autocmd [[
    autocmd FileType js,scss,css autocmd BufWritePre <buffer> call StripTrailingWhitespace()
" ]]

" mappings [[
    let mapleader = ","
    let g:mapleader = ","

    " format entire file
    nmap <leader>fef :call Preserve("normal gg=G")<CR>
    " strip trailing spaces
    nmap <leader>f$ :call StripTrailingWhitespace()<CR>

    " disable arrow keys
    nnoremap <up> <nop>
    nnoremap <down> <nop>
    nnoremap <left> <nop>
    nnoremap <right> <nop>
    inoremap <up> <nop>
    inoremap <down> <nop>
    inoremap <left> <nop>
    inoremap <right> <nop>

    " screen line scroll
    nnoremap j gj
    nnoremap k gk

    " shortcuts for split screen
    nnoremap <leader>w <C-w>v<C-w>l
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    nmap <leader>l :set list!<CR>

    " tab shortcuts
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

    " nerdtree
    map <leader>e :NERDTreeToggle<CR>

    " fugitive
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>

    " tagbar
    nnoremap <silent> <F9> :TagbarToggle<CR>

" ]]

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

