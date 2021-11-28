" adds commands for capitalization of words and sentences
if (&tildeop)
  nmap gcw guw~l
  nmap gcW guW~l
  nmap gciw guiw~l
  nmap gciW guiW~l
  nmap gcis guis~l
  nmap gc$ gu$~l
  nmap gcgc guu~l
  nmap gcc guu~l
  vmap gc gu~l
else
  nmap gcw guw~h
  nmap gcW guW~h
  nmap gciw guiw~h
  nmap gciW guiW~h
  nmap gcis guis~h
  nmap gc$ gu$~h
  nmap gcgc guu~h
  nmap gcc guu~h
  vmap gc gu~h
endif

" Stamping
nnoremap S diw"0P

" When going through search results keep match at the center
nnoremap n nzz
nnoremap N Nzz

" When going up or down also keep it at the center
nnoremap <C-U> <C-U>zz
nnoremap <C-D> <C-D>zz

" Common typos
:command WQ wq
:command Wq wq
:command W w
:command Q q
:command Qa qa
:command QA qa

" Change from one windows to another directionally
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

"----------------------------------------------------------------
" Tabs
nnoremap T <cmd>tabnew<cr>
nnoremap <S-L> <cmd>tabn<cr>
nnoremap <S-H> <cmd>tabp<cr>
nnoremap <leader><S-H> <cmd>tabm -1<cr>
nnoremap <leader><S-L> <cmd>tabm +1<cr>

" REF: https://vim.fandom.com/wiki/Move_current_window_between_tabs
function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

nnoremap <leader><C-m> :call MoveToNextTab()<CR><C-w>H
nnoremap <leader><C-n> :call MoveToPrevTab()<CR><C-w>H

"----------------------------------------------------------------

" In Visual Mode, when I press . execute it as I would run it in Normal Mode, over the selected lines
vnoremap . :normal.<CR>

" Move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" HARD MODE - Disable arrow keys in Normal mode
noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>

" Telescope plugin
runtime plugin-mappings/telescope.vim

" Todoist plugin
runtime plugin-mappings/todoist.vim

" Buffer Next Previous
nnoremap <leader>h <cmd>bprev<cr>
nnoremap <leader>l <cmd>bnext<cr>

" NERDTree plugin
nnoremap <C-t> :NERDTreeToggle<CR>

" Conquer of Completion plugin
runtime plugin-mappings/coc.vim

" Terminal emulator
" can press <Esc> to get out of terminal
tnoremap <Esc> <C-\><C-n>
