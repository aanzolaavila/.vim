colorscheme murphy

set scrolloff=999
set scrolljump=-100 

" Performance improvement
set lazyredraw

" enter the current millenium
set nocompatible

" ================================ 
" PLUGINS
" ================================ 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugins')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
call vundle#end()
" ================================ 
" END PLUGINS
" ================================ 

" enable syntax and plugins (netrw)
syntax enable
filetype plugin on

" --- 
" FINDING FILES:
" search down into subfolders
" provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer

" ---
" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" ---
" AUTOCOMPLETE:
" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for for tags only
" - ^n for anything specified by the 'complete' option

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list

" --- 
" FILE BROWSING:
" Tweaks for browsing
let g:netrw_banner=0          " disable annoying banner
let g:netrw_browse_split=4    " open in prior window
let g:netrw_altv=1            " open splits to the right
let g:netrw_liststyle=3       " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
let g:netrw_winsize = 20

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings

" show line number on the current line and relative numbers on all other lines
set number relativenumber

" new lines inherit the indentation of previous lines
set autoindent

" indent using four spaces
set tabstop=4

" when indenting with '>', use 2 spaces width
set shiftwidth=2

" on pressing tab, insert 4 space
set expandtab

" enable search highlighting
set hlsearch

" ignore case when searching
set ignorecase

" always show cursor position
set ruler

" highlight the line currently under cursor
set cursorline
" highlight CursorLine guibg=lightblue ctermbg=lightgrey

" always display the status bar
set laststatus=2

" flash the screen instead of beeping on errors
set visualbell

" increase the undo limit
set history=1000

" enable to use the mouse on the editor
set mouse=a

" show command in the last line of the screen
set showcmd

set sw=2
set showmatch
set encoding=utf-8
syntax on
set clipboard=unnamed
set laststatus=2
" set noshowmode
set showmode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" enable spell checking
set nospell
set spelllang=en,es

" allow backspacing over indention, line breaks ans insertion start
set backspace=indent,eol,start

" automatically re-read files if unmodified inside Vim
set autoread

" disable beep on errors
set noerrorbells

"" Swap and backup file option 
" set noswapfile " disable swap files
set directory=$HOME/.vim/swp// " specify the directory for swap files
set nobackup " disable backups
" set backupdir=$HOME/.vim/.backup// " specify backup location of files
set nowb

"" Text rendering options
" wrap lines at convenient points, avoid wrapping a line in the middle of a
" word
set linebreak

" the number of screen lines to keep above and below the cursor 
set scrolloff=3

" the number of screen columns to keep to the left and right of the cursor
set sidescrolloff=5

"" Status line
" :help statusline
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)
" set statusline=%t       "tail of the filename
" set statusline+=%{&ff}  "file format`
" set statusline+=%h      "help file flag
" set statusline+=%m      "modified flag
" set statusline+=%r      "read only flag
" set statusline+=%y      "file type
" set statusline+=%c,     "cursor column
" set statusline+=%l/%L   "cursor line/total lines
" set statusline+=\ %P    "percent through file

" Maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

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

" Common typos
:command WQ wq
:command Wq wq
:command W w
:command Q q

" Change from one windows to another directionally
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

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
