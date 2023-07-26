return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'dev-v3',
    config = function()
      require("neodev").setup({ })

      local lsp = require('lsp-zero').preset({})
      lsp.on_attach(function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, bufnr)
        end
        lsp.default_keymaps({buffer = bufnr})
      end)

      lsp.extend_cmp()
      require('mason').setup({})
      require('mason-lspconfig').setup({
        -- Replace the language servers listed here
        -- with the ones you want to install
        ensure_installed = {'tsserver', 'rust_analyzer', "lua_ls"},
        handlers = {
          lsp.default_setup,
          lua_ls = function()
            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
          end,
        },
      })

      local icons = require("mpabegg.icons")
      local diagnosticSigns =  {
        { name = "DiagnosticSignError", text = icons.diagnostics.error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.information },
      }

      for _, sign in ipairs(diagnosticSigns) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
      end

      vim.diagnostic.config({
        virtual_text = false,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        }})
      end
    },
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    { "folke/neodev.nvim", opts = {} },

    -- LSP Support
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        {'hrsh7th/cmp-nvim-lsp'},
      },
    },
    {
      'hrsh7th/nvim-cmp',
      config = true,
      dependencies = {
        {'L3MON4D3/LuaSnip'},
      }
    },
    {
      "SmiteshP/nvim-navic",
      dependencies = { "neovim/nvim-lspconfig" }
    },
    { "j-hui/fidget.nvim", tag = "legacy", config = true },
  }
