" REFERENCES
" https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/

" If Plug is not installed, then install it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Sensible defaults
Plug 'tpope/vim-sensible'

" Telescope
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'sharkdp/fd'
Plug 'BurntSushi/ripgrep'
Plug 'kyazdani42/nvim-web-devicons'

" Targets
Plug 'wellle/targets.vim'

" Todoist
" Plug 'romgrk/todoist.nvim', { 'do': ':TodoistInstall' }
" Plug 'liuchengxu/vim-clap'

" Conquer of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Polyglot
" Disabled because it causes a big slowdown switching from one tab to another
Plug 'sheerun/vim-polyglot'

" Undotree
Plug 'mbbill/undotree'

" Doom One colorscheme
" Plug 'romgrk/doom-one.vim'

" Nord Vim colorscheme
" Plug 'arcticicestudio/nord-vim'

" ayu vim colorscheme
Plug 'ayu-theme/ayu-vim'

" Status bar plugin
Plug 'vim-airline/vim-airline'

" Automatic quote and bracket completion
Plug 'tpope/vim-surround'

" Auto-pairs
Plug 'jiangmiao/auto-pairs'

" Comment plugin
" To comment out a single line, use `<leader>cc`
" To uncomment a line, use `<leader>cu`
Plug 'preservim/nerdcommenter'

" Code auto-format plugin
Plug 'sbdchd/neoformat'

" File managing and exploration plugin
Plug 'scrooloose/nerdtree'

" Code checker plugin
Plug 'neomake/neomake'

" Multiple cursor editing plugin
" In normal mode, move the cursor to a variable you want to rename, press <Ctrl-N> and this variable will be highlighted. Continue press <Ctrl-N>, the next occurrence of this variable will be highlighted. If you want to skip a certain occurrence (for example, a string may contain a sub-string which is the same as the variable), just press <Ctrl-X> after this position has been highlighted. Continue selecting the occurrence of this variable until all its occurrence has been selected.
" Now, press c (in Nvim, c means to change ) and enter insert mode. Input a new name and save.
Plug 'terryma/vim-multiple-cursors'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Vim buffergator
" Use <Leader>b (typically: \b) to open a window listing all buffers. In this window, you can use normal movement keys to select a buffer and then:
    " <ENTER> to edit the selected buffer in the previous window
    " <C-V> to edit the selected buffer in a new vertical split
    " <C-S> to edit the selected buffer in a new horizontal split
    " <C-T> to edit the selected buffer in a new tab page
"
" Use gb (or <M-b>) and gB (or <M-S-b>) to flip through the most-recently used buffer stack without opening the buffer listing "drawer".
"
" Use <Leader><LEFT>, <Leader><UP>, <Leader><RIGHT>, <Leader><DOWN> to split a new window left, up, right, or down, respectively, and edit the previous MRU buffer there.
" Plug 'jeetsukumaran/vim-buffergator'

" Indent guides
Plug 'thaerkh/vim-indentguides'

" Vim Workspace
Plug 'thaerkh/vim-workspace'

call plug#end()
