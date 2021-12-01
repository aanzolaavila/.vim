" Trim whitespace
autocmd BufWritePre * %s/\s\+$//e

" Trim empty lines at the end of the file
autocmd BufWritePre * %s/$\n\+\%$//e

" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
