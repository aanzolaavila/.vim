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

" Change from one tab to another directionally
nnoremap <S-L> gt
nnoremap <S-H> gT

" In Visual Mode, when I press . execute it as I would run it in Normal Mode, over the selected lines
vnoremap . :normal.<CR>

" Move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" HARD MODE - Disable arrow keys in Normal mode
:noremap <left> <nop>
:noremap <right> <nop>
:noremap <up> <nop>
:noremap <down> <nop>

" Telescope plugin
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Todoist
nnoremap <leader>t <cmd>Todoist Personal<cr>
nnoremap <leader>T <cmd>Clap todoist<cr>

" Buffer Next Previous
nnoremap <leader>h <cmd>bprev<cr>
nnoremap <leader>l <cmd>bnext<cr>

" Tabs
nnoremap T <cmd>tabnew<cr>

" For autocompletion
" will select completion if <cr> is pressed
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" use <tab> and <s-tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
