let g:last_mode = ''
function! ModePrefix()
  let l:mode = mode()
  if l:mode !=# g:last_mode
    let g:last_mode = l:mode

    " default
    hi User1 guifg=#ffffff guibg=#1c1c1c ctermfg=255 ctermbg=233
    " mode
    hi User2 guifg=#005f00 guibg=#dfff00 gui=bold ctermfg=22 ctermbg=190 term=bold
    " mode seperator
    hi User3 guifg=#dfff00 guibg=#444444 ctermfg=190 ctermbg=238
    " info
    hi User4 guifg=#ffffff guibg=#444444 ctermfg=255 ctermbg=238
    " info seperator
    hi User5 guifg=#444444 guibg=#1c1c1c ctermfg=238 ctermbg=233
    " file info
    hi User9 guifg=#ff0000 guibg=#1c1c1c ctermfg=160 ctermbg=233

    if l:mode ==# "i"
      hi User1 guifg=#00ffff ctermfg=14
      hi User2 guibg=#00dfff guifg=#00005f ctermbg=45 ctermfg=17
      hi User3 guibg=#005fff guifg=#00dfff ctermbg=27 ctermfg=45
      hi User4 guibg=#005fff ctermbg=27
      hi User5 guifg=#005fff ctermfg=27
    elseif l:mode ==? "v" || l:mode ==# ""
      hi User2 guibg=#ffaf00 guifg=#000000 ctermbg=214 ctermfg=0
      hi User3 guifg=#ffaf00 guibg=#ff5f00 ctermfg=214 ctermbg=202
      hi User4 guibg=#ff5f00 guifg=#000000 ctermbg=202 ctermfg=0
      hi User5 guifg=#ff5f00 ctermfg=202
    endif
  endif

  if l:mode ==# "n"
    return "  NORMAL "
  elseif l:mode ==# "i"
    return "  INSERT "
  elseif l:mode ==# "R"
    return "  RPLACE "
  elseif l:mode ==# "v"
    return "  VISUAL "
  elseif l:mode ==# "V"
    return "  V·LINE "
  elseif l:mode ==# ""
    return "  V·BLCK "
  else
    return l:mode
  endif
endfunction

set statusline=%2*%{ModePrefix()}%3*▶%4*
set statusline+=%{exists('g:loaded_fugitive')&&strlen(fugitive#statusline())>0?'\ ':''}
set statusline+=%{exists('g:loaded_fugitive')?matchstr(fugitive#statusline(),'(\\zs.*\\ze)'):''}
set statusline+=%{exists('g:loaded_fugitive')&&strlen(fugitive#statusline())>0?'\ \ ':'\ '}
set statusline+=%5*▶\ %1*%f\ %<
set statusline+=%9*%{&ro?'RO':''}%{&mod?'+':''}
set statusline+=%#warningmsg#
set statusline+=%{exists('g:loaded_syntastic_plugin')?SyntasticStatuslineFlag():''}
set statusline+=%1*%=%{strlen(&filetype)>0?&filetype.'\ ':''}%5*◀%4*\ 
set statusline+=%{strlen(&fileencoding)>0?&fileencoding:''}
set statusline+=%{strlen(&fileformat)>0?'['.&fileformat.']':''}
set statusline+=\ %3*◀
set statusline+=%2*\ %3p%%\ ◇\ %3l:%3c\ 
