-- Performance improvement
vim.opt.lazyredraw = true

-- Display all matching files when we tab complete
vim.opt.wildmenu = true

-- Display filename on top corner of window
vim.opt.winbar = "%=%m %f"

vim.opt.encoding = "utf-8"
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.copyindent = true
vim.opt.preserveindent = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.hlsearch = false
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.visualbell = true
vim.opt.sw = 2
vim.opt.showmatch = true
vim.opt.spelllang = "en,es"

-- Text rendering options
vim.opt.linebreak = true
vim.opt.scrolloff = 8
vim.opt.scrolljump = -100
vim.opt.sidescrolloff = 5

-- Status line
vim.opt.statusline = "%F%m%r%h%w%=(%{&ff}/%Y) (line %l/%L, col %c)"

-- Save with LF, try to read as LF or as CRLF
vim.opt.fileformats = "unix,dos"

vim.opt.colorcolumn = "80"

vim.g.python3_host_prog = vim.fn.expand("~") .. "/.pyenv/versions/neovim/bin/python3"

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '.'

-- Prevent symbols to disapear in any filetype
vim.g.vim_json_syntax_conceal = 0
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- THEME
vim.cmd [[colorscheme habamax]]

-- Custom Tab Line
-- Taken from: https://superuser.com/questions/331272/vim-show-the-index-of-tabs-in-the-tabline
vim.cmd [[
" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! CustomTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!CustomTabLine()
    set showtabline=1
    highlight link TabNum Special
endif
]]
