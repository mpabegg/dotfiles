local utils = require('mpa.utils')
utils.auto_format('*.gleam')
return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = MakeOpts({ ensure_installed = { 'gleam' } }),
  },
  {
    'neovim/nvim-lspconfig',
    opts = MakeOpts({
      servers = { gleam = {} },
    }),
  },
}
