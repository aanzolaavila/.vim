" REFERENCES
" https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/

call plug#begin('~/.vim/plugged')

" Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'sharkdp/fd'
Plug 'BurntSushi/ripgrep'
Plug 'kyazdani42/nvim-web-devicons'

" Targets
Plug 'wellle/targets.vim'

" Todoist
Plug 'romgrk/todoist.nvim', { 'do': ':TodoistInstall' }
Plug 'liuchengxu/vim-clap'

" Conquer of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Polyglot
Plug 'sheerun/vim-polyglot'

" Undotreew
Plug 'mbbill/undotree'

" Doom One colorscheme
Plug 'romgrk/doom-one.vim'

" Status bar plugin
Plug 'vim-airline/vim-airline'

" Automatic quote and bracket completion
Plug 'jiangmiao/auto-pairs'

" Comment plugin
" To comment out a single line, use `<leader>cc`
" To uncomment a line, use `<leader>cu`
Plug 'scrooloose/nerdcommenter'

" Code auto-format plugin
Plug 'sbdchd/neoformat'

" Code jump plugin
" <leader>d: go to definition
" K: check documentation of class or method
" <leader>n: show the usage of a name in current file
" <leader>r: rename a name
Plug 'davidhalter/jedi-vim'

" File managing and exploration plugin
Plug 'scrooloose/nerdtree'

" Code checker plugin
Plug 'neomake/neomake'

call plug#end()

source ~/.vim/plugin-options.vim
