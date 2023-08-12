return {
  'jay-babu/mason-null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
    'jose-elias-alvarez/null-ls.nvim',
  },
  opts = function()
    return {}
  end,
  config = function(_, opts)
    require('mason').setup({})
    require('mason-null-ls').setup({
      ensure_installed = opts.ensure_installed,
      automatic_installation = false,
      handlers = {},
    })
    require('null-ls').setup({
      sources = { },
    })
  end,
}
