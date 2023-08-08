return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'dev-v3',
    config = function()
      require('neodev').setup({})

      local lsp = require('lsp-zero').preset({float_border = 'none'})
      lsp.on_attach(require('mpabegg.plugins.lsp.config').on_attach)
      require('mpabegg.plugins.lsp.config').setup_mason(lsp)
      require('mpabegg.plugins.lsp.config').setup_null_ls()
    end,
  },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = false,
  },

  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'folke/neodev.nvim', opts = {} },

  -- LSP Support
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
  },
  { 'j-hui/fidget.nvim', tag = 'legacy', config = true },
}
