local utils = require('mpa.utils')

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = MakeOpts({
      ensure_installed = {
        'typescript',
        'typescriptreact',
        'javascript',
        'javacriptreact',
      },
    }),
  },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = MakeOpts({ ensure_installed = { 'vtsls' } }),
  },
  {
    'neovim/nvim-lspconfig',
    opts = MakeOpts({
      servers = {
        vtsls = {},
      },
    }),
  },
}
