set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugins')
" ================================ 
" ================================ 

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Telescope
Plugin 'nvim-telescope/telescope.nvim'
Plugin 'nvim-lua/plenary.nvim'
Plugin 'sharkdp/fd'
Plugin 'BurntSushi/ripgrep'
Plugin 'kyazdani42/nvim-web-devicons'

" Targets plugin
Plugin 'wellle/targets.vim'

" ================================ 
" ================================ 
call vundle#end()
