"================================
" PLUGIN OPTIONS
"================================

" NEOFORMAT
" Basic formating for NeoFormat plugin
" enable alignment
let g:neoformat_basic_format_align = 1

" enable tab to space conversion
let g:neoformat_basic_format_retab = 1

" enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

" makes neoformat more verbose
"let g:neoformat_verbose = 1 " only affects the verbosity of Neoformat

"--------------------------------
" NEOMAKE
let g:neomake_python_enabled_makers = ['pylint']
call neomake#configure#automake('nrwi', 500)

"--------------------------------
" AIRLINE
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
