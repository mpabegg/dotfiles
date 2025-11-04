return {
  'jay-babu/mason-null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
    'nvimtools/none-ls.nvim',
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
      update_in_insert = false,
      sources = opts.sources or {},
    })
  end,
}
