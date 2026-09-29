local root_dir = "~/Documents/notes"

local builtin = require("obsidian.builtin")
local obsidian = require('obsidian')

-- reference: https://github.com/obsidian-nvim/obsidian.nvim/blob/main/lua/obsidian/config/default.lua
local opts = {
  legacy_commands = false, -- this will be removed in the next major release
  ui = {
    enable = true,
    ignore_conceal_warn = true,
  },
  note_id_func = builtin.title_id,
  templates = {
    folder = "Templates",
  },
  attachments = {
    folder = "Media",
    img_text_func = builtin.img_text_func,
    img_name_func = function()
      return os.date "%Y%m%d%H%M"
    end,
    confirm_img_paste = true, -- TODO: move to paste module, paste.confirm
  },
  workspaces = {
    {
      name = "general",
      path = root_dir .. "/general",
      strict = true,
    },
  }
}

obsidian.setup(opts)

-- Markdown Filetype for Obsidian

local obsidian_group = vim.api.nvim_create_augroup('Obsidian', { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = root_dir .. "/**.md",
  callback = function()
    vim.opt_local.syntax = 'markdown'
    vim.opt_local.conceallevel = 2
  end,
  group = obsidian_group,
})
