let g:statusline_left_sep="▶"
let g:statusline_right_sep="◀"
let g:statusline_left_sep=">"
let g:statusline_right_sep="<"

hi StatusLineNC guifg=#000000 guibg=#202020 ctermfg=0   ctermbg=234
hi User8        guifg=#4e4e4e guibg=#1c1c1c ctermfg=239 ctermbg=234

function! StatusLineModePrefix()
  let l:mode = mode()

  hi StatusLine   guifg=#9cffd3 guibg=#202020 ctermfg=85  ctermbg=234

  " mode
  hi User2 guifg=#005f00 guibg=#dfff00 ctermfg=22  ctermbg=190 gui=bold term=bold
  " mode seperator
  hi User3 guifg=#dfff00 guibg=#444444 ctermfg=190 ctermbg=238
  " info
  hi User4 guifg=#ffffff guibg=#444444 ctermfg=255 ctermbg=238
  " info seperator
  hi User5 guifg=#444444 guibg=#202020 ctermfg=238 ctermbg=234
  " file info
  hi User9 guifg=#ff0000 guibg=#1c1c1c ctermfg=160 ctermbg=233

  if l:mode ==# "i"
    hi StatusLine ctermfg=15 ctermbg=18
    hi User2 guibg=#00dfff guifg=#00005f ctermfg=17  ctermbg=45
    hi User3 guibg=#005fff guifg=#00dfff ctermfg=45  ctermbg=27
    hi User4 guibg=#005fff                           ctermbg=27
    hi User5 guifg=#005fff guibg=#ffffff ctermfg=27  ctermbg=18
  elseif l:mode ==? "v" || l:mode ==# ""
    hi User2 guibg=#ffaf00 guifg=#000000 ctermfg=0   ctermbg=214
    hi User3 guifg=#ffaf00 guibg=#ff5f00 ctermfg=214 ctermbg=202
    hi User4 guibg=#ff5f00 guifg=#000000 ctermfg=0   ctermbg=202
    hi User5 guifg=#000000               ctermfg=202
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

" init colors
call StatusLineModePrefix()

function! s:update_statusline(active)
  if a:active
    let l:mode_color = "%2*"
    let l:mode_sep_color = "%3*"
    let l:info_color = "%4*"
    let l:info_sep_color = "%5*"
    let l:statusline=l:mode_color."%{StatusLineModePrefix()}".l:mode_sep_color
  else
    let l:mode_color = "%8*"
    let l:mode_sep_color = "%8*"
    let l:info_color = "%8*"
    let l:info_sep_color = "%8*"
    let l:statusline=l:mode_color." NORMAL %8*"
  endif
  let l:statusline.="%{g:statusline_left_sep}"
  let l:statusline.=l:info_color."%{exists('g:loaded_fugitive')&&strlen(fugitive#statusline())>0?'\ ':''}"
  let l:statusline.="%{exists('g:loaded_fugitive')?matchstr(fugitive#statusline(),'(\\zs.*\\ze)'):''}"
  let l:statusline.="%{exists('g:loaded_fugitive')&&strlen(fugitive#statusline())>0?'\ \ ':'\ '}"
  let l:statusline.=l:info_sep_color."%{g:statusline_left_sep}"
  if a:active
    let l:statusline.="%*\ %{bufferline#generate_string()}\ "
  else
    let l:statusline.=" ".bufname(winbufnr(winnr()))
  endif
  let l:statusline.="%#warningmsg#"
  let l:statusline.="%{exists('g:loaded_syntastic_plugin')?SyntasticStatuslineFlag():''}"
  let l:statusline.="%*%=%9*%{&ro?'RO':''}%*\ "
  let l:statusline.="%{strlen(&filetype)>0?&filetype:''}\ "
  let l:statusline.=l:info_sep_color."%{g:statusline_right_sep}"
  let l:statusline.=l:info_color."\ "
  let l:statusline.="%{strlen(&fileencoding)>0?&fileencoding:''}"
  let l:statusline.="%{strlen(&fileformat)>0?'['.&fileformat.']':''}"
  let l:statusline.="\ ".l:mode_sep_color."%{g:statusline_right_sep}"
  let l:statusline.=l:mode_color."\ %3p%%\ ◇\ %3l:%3c\ "
  call setwinvar(winnr(), '&statusline', l:statusline)
endfunction

augroup airline
  au!
  autocmd WinLeave * call <sid>update_statusline(0)
  autocmd VimEnter,WinEnter * call <sid>update_statusline(1)
augroup END
