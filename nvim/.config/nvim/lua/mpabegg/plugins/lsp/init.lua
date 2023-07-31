return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'dev-v3',
    config = function()
      require('neodev').setup({})

      local lsp = require('lsp-zero').preset({})
      require('mpabegg.plugins.lsp.config').on_attach(lsp)
      require('mpabegg.plugins.lsp.config').setup_completion(lsp)
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
  {
    'hrsh7th/nvim-cmp',
    config = true,
    dependencies = { 'L3MON4D3/LuaSnip' },
  },
  {
    'SmiteshP/nvim-navic',
    dependencies = { 'neovim/nvim-lspconfig' },
  },
  { 'j-hui/fidget.nvim', tag = 'legacy', config = true },
}
