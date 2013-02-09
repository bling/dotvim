vim configuration
=================

1.  installation is simple, just clone this repository into your `~/.vim` directory
2.  make sure to pull down neobundle with `git submodule init && git submodule update`
3.  create a symlink for `~/.vimrc` to `~/.vim/vimrc`
4.  install the fonts found in the `font` directory
5.  run `vim`, and neobundle should automatically ask you to install all the missing plugins. (on windows this doesn't work as expected, so you will need to `:NeoBundleInstall` manually after vim starts up)
6.  done!

license
-------
[WTFPL](http://sam.zoy.org/wtfpl/)
