-- Reference: https://github.com/garcia5/dotfiles/blob/master/files/nvim/after/plugin/autocmd.lua
local augroup = vim.api.nvim_create_augroup

local default_group = augroup("myconf", { clear = true })
local au = function(event, opts)
  opts = opts or {}
  local default_opts = {
    group = default_group,
  }
  opts = vim.tbl_extend("force", default_opts, opts)
  vim.api.nvim_create_autocmd(event, opts)
end

local exit_if_last = function()
  -- TODO: fix this
  -- if vim.fn.winnr("$") == 1 then vim.cmd("q") end
end

-- Trim whitespace
au("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]]
})

-- Trim empty lines at the end of the file
au("BufWritePre", {
  pattern = "*",
  command = [[%s/$\n\+\%$//e]]
})

-- Automatically rebalance windows on vim resize
au("VimResized", {
  pattern = "*",
  callback = function()
    vim.cmd("wincmd =")
  end
})

au("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt.concealcursor = 'c'
  end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = augroup('YankHighlight', { clear = true })
au('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- FILETYPES

local term_group = augroup("term", { clear = false })
au("TermOpen", {
  group = term_group,
  pattern = "*",
  desc = "Terminal display configuration",
  callback = function()
    vim.cmd("startinsert")
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.signcolumn = "no"
  end,
})
au("BufEnter", {
  group = term_group,
  pattern = "*",
  desc = "Auto enter insert mode when entering terminal buffer",
  callback = function()
    local buftype = vim.opt.buftype:get()
    if buftype == "terminal" then
      -- quit if the terminal is the last buffer open
      exit_if_last()
      -- enter insert mode automatically when entering terminal
      vim.cmd("startinsert")
    end
  end,
})

local gitcommit_group = augroup("gitcommit", { clear = true })
au("FileType", {
  group = gitcommit_group,
  desc = "gitcommit formatopts",
  pattern = "gitcommit",
  callback = function() vim.opt_local.formatoptions = "tcrnqj" end,
})

au("BufEnter", {
  pattern = "Dockerfile.*",
  desc = "Detect Dockerfiles with different extensions",
  callback = function() vim.opt_local.filetype = "Dockerfile" end,
})

local nvim_tree_group = augroup("NvimTree", { clear = true })
au("FileType", {
  group = nvim_tree_group,
  pattern = "NvimTree",
  desc = "Quit nvim if NvimTree is the only buffer",
  callback = function()
    exit_if_last()
    vim.opt_local.cursorline = true
  end,
})

au("FileType", {
  pattern = "yaml",
  desc = "Only start yamlls for files that are not pnpm-lock.yaml",
  callback = function(event)
    -- pnpm-lock file, do nothing
    if string.find(event.file, "pnpm%-lock.yaml") then
      return
    end
    -- yamlls already running, do nothing
    local clients = vim.lsp.get_clients()
    for _, client in ipairs(clients) do
      if client.name == "yamlls" then
        return
      end
    end

    -- Start yaml language server
    vim.cmd([[LspStart yamlls]])
  end
})

au("FileType", {
  pattern = "templ",
  desc = "Set tabstop to 2 for templ files",
  callback = function()
    vim.cmd [[setlocal tabstop=2]]
    vim.opt_local.tabstop = 2
  end
})

-- Remove eol for vimwiki files
au("FileType", {
  pattern = "vimwiki",
  callback = function()
    vim.opt_local.listchars = {
      tab = '┊·',
      trail = '·',
      extends = '<',
      precedes = '>',
    }
  end
})
