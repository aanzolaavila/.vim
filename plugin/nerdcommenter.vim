" No default mappings
let g:NERDCreateDefaultMappings = 0

" Add spaces after comment delimiters
let g:NERDSpaceDelims = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

vnoremap <leader>c :call nerdcommenter#Comment("", "Toggle")<CR>
nnoremap <leader>c :call nerdcommenter#Comment("", "Toggle")<CR>
