local utils = require('mpa.utils')
utils.auto_format('*.lua')

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('lua-update-colocolum', { clear = true }),
  pattern = 'lua',
  callback = function() vim.o.colorcolumn = '100' end,
})

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      return utils.deep_extend(opts, {
        ensure_installed = { 'lua', 'luadoc' },
      })
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'saghen/blink.cmp',
    opts = function(_, opts)
      return utils.deep_extend(opts, {
        sources = {
          default = { 'lazydev' },
          providers = {
            lazydev = {
              module = 'lazydev.integrations.blink',
              score_offset = 100,
            },
          },
        },
      })
    end,
  },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = function(_, opts)
      return utils.deep_extend(opts, { ensure_installed = { 'stylua', 'lua_ls' } })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      return utils.deep_extend(opts, {
        servers = {
          lua_ls = {
            settings = {
              Lua = {
                completion = {
                  callSnippet = 'Replace',
                },
                diagnostics = {
                  disable = { 'missing-fields' },
                  globals = { 'vim' },
                },
              },
            },
          },
        },
      })
    end,
  },
}
