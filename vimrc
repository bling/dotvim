" setup & vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" bundles: core
Bundle 'gmarik/vundle'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
" }

" bundles: plugins
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'tpope/vim-fugitive'
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

" bundles: color schemes
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/Colour-Sampler-Pack'

" bundles: languages
Bundle 'pangloss/vim-javascript'
Bundle 'groenewege/vim-less'
Bundle 'mmalecki/vim-node.js'
Bundle 'leshill/vim-json'
Bundle 'tpope/vim-markdown'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'hail2u/vim-css3-syntax'

source ~/.vim/vimrc.base
source ~/.vim/vimrc.ui
source ~/.vim/vimrc.plugins
source ~/.vim/vimrc.mappings

