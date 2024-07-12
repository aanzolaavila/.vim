local globalAutoFmtEnabled = false;

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  -- ...
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  local cmd = function(cmd, func, opts)
    if opts and opts.desc then
      opts.desc = 'LSP: ' .. opts.desc
    end

    vim.api.nvim_buf_create_user_command(bufnr, cmd, func, opts)
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction')

  local telescope = require('telescope.builtin')
  local themes = require('telescope.themes')
  local with_cfg = require('util.telescope').with_cfg

  local short_display = {
    shorten = {
      len = 1,
      exclude = { -2, -1 },
    }
  }

  nmap('gd', with_cfg(telescope.lsp_definitions, themes.get_ivy, { initial_mode = 'normal' }),
    '[g]oto [d]efinition')

  nmap('gD', vim.lsp.buf.type_definition, 'Type [D]efinition')

  nmap('gr',
    with_cfg(telescope.lsp_references, themes.get_ivy,
      {
        initial_mode = 'normal',
        path_display = { smart = true },
        trim_text = true,
      }),
    '[g]oto [r]eferences')


  nmap('gi', with_cfg(telescope.lsp_implementations, themes.get_ivy, {
      initial_mode = 'normal',
      path_display = short_display,
      trim_text = true,
      jump_type = 'none',
    }),
    '[g]oto [i]mplementation')
  nmap('gI', with_cfg(telescope.lsp_implementations, themes.get_ivy, {
      initial_mode = 'normal',
      path_display = short_display,
      trim_text = true,
      jump_type = 'vsplit',
    }),
    '[g]oto [I]mplementation, in vsplit if only one choice')

  nmap('<leader>D', function() vim.lsp.buf.declaration({ initial_mode = 'normal' }) end, '[g]oto [D]eclaration')
  nmap('<leader>ds', with_cfg(telescope.lsp_document_symbols, nil, { initial_mode = 'normal' }), '[d]ocument [s]ymbols')
  nmap('<leader>ws', with_cfg(telescope.lsp_dynamic_workspace_symbols, themes.get_ivy, {
      initial_mode = 'normal',
      path_display = { smart = true },
      trim_text = true
    }),
    '[w]orkspace [s]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  cmd("LspWorkspaceAddFolder", vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  cmd("LspWorkspaceRemoveFolder", vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')
  cmd("LspWorkspaceListFolders", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = 'List workspace folders' })

  -- Create a command `:Format` local to the LSP buffer

  local shouldAutoformatByDefault = function()
    return os.getenv("AT_WORK") ~= "true"
  end

  local supportsFormatting = function()
    return client.supports_method('textDocument/formatting')
  end

  cmd('Format', function(_)
    if supportsFormatting() then
      vim.lsp.buf.format()
    else
      print("LSP server does not support formatting")
    end
  end, { desc = 'Format current buffer with LSP' })

  local localAutoFmtEnabled = true;
  cmd('ToggleBufAutoFormat', function(_)
    localAutoFmtEnabled = not localAutoFmtEnabled
  end, { desc = 'Format current buffer with LSP on save' })

  cmd('ToggleGlobalAutoFormat', function(_)
    globalAutoFmtEnabled = not globalAutoFmtEnabled
  end, { desc = 'Format current buffer with LSP on save globally' })

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      if not supportsFormatting() or not shouldAutoformatByDefault() then
        return
      end

      if globalAutoFmtEnabled and localAutoFmtEnabled then
        vim.lsp.buf.format {
          async = false,
        }
        -- workaround for hidden diagnostics after file format
        vim.diagnostic.enable(bufnr)
      end
    end,
  })
end

return {
  {
    'neovim/nvim-lspconfig', -- LSP Configuration & Plugins
    version = '^0.1.7',
    event = { 'BufWritePre', 'BufNewFile', 'BufReadPost' },
    dependencies = {
      { 'williamboman/mason.nvim',           version = '^1.10.0', config = true },               -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason-lspconfig.nvim', version = '^1.29.0', config = false, opts = true }, -- will configure here
      { 'hrsh7th/cmp-nvim-lsp',              config = false },

      -- Useful status updates for LSP
      {
        'j-hui/fidget.nvim',
        branch = 'legacy',
      },

      -- Additional lua configuration, makes nvim stuff amazing
      { 'folke/neodev.nvim' },
    },

    opts = {
      servers = {
        -- This allow LSP for Neovim lua configurations
        -- Reference: https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/
        lua_ls = {
          settings = {
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
              completion = {
                callSnippet = 'Replace',
              }
            },
          },
        },
      }
    },

    config = function(_, opts)
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      local ensure_installed = require('util.lazy').opts('mason-lspconfig.nvim').ensure_installed or {}
      vim.list_extend(ensure_installed, vim.tbl_keys(opts.servers))
      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup {
        ensure_installed = ensure_installed,
        handlers = { setup }
      }

      -- register autocmd for lsp on_attach
      require('util.lsp').on_attach(on_attach)

      -- User command to list Lsp server capabilities
      -- Taken from https://www.reddit.com/r/neovim/comments/13r7yzw/list_server_capabilities/
      vim.api.nvim_create_user_command("LspCapabilities", function()
        local clients = vim.lsp.get_clients()

        for _, client in pairs(clients) do
          if client.name == "null-ls" then
            return
          end

          ---@diagnostic disable-next-line: undefined-field
          local capAsList = {}
          ---@diagnostic disable-next-line: undefined-field
          for key, value in pairs(client.server_capabilities) do
            if value and key:find("Provider") then
              local capability = key:gsub("Provider$", "")
              table.insert(capAsList, "  - " .. capability)
            end
          end

          table.sort(capAsList) -- sorts alphabetically
          ---@diagnostic disable-next-line: undefined-field
          local msg = "# " .. client.name .. "\n" .. table.concat(capAsList, "\n")
          print(msg)
        end
      end, {})
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'VeryLazy',
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      ensure_installed = {},
      automatic_installation = true,
    },
  }
}
