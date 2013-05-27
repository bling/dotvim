# bling.vim

A highly tuned Vim distribution that will blow your socks off!

## introduction

this is my personal vim distribution that i have tweaked over time and evolved from a simple vanilla vimrc configuration to a full-blown distribution that it is today.

while it is quite easy to install this distribution (i designed it that way for me to easily switch between computers), i actually recommend that you don't use it verbatim.  configuring a vimrc from scratch was an incredibly awesome experience and i want you to experience it too.  take a look at my vimrc for ideas, as well as the credits section.

## installation

1.  clone this repository into your `~/.vim` directory
1.  `git submodule init && git submodule update`
1.  `ln -s ~/.vim/vimrc ~/.vimrc`
1.  startup vim and neobundle will detect and ask you install any missing plugins.  you can also manually initiate this with `:NeoBundleInstall`
1.  done!

## standard modifications

*  if you have either [ack](http://betterthangrep.com/) or [ag](https://github.com/ggreer/the_silver_searcher) installed, they will be used for `grepprg`
*  all temporary files are stored in `~/.vim/.cache`, such as backup files and persistent undo

## mappings

### insert mode
*  `<C-h>` move the cursor left
*  `<C-l>` move the cursor right
*  `jk`,`kj` "smash escape"

### normal mode
*  `<leader>fef` format entire file
*  `<leader>f$` strip current line of trailing white space
*  `<leader>fw` find the word under cursor into the quickfix list
*  `<leader>ff` find the last search into the quickfix list
*  `<leader>v` vertical split
*  `<leader>s` horizontal split
*  `<leader>vsa` vertically split all buffers
*  `<C-h>` `<C-j>` `<C-k>` `<C-l>` move to window in the direction of hkjl
*  `/` replaced with `/\v` for sane regex searching
*  `<Space>` toggles hisearch
*  `<Down>` `<Up>` maps to `:bprev` and `:bnext` respectively
*  `<Left>` `<Right>` maps to `:tabprev` and `:tabnext` respectively
*  `Q` remapped to close windows and delete the buffer (if it is the last buffer window)
*  `gp` remapped to visually reselect the last paste
*  `gb` for quick going to buffer
*  `<leader>l` toggles `list` and `nolist`
*  profiling shortcuts
   * `<leader>DD` starts profiling all functions and files into a file `profile.log`
   * `<leader>DP` pauses profiling
   * `<leader>DC` continues profiling
   * `<leader>DQ` finishs profiling and exits vim

### visual mode
*  `<leader>s` sort selection
*  `>` and `<` automatically reselects the visual selection

## plugins

### [ack.vim](https://github.com/milezs/ack.vim)
*  super fast project searching if you have [ack](http://betterthangrep.com/) installed.
*  if you have [ag](https://github.com/ggreer/the_silver_searcher) installed, it will use that instead
*  `<leader>/`

### [bufkill.vim](http://www.vim.org/scripts/script.php?script_id=1147)
*  `<leader>bd` or `:BD` will kill a buffer without changing the window layout

### [easymotion](https://github.com/skwp/vim-easymotion)
*  easily jumps to any character on the screen
*  `<leader><leader>w` or `<leader><leader>e` will do the trick, along with any of the other default bindings that plugin has mapped under `<leader><leader>`
*  this is a forked version of [lokaltog](https://github.com/skwp/vim-easymotion)'s version which uses vimperator style double keystrokes
*  `W`, `E`, `B`, and `F` are remapped to easymotion equivilents

### [easygrep](http://www.vim.org/scripts/script.php?script_id=2438)
*  makes search/replacing in your project a lot easier without relying on `find` and `sed`
*  `<leader>vv` find word under the cursor
*  `<leader>vV` find whole word under the cursor
*  `<leader>vr` perform global search replace of word under cursor, with confirmation
*  `<leader>vR` same as vr, but matches whole word
*  `<leader>vo` shows options

### [fugitive](https://github.com/tpope/vim-fugitive)
*  git wrapper
*  `<leader>gs` status
*  `<leader>gd` diff
*  `<leader>gc` commit
*  `<leader>gb` blame
*  `<leader>gl` log
*  `<leader>gp` push
*  `<leader>gw` stage
*  `<leader>gr` rm
*  in addition to all the standard bindings when in the git status window, you can also use `U` to perform a `git checkout --` on the current file

### [unimpaired](https://github.com/tpope/vim-unimpaired)
*  many additional bracket `[]` maps
*  `<C-up>` to move lines up
*  `<C-down>` to move lines down

### [nerdtree](https://github.com/scrooloose/nerdtree)
*  file browser
*  `<F2>` toggle browser
*  `<F3>` open tree to path of the current file

### [tcomment](https://github.com/tomtom/tcomment_vim)
*  very versatile commenting plugin that can do motions
*  `gcc` to toggle or `gc{motion}`

### [ctrlp](https://github.com/kien/ctrlp.vim)
*  fuzzy file searching
*  `<C-p>` to bring up the search
*  `<leader>p` search the current buffer tags
*  `<leader>pt` search global tags
*  `<leader>pl` search all lines of all buffers
*  `<leader>o` search open buffers

### [yankstack](http://github.com/maxbrunsfeld/vim-yankstack)
*  keeps a history of all your yanks and deletions
*  `<leader>y` to toggle showing the yank stack
*  after `p`asting, `<BS><BS>` to cycle back, `<BS>\` to cycle forward

### [tabular](https://github.com/godlygeek/tabular)
*  easily aligns code
*  `<leader>a&`, `<leader>a=`, `<leader>a:`, `<leader>a,`, `<leader>a|`

### [golden-ratio](http://github.com/roman/golden-ratio)
*  a plugin which automatically resizes all your splits to give the current one the optimal amount of viewing real estate
*  this plugin will interfere with other plugins which rely on windows, so it is disabled by default and can be toggled on/off with `<F4>`

### [gist](https://github.com/mattn/gist-vim)
*  automatically get or push changes for gists with `:Gist`

### [zencoding](https://github.com/mattn/zencoding-vim)
*  makes for writing html/css extremely fast
*  currently, default plugin mappings are used, which means `<C-y>,` expand

### [gundo](https://github.com/sjl/gundo.vim)
*  visualize the undo tree
*  `<F5>` to toggle

### [youcompleteme](https://github.com/Valloric/YouCompleteMe)/[ultisnips](https://github.com/SirVer/ultisnips)
*  amazingly fast fuzzy autocomplete engine combined with an excellent snippets library

### [neocomplcache](https://github.com/Shougo/neocomplcache)/[neosnippet](https://github.com/Shougo/neosnippet)
*  autocomplete/snippet support as a fallback choice when YCM and/or python is unavailable
*  `<Tab>` to select the next match, or expand if the keyword is a snippet

### [vimshell](https://github.com/Shougo/vimshell)
*  `<leader>c` splits a new window with an embedded shell

### [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)
*  mapped to `<C-N>`, this will select all matching words and lets you concurrently change all matches at the same time

### and the rest
*  [surround](https://github.com/tpope/vim-surround) makes for quick work of surrounds
*  [repeat](https://github.com/tpope/vim-repeat) repeat plugin commands
*  [speeddating](https://github.com/tpope/vim-speeddating) `Ctrl+A` and `Ctrl+X` for dates
*  [gist](https://github.com/mattn/gist-vim) awesome plugin for your gist needs
*  [signature](https://github.com/kshenoy/vim-signature) shows marks beside line numbers
*  [matchit](https://github.com/vim-scripts/matchit.zip) makes your `%` more awesome
*  [syntastic](https://github.com/scrooloose/syntastic) awesome syntax checking for a variety of languages
*  [bufferline](https://github.com/bling/vim-bufferline) simple plugin which prints all your open buffers in the command bar
*  [indent-guides](https://github.com/nathanaelkane/vim-indent-guides) vertical lines
*  and a whole lot more...check the `vimrc` for the full list

## credits

i wanted to give special thanks to all of the people who worked on the following projects, or people simply posted their vim distributions, because i learned a lot and took many ideas and incorporated them into my configuration.

*  [janus](https://github.com/carlhuda/janus)
*  [spf13](https://github.com/spf13/spf13-vim)
*  [yadr](http://skwp.github.com/dotfiles/)
*  [astrails](https://github.com/astrails/dotvim)
*  [tpope](https://github.com/tpope)
*  [scrooloose](https://github.com/scrooloose)
*  [shougo](https://github.com/Shougo)
*  [lokaltog](https://github.com/Lokaltog)
*  [sjl](https://github.com/sjl)

## license
[WTFPL](http://sam.zoy.org/wtfpl/)
