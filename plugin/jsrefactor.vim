function! s:defineToRequire()
    let temp = @t

    "delete arguments in array
    normal! di[/\m{op
    "join to a single line and strip of whitespace
    normal! `[v`]JV:s/\s//g
    "put them on seperate lines
    normal! V:s/,/\r/g
    "prepend require for each variable
    normal! ``Irequire(
    "add semi colon at end
    normal! V``:s/'$/');/g
    "join into same line

    "go back to arguments
    normal! ?\m{bbci(require/\m{op0
    "break to multiple lines
    normal! V:s/,/\r/g
    "strip all whitespace
    normal! V``:s/\s//g
    "prepend var
    normal! ``o$Ivar 
    "append =
    normal! `]$A = 
    "select and cut into t
    normal! `]"tx

    "delete until r
    normal! d/r
    "paste from t
    normal! "tP
    "reselect and format
    normal! `[v`]$=
    "trim extra spaces
    normal! `[v`]:s/=\s*/= /g

    "go back to function and delete
    normal! ?function
    normal! d?(i(

    let @t = temp
endfunction

function! s:objectArgs()
    let temp1 = @q
    let temp2 = &hlsearch

    setlocal nohlsearch

    "recursive macro which turns 'a,b,c' into 'var a=p.a; var b=p.b; var c=p.c'
    let @q='ywivar pa = parameters.f,l@q'

    "delete args and enter parameters, paste to new line
    normal! di(iparameters/\m{2okp
    "delete whitespace
    normal! g`[v`]Jgv:s/\s//g0
    "recursive macro
    try
        normal! @q
    endtry
    "append ; and reformat
    normal! A;V:s/,/;\r/gv``=

    let @q = temp1
    let &hlsearch = temp2
endfunction

autocmd FileType javascript nnoremap <leader>rdr :call <SID>defineToRequire()<cr>
autocmd FileType javascript nnoremap <leader>ro :call <SID>objectArgs()<cr>

" put cursor on _f_unction, and it will _.bind it 'this'
autocmd FileType javascript nnoremap <leader>rb i_.bind(f{%a, this)
