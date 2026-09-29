local wiki_dir = vim.fn.expand '~' .. '/wiki'
if vim.fn.empty(vim.fn.glob(wiki_dir)) > 0 then
  vim.fn.system { 'mkdir', '-p', wiki_dir }
end

local general_wiki = wiki_dir .. '/general'
local template_dir = general_wiki .. '/templates'

-- this is only useful for lervag/wiki.vim
vim.g.wiki_root = wiki_dir
vim.g.vimwiki_markdown_link_ext = 1
vim.g.vimwiki_stripsym = ' '
vim.g.vimwiki_global_ext = 0

-- this is for vimwiki/vimwiki
local general = {
  path = general_wiki,
  syntax = 'markdown',
  ext = 'md',

  auto_diary_index = 1,
  auto_generate_links = 1,
  auto_toc = 1,
  diary_caption_level = -1,
  diary_frequency = 'weekly',
  list_margin = 0,
  links_space_char = '_',
}

local health = {
  path = wiki_dir .. '/health',
  ext = 'wiki',

  auto_diary_index = 1,
  auto_generate_links = 1,
  auto_toc = 1,
  diary_caption_level = -1,
  diary_frequency = 'weekly',
  syntax = 'default',
  links_space_char = '_',
}

vim.g.nv_search_paths = { general.path, health.path }

-- List of vimwiki's
vim.g.vimwiki_list = { general, health }

-- disable vimwiki's default link keymappings so we can customize <CR>
vim.g.vimwiki_key_mappings = {
  links = 0,
}

local wiki_group = vim.api.nvim_create_augroup('vimwiki', { clear = true })

-- Auto format lines on wiki files
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = wiki_dir .. "/**.md",
--   command = [[g/./ normal gqq``]],
--   group = wiki_group,
-- })

--[[ vim.api.nvim_create_autocmd("BufEnter", {
  pattern = wiki_dir .. "/**.md",
  callback = function()
    vim.opt_local.syntax = 'markdown'
  end,
  group = wiki_group,
}) ]]

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = wiki_dir .. "/**.wiki",
  callback = function()
    vim.opt_local.syntax = 'vimwiki'
  end,
  group = wiki_group,
})

-- no conceal on cursor
vim.api.nvim_create_autocmd("FileType", {
  pattern = "vimwiki",
  callback = function()
    vim.opt_local.concealcursor = 'c'
    vim.treesitter.language.register("markdown", "vimwiki")
  end,
  group = wiki_group,
})

local function zettelid()
  return os.date('%Y%m%d%H%M')
end

local function filepicker_select(folder, callback, picker)
  assert(folder)
  assert(callback)
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
      name = "Vimwiki Search",
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

local function insert_link(folder)
  assert(folder)

  local target_buf = vim.api.nvim_get_current_buf()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor_pos[1], cursor_pos[2]

  filepicker_select(folder, function(selection)
    if selection then
      local choice = selection.filename or selection[1]
      local title = vim.fn.fnamemodify(choice, ":t:r")
      local rel_folder = vim.fs.relpath(wiki_dir .. '/general', folder)
      local link = string.format("[%s](/%s/%s)", title, rel_folder, choice)
      vim.api.nvim_buf_set_text(target_buf, row - 1, col, row - 1, col, { link })
    end
  end)
end

local function insert_image(folder)
  assert(folder)

  local target_buf = vim.api.nvim_get_current_buf()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor_pos[1], cursor_pos[2]

  local function callback(selection)
    if selection then
      local choice = selection.filename or selection[1]
      local title = vim.fn.fnamemodify(choice, ":t:r")
      local rel_folder = vim.fs.relpath(wiki_dir .. '/general', folder)
      local link = string.format("![%s](/%s/%s)", title, rel_folder, choice)
      vim.api.nvim_buf_set_text(target_buf, row - 1, col, row - 1, col, { link })
    end
  end

  filepicker_select(folder, callback, 'files')
end

local function create_autocommand(callback)
  assert(callback)

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'vimwiki',
    callback = callback,
  })
end

local function create_user_command(name, command, opts)
  assert(name)
  assert(command)
  opts = opts or {}

  create_autocommand(function()
    vim.api.nvim_buf_create_user_command(0, name, command, opts)
  end)
end

-- custom stuff
create_user_command("VimwikiInsertClipping", function()
  insert_link(wiki_dir .. '/general/clippings')
end)
create_autocommand(function()
  vim.keymap.set('n', '<localleader>wic', function()
    insert_link(wiki_dir .. '/general/clippings')
  end, { desc = "Insert vimwiki clipping note link" })
end)

create_user_command("VimwikiInsertLink", function()
  insert_link(wiki_dir .. '/general')
end)
create_autocommand(function()
  vim.keymap.set('n', '<localleader>wil', function()
    insert_link(wiki_dir .. '/general')
  end, { desc = "Insert vimwiki note link" })
end)

create_user_command("VimwikiInsertImage", function()
  insert_image(wiki_dir .. '/general/assets')
end)
create_autocommand(function()
  vim.keymap.set('n', '<localleader>wii', function()
    insert_image(wiki_dir .. '/general/assets')
  end, { desc = "Insert a link to an (image) asset" })
end)

-- Create a user command :VimwikiCreateFromTemplate [template_name]
create_user_command('VimwikiCreateFromTemplate', function(opts)
  local template = opts.args ~= '' and opts.args or 'zettel'

  local id = zettelid()
  local filename = id .. '.md'
  local full_file_path = string.format('%s/%s', general_wiki, filename)

  -- Ensure the file does not already exist
  if vim.fn.filereadable(full_file_path) == 1 then
    vim.notify("Note already exists", vim.log.levels.WARN)
    return
  end

  -- Construct and check template path
  local full_template_path = string.format('%s/%s.md', template_dir, template)
  if vim.fn.filereadable(full_template_path) == 0 then
    vim.notify('Template not found at ' .. full_template_path, vim.log.levels.ERROR)
    return
  end

  -- Read template content and write to the new file
  local template_lines = vim.fn.readfile(full_template_path)
  vim.fn.writefile(template_lines, full_file_path)

  -- write the link into current buffer
  local s = string.format("[%s](/%s)", id, filename)
  vim.api.nvim_put({ s }, "", true, true)

  -- Open the new file and notify
  vim.cmd('edit ' .. full_file_path)
end, {
  nargs = '?',
  complete = function(arg_lead, cmd_line, cursor_pos)
    local files = vim.fn.glob(template_dir .. '*.md', false, true)
    local templates = {}
    for _, file in ipairs(files) do
      local name = vim.fn.fnamemodify(file, ':t:r')
      if vim.startswith(name, arg_lead) then
        table.insert(templates, name)
      end
    end
    return templates
  end,
})

-- mappings
create_autocommand(function()
  vim.keymap.set('n', '<CR>', function()
    local line = vim.api.nvim_get_current_line()
    -- Check if there is a Vimwiki link [[...]] or a Markdown link [...]() on the line
    if line:match('%[%[.-%]%]') or line:match('%[.-%]%(.-%)') then
      vim.cmd("VimwikiFollowLink")
    else
      -- If it's not a link, perform the normal Enter action
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
    end
  end, { buffer = true, desc = "Smart Enter: Follow link or normal Enter" })
end)

create_autocommand(function()
  vim.keymap.set('n', '<Backspace>', function()
    vim.cmd [[ VimwikiGoBackLink ]]
  end)
end)

create_autocommand(function()
  vim.keymap.set('n', '<Tab>', function()
    vim.cmd [[ VimwikiNextLink ]]
  end)
end)

create_autocommand(function()
  vim.keymap.set('n', '<S-Tab>', function()
    vim.cmd [[ VimwikiPrevLink ]]
  end)
end)

-- snippets

local ls = require 'luasnip'
local s, i, t, c, f, d = ls.s, ls.insert_node, ls.text_node, ls.choice_node, ls.function_node, ls.dynamic_node
local sn = ls.snippet_node
local rep = require("luasnip.extras").rep
local fmt = require 'luasnip.extras.fmt'.fmt
local fmta = require("luasnip.extras.fmt").fmta


ls.add_snippets("vimwiki", {
  s("zetteldate", fmt([[ {} ]], { f(zettelid, {}) })),

  s("create", fmt('[{}]({}.md)', { i(1), f(zettelid, {}) })),

  s("zettel", fmta(
    [[
        ---
        id: <>
        aliases: [<>]
        tags: [<>]
        created: <>
        ---

        # <>

        ## References
        - <>
        ]],
    {
      -- 1. Generates Zettel ID (YYYYMMDDHHMM)
      f(zettelid, {}),
      -- 2. Placeholders for aliases and tags
      i(1, "aliases"),
      i(2, "tags"),
      -- 3. Generates readable date format (YYYY-MM-DD HH:MM)
      f(function() return os.date("%Y-%m-%d %H:%M") end, {}),
      -- 4. Placeholder for Title
      i(3, "Title"),
      -- 5. Placeholder for reference link
      i(4, ""),
    }
  )),
})
