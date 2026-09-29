local opts = {
  picker = "minipick",

  lsp = {
    -- `config` is passed to `vim.lsp.start(config)`
    config = {
      name = "zk",
      cmd = { "zk", "lsp" },
      filetypes = { "markdown" },
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
    },
  },
}

-- TODO: take location from actual configuration
local zkdir = vim.fn.expand '$ZK_NOTEBOOK_DIR'

local zk = require('zk')
local commands = require('zk.commands')

zk.setup(opts)

-- COMMANDS
local function make_edit_fn(defaults, picker_options)
  return function(options)
    options = vim.tbl_extend("force", defaults, options or {})
    zk.edit(options, picker_options)
  end
end

commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
commands.add("ZkRecents", make_edit_fn({ createdAfter = "1 weeks ago" }, { title = "Zk Recents" }))

-- MAPPINGS
-- disable all vimwiki mappings
vim.g.vimwiki_key_mappings = {
  all_maps = 0,
}
local function create_autocommand(callback)
  assert(callback)

  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = zkdir .. '**/*.md',
    callback = callback,
  })
end

local function create_user_command(name, command, opts)
  assert(name and command)
  opts = opts or {}

  create_autocommand(function()
    vim.api.nvim_buf_create_user_command(0, name, command, opts)
  end)
end

local function get_monday_start(target_time)
  assert(target_time)
  local wday = os.date("*t", target_time).wday

  -- In Lua: Sun=1, Mon=2, Tue=3, Wed=4, Thu=5, Fri=6, Sat=7
  -- To make Mon=0, Tue=1, ..., Sun=6:
  local days_to_subtract = (wday + 5) % 7

  local monday_time = target_time - (days_to_subtract * 86400)
  return monday_time
end

local function path_exists(path)
  assert(path)
  local expanded_path = vim.fn.expand(path)
  local stat = vim.uv.fs_stat(expanded_path)
  return stat ~= nil
end

local function filepicker_select(folder, callback, picker)
  assert(folder and callback)
  picker = picker or 'grep_live'

  local builtin_pickers = require('mini.pick').builtin
  local extra_pickers = require('mini.extra').pickers
  local pickers = vim.tbl_extend('keep', builtin_pickers, extra_pickers)

  local mini_picker = pickers[picker]
  if not mini_picker then
    vim.notify(string.format("Selected picker [%s] does not exist in mini.pick", picker), vim.log.levels.ERROR)
    return
  end

  mini_picker({
    globs = '**/*.md',
  }, {
    source = {
      cwd = folder,
      name = "Zk Search",
      choose = function(item)
        assert(item)

        -- 'item' looks like: "path/to/file.md:10:5:matching text"
        -- separator is a null value
        -- We use Lua patterns to extract the filename and line number
        local parts    = vim.split(item, "%z")
        local filename = parts[1]
        local line     = tonumber(parts[2])
        local col      = tonumber(parts[3])
        local content  = parts[4]

        -- Fallback if the pattern doesn't match for some reason
        filename       = filename or item
        callback({
          filename = filename,
          line = line,
          col = col,
          content = content,
        })
      end
    }
  })
end

local function go_to_file_location(filepath, line, col)
  assert(filepath and line and col)
  local expanded_path = vim.fn.expand(filepath)

  local bufnr = vim.fn.bufadd(expanded_path)
  vim.fn.bufload(bufnr)
  vim.api.nvim_win_set_buf(0, bufnr)

  local target_line = line or 1
  local target_col = col or 0

  pcall(vim.api.nvim_win_set_cursor, 0, { target_line, target_col })
end

vim.keymap.set('n', '<leader>ww', function()
  vim.cmd(string.format('edit %s/index.md', zkdir))
end, { desc = 'Zk Main page (index)' })

vim.keymap.set('n', '<leader>w<space>w', function()
  local today = os.time()
  local first_day_of_week = get_monday_start(today)

  local id = os.date('%Y-%m-%d', first_day_of_week)
  local path = string.format('%s/diary/%s.md', zkdir, id)

  if path_exists(path) then
    vim.schedule(function()
      vim.cmd('edit ' .. path)
    end)
    return
  end

  require('zk.api').new(path, {
    dir = 'diary',
    group = 'diary',
    title = id,
    edit = true,
    dryRun = false,
  })
end, {
  desc = 'Zk New Diary (weekly)',
  -- buf = event.buf,
})


vim.keymap.set('n', '<leader>wt', function()
  commands.get('ZkTags')()
end, { desc = 'Zk Tags' })

vim.keymap.set('n', '<leader>wg', function()
  filepicker_select(zkdir, function(selection)
    if not selection then
      vim.notify("Nothing selected", vim.log.levels.INFO)
      return
    end

    local filepath = string.format('%s/%s', zkdir, selection.filename)
    local line = selection.line
    local col = selection.col
    vim.schedule(function()
      go_to_file_location(filepath, line, col)
    end)
  end)
end, { desc = 'Zk Grep Search' })

vim.keymap.set('n', '<leader>wn', function()
  commands.get('ZkNew')()
end, { desc = 'Zk New' })

vim.keymap.set('v', '<leader>wn', function()
  commands.get('ZkNewFromTitleSelection')()
end, { desc = 'Zk New (title from visual selection)' })

vim.keymap.set('v', '<leader>wm', function()
  commands.get('ZkMatch')()
end, { desc = 'Zk Match' })
