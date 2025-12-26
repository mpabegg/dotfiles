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
    opts = MakeOpts({ ensure_installed = { 'lua', 'luadoc' } }),
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
    opts = MakeOpts({
      sources = {
        default = { 'lazydev' },
        providers = {
          lazydev = {
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
    }),
  },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = MakeOpts({ ensure_installed = { 'stylua', 'lua_ls' } }),
  },
  {
    'neovim/nvim-lspconfig',
    opts = MakeOpts({
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
    }),
  },
}
