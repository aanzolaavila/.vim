require('mini.files').setup()

vim.keymap.set('n', '<leader>t', function()
  -- Toggle the MiniFiles UI
  if not MiniFiles.close() then
    MiniFiles.open()
  end
end, { remap = true, desc = "Toggle file [t]ree view" })

-- Mapping to show/hide dot files

local show_dotfiles = true
local filter_show = function(fs_entry) return true end
local filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, '.')
end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  MiniFiles.refresh({ content = { filter = new_filter } })
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak left-hand side of mapping to your liking
    vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
  end,
})

-- Mapping to show current buffer location

vim.keymap.set('n', '<localleader>ff', function()
  local current_buf = vim.api.nvim_buf_get_name(0)
  MiniFiles.open(current_buf, false)
  vim.defer_fn(function()
    MiniFiles.reveal_cwd()
  end, 30)
end, { desc = "locate [f]ile on [f]inder" })

-- Bookmarks

local set_mark = function(id, path, desc)
  MiniFiles.set_bookmark(id, path, { desc = desc })
end
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesExplorerOpen',
  callback = function()
    set_mark('c', vim.fn.stdpath('config'), 'neovim config')
    set_mark('w', vim.fn.getcwd, 'working directory')
    set_mark('z', '~/.zsh', 'zsh config')
    set_mark('g', '~/.local/share/chezmoi', 'general config (chezmoi)')
    set_mark('~', '~', 'home directory')
  end,
})
