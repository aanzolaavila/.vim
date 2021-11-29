" Trim whitespace
autocmd BufWritePre * %s/\s\+$//e

" Trim empty lines at the end of the file
autocmd BufWritePre * %s/$\n\+\%$//e
