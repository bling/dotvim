# bling.vim

A highly tuned vim distribution that will blow your socks off!

## introduction

this is my ***personal*** vim distribution that i have tweaked over time and evolved from a simple vanilla vimrc configuration to a full-blown distribution that it is today.

while it is very easy to install this and get up and running on a brand new machine (a use case i have), i recommend that you do not install this unless you fully understand everything that's going on inside.  scan it for tips and tricks, or fork and customize it for *your* needs.

## installation

1.  clone this repository into your `~/.vim` directory
1.  `git submodule init && git submodule update`
1.  `mv ~/.vimrc ~/.vimrc.backup`
1.  create the following shim and save it as `~/.vimrc`:

```
let g:dotvim_settings = {}
let g:dotvim_settings.version = 2
source ~/.vim/vimrc
```

1.  startup vim and dein will detect and ask you install any missing plugins.  you can also manually initiate this with `:call dein#install()`
1.  done!

### versioning

the `g:dotvim_settings.version` is a simple version number which is manually edited.  it is used to detect whether significant breaking changes have been introduced so that users of the distribution can be notified accordingly.

## customization

*  since the distribution is just one file, customization is straightforward.  any customizations can be added to the `g:dotvim_settings` variable, which will be used whilst sourcing the distribution's `vimrc` file.  here is an example:

```
" this is the bare minimum
let g:dotvim_settings = {}
let g:dotvim_settings.version = 1

" here are some basic customizations, please refer to the top of the vimrc file for all possible options
let g:dotvim_settings.default_indent = 3
let g:dotvim_settings.max_column = 80
let g:dotvim_settings.colorscheme = 'my_awesome_colorscheme'

" change the default directory where all miscellaneous persistent files go
let g:dotvim_settings.cache_dir = "/some/place/else"

" by default, language specific plugins are not loaded.  this can be changed with the following:
let g:dotvim_settings.plugin_groups_exclude = ['ruby','python']

" if there are groups you want always loaded, you can use this:
let g:dotvim_settings.plugin_groups_include = ['go']

" alternatively, you can set this variable to load exactly what you want
let g:dotvim_settings.plugin_groups = ['core','web']

" if there is a particular plugin you don't like, you can define this variable to disable them entirely
let g:dotvim_settings.disabled_plugins=['vim-foo','vim-bar']

" finally, load the distribution
source ~/.vim/vimrc

" anything defined here are simply overrides
set wildignore+=\*/node_modules/\*
set guifont=Wingdings:h10
```

## autocomplete

this distribution will pick one of three combinations, in the following priority:

1.  [neocomplete][nc] + [neosnippet][ns] if you have `lua` enabled.
2.  [youcompleteme][ycm] + [ultisnips][us] if you have compiled YCM.
3.  [neocomplcache][ncl] + [neosnippet][ns] if you only have vimscript available

this can be overridden with `g:dotvim_settings.autocomplete_method`

## standard modifications

*  if you have either [ack](http://betterthangrep.com/) or [ag](https://github.com/ggreer/the_silver_searcher) installed, they will be used for `grepprg`
*  all temporary files are stored in `~/.vim/.cache`, such as backup files and persistent undo

## mappings

### insert mode
*  `<C-h>` move the cursor left
*  `<C-l>` move the cursor right
*  `jk`, `kj` remapped for "smash escape"

### normal mode
*  `<leader>fef` format entire file
*  `<leader>f$` strip current line of trailing white space
*  window shortcuts
  *  `<leader>v` vertical split
  *  `<leader>s` horizontal split
  *  `<leader>vsa` vertically split all buffers
  *  `<C-h>` `<C-j>` `<C-k>` `<C-l>` move to window in the direction of hkjl
*  window killer
  *  `Q` remapped to close windows and delete the buffer (if it is the last buffer window)
* searching
  *  `<leader>fw` find the word under cursor into the quickfix list
  *  `<leader>ff` find the last search into the quickfix list
  *  `/` replaced with `/\v` for sane regex searching
  *  `<cr>` toggles hlsearch
*  `<Down>` `<Up>` maps to `:bprev` and `:bnext` respectively
*  `<Left>` `<Right>` maps to `:tabprev` and `:tabnext` respectively
*  `gp` remapped to visually reselect the last paste
*  `gb` for quick going to buffer
*  `<leader>l` toggles `list` and `nolist`
*  profiling shortcuts
   * `<leader>DD` starts profiling all functions and files into a file `profile.log`
   * `<leader>DP` pauses profiling
   * `<leader>DC` continues profiling
   * `<leader>DQ` finishes profiling and exits vim

### visual mode
*  `<leader>s` sort selection
*  `>` and `<` automatically reselects the visual selection

## plugins

### [unite.vim](https://github.com/Shougo/unite.vim)
*  this is an extremely powerful plugin that lets you build up lists from arbitrary sources
*  mappings
  *  `<space><space>` go to anything (files, buffers, MRU, bookmarks)
  *  `<space>y` select from previous yanks
  *  `<space>l` select line from current buffer
  *  `<space>b` select from current buffers
  *  `<space>o` select from outline of current file
  *  `<space>s` quick switch buffer
  *  `<space>/` recursively search all files for matching text (uses `ag` or `ack` if found)

### [bufkill.vim](http://www.vim.org/scripts/script.php?script_id=1147)
*  `<leader>bd` or `:BD` will kill a buffer without changing the window layout

### [sneak.vim](https://github.com/justinmk/vim-sneak)
*  motion on steriods

### [easygrep](http://www.vim.org/scripts/script.php?script_id=2438)
*  makes search/replacing in your project a lot easier without relying on `find` and `sed`
*  the loading time of this plugin is relatively heavy, so it is not loaded at startup.  to load it on-demand, use `<leader>vo`, which opens the options window.
*  `<leader>vv` find word under the cursor
*  `<leader>vV` find whole word under the cursor
*  `<leader>vr` perform global search replace of word under cursor, with confirmation
*  `<leader>vR` same as vr, but matches whole word

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

### [gitv](https://github.com/gregsexton/gitv)
*  nice log history viewer for git
*  `<leader>gv`

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
*  `\t` search the current buffer tags
*  `\T` search global tags
*  `\l` search all lines of all buffers
*  `\b` search open buffers
*  `\o` parses the current file for functions with [funky](https://github.com/tacahiroy/ctrlp-funky)

### [nrrwrgn](http://github.com/chrisbra/NrrwRgn)
*  `<leader>nr` puts the current visual selection into a new scratch buffer, allowing you to perform global commands and merge changes to the original file automatically

### [tabular](https://github.com/godlygeek/tabular)
*  easily aligns code
*  `<leader>a&`, `<leader>a=`, `<leader>a:`, `<leader>a,`, `<leader>a|`

### [gist](https://github.com/mattn/gist-vim)
*  automatically get or push changes for gists with `:Gist`

### [emmet](https://github.com/mattn/emmet-vim)
*  makes for writing html/css extremely fast
*  for supported most filetypes, `<tab>` will be mapped to automatically expand the line (you can use `<C-v><Tab>` to insert a tab character if needed)
*  for other features, default plugin mappings are available, which means `<C-y>` is the prefix, followed by a variety of options (see `:help zencoding`)

### [undotree](https://github.com/mbbill/undotree)
*  visualize the undo tree
*  `<F5>` to toggle

### [youcompleteme][ycm]/[ultisnips][us]
*  amazingly fast fuzzy autocomplete engine combined with an excellent snippets library
*  use `<C-n>` and `<C-p>` to go back/forward between selections, and `<tab>` to expand snippets

### [neocomplcache][ncl]/[neosnippet][ns]
*  autocomplete/snippet support as a fallback choice when YCM and/or python is unavailable
*  `<Tab>` to select the next match, or expand if the keyword is a snippet
*  if you have lua installed, it will use [neocomplete][nc] instead

### [vimshell](https://github.com/Shougo/vimshell)
*  `<leader>c` splits a new window with an embedded shell

### [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)
*  mapped to `<C-N>`, this will select all matching words and lets you concurrently change all matches at the same time

# and some more plugins
*  [surround](https://github.com/tpope/vim-surround) makes for quick work of surrounds
*  [repeat](https://github.com/tpope/vim-repeat) repeat plugin commands
*  [speeddating](https://github.com/tpope/vim-speeddating) `Ctrl+A` and `Ctrl+X` for dates
*  [gist](https://github.com/mattn/gist-vim) awesome plugin for your gist needs
*  [signature](https://github.com/kshenoy/vim-signature) shows marks beside line numbers
*  [matchit](https://github.com/vim-scripts/matchit.zip) makes your `%` more awesome
*  [syntastic](https://github.com/scrooloose/syntastic) awesome syntax checking for a variety of languages
*  [bufferline](https://github.com/bling/vim-bufferline) simple plugin which prints all your open buffers in the command bar
*  [indent-guides](https://github.com/nathanaelkane/vim-indent-guides) vertical lines
*  [signify](https://github.com/mhinz/vim-signify) adds + and - to the signs column when changes are detected to source control files (supports git/hg/svn)
*  [delimitmate](https://github.com/Raimondi/delimitMate) automagically adds closing quotes and braces
*  [startify](https://github.com/mhinz/vim-startify) gives you a better start screen

# and even more plugins...
*  i think i've listed about half of the plugins contained in this distribution, so please have a look at the vimrc directly to see all plugins in use

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
*  [terryma](https://github.com/terryma)

## license
[WTFPL](http://sam.zoy.org/wtfpl/)

## changelog

*  v2
  * `NeoBundle` replaced with `dein`
*  v1
  * requires `g:dotvim_settings.version` to be defined
  * disable all langauge-specific plugins by default
  * add support for `g:dotvim_settings.plugin_groups_include`


[ycm]: https://github.com/Valloric/YouCompleteMe
[us]: https://github.com/SirVer/ultisnips
[nc]: https://github.com/Shougo/neocomplete.vim
[ncl]: https://github.com/Shougo/neocomplcache.vim
[ns]: https://github.com/Shougo/neosnippet.vim
