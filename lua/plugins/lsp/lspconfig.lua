-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.

local globalAutoFmtEnabled = true;

ON_ATTACH = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  local telescope = require('telescope.builtin')

  nmap('gd', telescope.lsp_definitions, '[G]oto [d]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')
  nmap('gr', telescope.lsp_references, '[g]oto [r]eferences')
  nmap('gI', telescope.lsp_implementations, '[g]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', telescope.lsp_document_symbols, '[d]ocument [s]ymbols')
  nmap('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer

  local supportsFormatting = function()
    return client.supports_method('textDocument/formatting')
  end

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if supportsFormatting then
      vim.lsp.buf.format()
    end
  end, { desc = 'Format current buffer with LSP' })

  local localAutoFmtEnabled = true;
  vim.api.nvim_buf_create_user_command(bufnr, 'ToggleBufAutoFormat', function(_)
    localAutoFmtEnabled = not localAutoFmtEnabled
  end, { desc = 'Format current buffer with LSP on save' })

  vim.api.nvim_buf_create_user_command(bufnr, 'ToggleGlobalAutoFormat', function(_)
    globalAutoFmtEnabled = not globalAutoFmtEnabled
  end, { desc = 'Format current buffer with LSP on save globally' })

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      if globalAutoFmtEnabled and localAutoFmtEnabled then
        vim.lsp.buf.format()
      end
    end,
  })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- This allow LSP for Neovim lua configurations
  -- Reference: https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/
  lua_ls = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false
      },
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}

return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      {
        'j-hui/fidget.nvim',
        branch = 'legacy',
      },

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
    config = function()
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Setup mason so it can manage external tooling
      require('mason').setup()

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = ON_ATTACH,
            settings = servers[server_name],
          }
        end,
      }
    end,
  },
}
