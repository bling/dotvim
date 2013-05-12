let g:last_mode = ''
function! Mode()
  let l:mode = mode()
  if l:mode !=# g:last_mode
    let g:last_mode = l:mode

    " default
    hi User1 guifg=#ffffff guibg=#1c1c1c ctermfg=255 ctermbg=234
    " mode
    hi User2 guifg=#005f00 guibg=#dfff00 gui=bold ctermfg=22 ctermbg=190
    " mode seperator
    hi User3 guifg=#dfff00 guibg=#444444 ctermfg=255 ctermbg=238
    " info
    hi User4 guifg=#ffffff guibg=#444444 ctermfg=255 ctermbg=238
    " info seperator
    hi User5 guifg=#444444 guibg=#1c1c1c ctermfg=238 ctermbg=234
    " file info
    hi User9 guifg=#ff0000 guibg=#1c1c1c ctermfg=9 ctermbg=234

    if l:mode ==# "i"
      hi User1 guibg=#00dfff guifg=#000000
      hi User2 guibg=#00dfff guifg=#000000
      hi User3 guifg=#00dfff
      hi User5 guibg=#00dfff
      hi User9 guibg=#00dfff
    elseif l:mode ==? "v" || l:mode ==# ""
      hi User1 guibg=#ffaf00 guifg=#000000
      hi User2 guibg=#ffaf00 guifg=#000000
      hi User3 guifg=#ffaf00
      hi User5 guibg=#ffaf00
      hi User9 guibg=#ffaf00
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

set statusline=%2*%{Mode()}%3*▶%4*
set statusline+=%{strlen(fugitive#statusline())>0?'\ ':''}
set statusline+=%{matchstr(fugitive#statusline(),'(\\zs.*\\ze)')}
set statusline+=%{strlen(fugitive#statusline())>0?'\ \ ':'\ '}
set statusline+=%5*▶\ %1*%f\ 
set statusline+=%9*%{&ro?'◘':''}%{&mod?'+':''}%<
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%5*%=◀%4*
set statusline+=\ %{strlen(&fileformat)>0?&fileformat.'\ ◇\ ':''}
set statusline+=%{strlen(&fileencoding)>0?&fileencoding.'\ ◇\ ':''}
set statusline+=%{strlen(&filetype)>0?&filetype:''}
set statusline+=\ %3*◀
set statusline+=%2*\ %3p%%\ ◇\ %3l:%3c\ 
