# bling.vim

(Y)et (A)nother (V)im (D)istribution

## introduction

this is my personal vim configuration that i have tweaked over time and evolved from a simple vanilla vimrc configuration to a full-blown distribution that it is today.

while it is quite easy to install this distribution (i designed it that way for me to easily switch between computers), i actually recommend that you don't use it verbatim.  configuring a vimrc from scratch was an incredibly awesome experience and i want you to experience it to.  take a look at my vimrc for ideas, as well as the credits section.

## installation

1.  clone this repository into your `~/.vim` directory
2.  `git submodule init && git submodule update`
3.  `ln -s ~/.vim/vimrc ~/.vimrc`
4.  install the fonts found in the `font` directory
5.  run `vim`, and neobundle should automatically ask you to install all the missing plugins. (on windows this doesn't work as expected, so you will need to `:NeoBundleInstall` manually after vim starts up)
6.  done!

## modifications

### [ack.vim](https://github.com/milezs/ack.vim)
*  super fast project searching if you have [ack](http://betterthangrep.com/) installed.
*  if you have [ag](https://github.com/ggreer/the_silver_searcher) installed, it will use that instead
*  `<leader>/`

### [fugitive](https://github.com/tpope/vim-fugitive)
*  git wrapper
*  `<leader>gs :Gstatus`
*  `<leader>gd :Gdiff`
*  `<leader>gc :Gcommit`
*  `<leader>gb :Gblame`
*  `<leader>gl :Glog`
*  `<leader>gp :Git push`
*  `<leader>gw :Gwrite`
*  `<leader>gr :Gremove`

### [buffergator](https://github.com/jeetsukumaran/vim-buffergator)
*  easily see your buffers and/or tabs
*  `<leader>b` toggle buffer list
*  `<leader>t` toggle tab list

### [nerdtree](https://github.com/scrooloose/nerdtree)
*  file browser
*  `<F2>` toggle browser
*  `<F3>` open tree to path of the current file

### [nerdcommenter](https://github.com/scrooloose/nerdcommenter)
*  commenter plugin
*  all default mappings, and `\\` additionally mapped for comment toggling

### [ctrlp](https://github.com/kien/ctrlp.vim)
*  fuzzy file searching
*  `<C-P>` to bring up the search
*  `<leader>p` search the current buffer tags
*  `<leader>pt` search global tags
*  `<leader>pl` search all lines of all buffers
*  `<leader>pb` search open buffers

### [yankring](http://www.vim.org/scripts/script.php?script_id=1234)
*  keeps a history of all your yanks and delete
*  `<leader>y` to toggle showing the yankring
*  after `p`asting, `<BS>` to cycle back, `<C-BS>` to cycle forward

### [tabular](https://github.com/godlygeek/tabular)
*  easily aligns code
*  `<leader>a&`, `<leader>a=`, `<leader>a:`, `<leader>a,`, `<leader>a|`

### [gundo](https://github.com/sjl/gundo.vim)
*  visualize the undo tree
*  `<F5>`

### [unimpaired](https://github.com/tpope/vim-unimpaired)
*  many additional bracket maps
*  `<C-up>` to move lines up
*  `<C-down>` to move lines down

### [neocomplcache/neosnippet](https://github.com/Shougo)
*  super awesome autocomplete and snippet support
*  `<Tab>` to select the next match, or expand if the keyword is a snippet

### [vimshell](https://github.com/Shougo/vimshell)
*  `<leader>c` splits a new window with an embedded shell

## credits

i wanted to give special thanks to all of the people who worked on the following projects, or simply posted their vim distributions, because i learned a lot and took many ideas and incorporated them into my configuration.

*  [janus](https://github.com/carlhuda/janus)
*  [spf13](https://github.com/spf13/spf13-vim)
*  [yadr](http://skwp.github.com/dotfiles/)
*  [astrails](https://github.com/astrails/dotvim)

## license
[WTFPL](http://sam.zoy.org/wtfpl/)
