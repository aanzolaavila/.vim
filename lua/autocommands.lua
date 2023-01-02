-- Trim whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]]
})

-- Trim empty lines at the end of the file
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/$\n\+\%$//e]]
})

-- Auto format lines on wiki files
local wiki_group = vim.api.nvim_create_augroup('Wiki', { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.wiki",
  command = [[g/./ normal gqq``]],
  group = wiki_group,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.wiki",
  callback = function ()
    vim.opt.filetype = 'markdown'
  end,
  group = wiki_group,
})


-- Automatically rebalance windows on vim resize
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  callback = function()
    vim.cmd("wincmd =")
  end
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})
