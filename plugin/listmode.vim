let s:enabled = 0

nnoremap <C-p> :call ToggleListMode()<CR>
function! ToggleListMode()
    if s:enabled
		set listchars=
		set nolist
        let s:enabled = 0
    else
		set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
		set list
        let s:enabled = 1
    endif
endfunction
