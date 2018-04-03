
match errormsg /\s\+$/

augroup trimWhitespaces
  autocmd FileWritePre * :call g:TrimWhitespaces()
  autocmd BufWritePre  * :call g:TrimWhitespaces()
augroup END

if !exists("g:trimWhitespaces")
  let g:trimWhitespaces = 1
endif

if !exists("g:trimWhitespaces_ignore_filetypes")
  let g:trimWhitespaces_ignore_filetypes = [
    \ 'diff',
    \ 'gitcommit',
    \ 'mail',
    \]
endif

function! g:TrimWhitespaces()
  if g:trimWhitespaces != 1
    return
  endif

  for ignored in g:trimWhitespaces_ignore_filetypes
      if &filetype =~ ignored
          return
      endif
  endfor

  let l:l = line('.')
  let l:c = col('.')

  %s/\s\+$//e

  call cursor(l:l, l:c)
endfunction

