require('mpabegg.autocmd').format_on_save({ '*.lua' })

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { { 'folke/neodev.nvim' } },
    opts = function(_, opts)
      require('neodev').setup()
      return vim.tbl_deep_extend('force', opts or {}, {
        servers = {
          lua_ls = {
            on_attach = function(client, bufnr)
              opts.defaults.on_attach(client, bufnr)
              if client.name == 'lua_ls' then
                client.server_capabilities.documentFormattingProvider = false
              end
            end,
            settings = {
              Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                diagnostics = { globals = { 'vim' } },
                hint = {
                  enable = true,
                  arrayIndex = 'Enable',
                  setType = true,
                },
              },
            },
          },
        },
      })
    end,
  },
  {
    'jay-babu/mason-null-ls.nvim',
    opts = function(_, opts)
      return vim.tbl_deep_extend('force', opts, {
        ensure_installed = vim.list_extend(opts.ensure_installed or {}, { 'stylua' }),
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'lua', 'luadoc' })
    end,
  },
}
