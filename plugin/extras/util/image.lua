local image = require('image')

image.setup({
  tmux_show_only_in_active_window = true,
  window_overlap_clear_enabled = true,
  window_overlap_clear_ft_ingore = {
    'cmp_menu', 'cmp_docs', 'notify',
  },
  integrations = {
    markdown = {
      resolve_image_path = function(document_path, image_path, fallback)
        local vimwiki_dir = vim.fn.expand '~' .. '/wiki'

        -- Reference: https://github.com/3rd/image.nvim/issues/190#issuecomment-2378156235
        local working_dir = vim.fn.getcwd()
        -- Format image path for vimwiki notes
        if (working_dir:find(vimwiki_dir)) then
          return working_dir .. "/" .. image_path
        end
        -- Fallback to the default behavior
        return fallback(document_path, image_path)
      end
    }
  }
})
