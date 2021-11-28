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

"-------------------------------- 
" JEDI-VIM
" disable autocompletion, because we already have it with other plugin
let g:jedi#completions_enabled = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"

"--------------------------------
" NEOMAKE
let g:neomake_python_enabled_makers = ['pylint']
call neomake#configure#automake('nrwi', 500)
