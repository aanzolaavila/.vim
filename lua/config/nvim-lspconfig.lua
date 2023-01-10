local M = {}

function M.setup()
  -- Setup mason so it can manage external tooling
  require('mason').setup()

  -- Ensure the servers above are installed
  local mason_lspconfig = require 'mason-lspconfig'

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --
  --  Add any additional override configuration in the following tables. They will be passed to
  --  the `settings` field of the server config. You must look up that documentation yourself.
  local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- tsserver = {},

    -- This allow LSP for Neovim lua configurations
    -- Reference: https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/
    sumneko_lua = {
      Lua = {
        workspace = {
          checkThirdParty = true,
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

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  mason_lspconfig.setup_handlers {
    function(server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = ON_ATTACH,
        settings = servers[server_name],
      }
    end,
  }

  -- Setup neovim lua configuration
  require('neodev').setup()

  -- Turn on lsp status information
  require('fidget').setup()
end

return M