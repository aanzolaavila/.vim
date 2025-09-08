-- Performance improvement
vim.opt.lazyredraw = true

-- Display all matching files when we tab complete
vim.opt.wildmenu = true

-- Display filename on top corner of window
vim.opt.winbar = "%=%m %f"

-- Disable swapfiles
vim.opt.swapfile = false

vim.opt.encoding = "utf-8"
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.copyindent = true
vim.opt.preserveindent = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
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
vim.opt.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.opt.termguicolors = true

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Prevent symbols to disapear in any filetype
vim.g.vim_json_syntax_conceal = 0
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Enable Quick list and Location list filters
-- Use 'Cfilter' and 'Lfilter'
vim.cmd('packadd cfilter')

-- which-key plugin options
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.opt.path = ",**"
