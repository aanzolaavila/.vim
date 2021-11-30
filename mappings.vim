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
" Buffers
nnoremap T <cmd>enew<cr>
nnoremap <S-L> <cmd>bnext<cr>
nnoremap <S-H> <cmd>bprev<cr>
nnoremap <silent> <C-x> <cmd>bdelete<CR>

"----------------------------------------------------------------
" Tabs
nnoremap <leader>l gt
nnoremap <leader>h gT
nnoremap <leader>T <cmd>tabnew<cr>
nnoremap <leader><S-H> <cmd>tabm -1<cr>
nnoremap <leader><S-L> <cmd>tabm +1<cr>

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

" Conquer of Completion plugin
runtime plugin-mappings/coc.vim

" Terminal emulator
" can press <Esc> to get out of terminal
tnoremap <Esc> <C-\><C-n>

" Reload config
nnoremap <silent> <leader>r <cmd>source ~/.vim/init.vim<cr>

" NERDCommenter
runtime plugin-mappings/nerdcommenter.vim

" NERDTree plugin
runtime plugin-mappings/nerdtree.vim
