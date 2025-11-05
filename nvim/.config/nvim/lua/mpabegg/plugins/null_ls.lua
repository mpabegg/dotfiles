local add = MiniDeps.add

add({
  source = 'jay-babu/mason-null-ls.nvim',
  depends = { 'williamboman/mason.nvim', 'nvimtools/none-ls.nvim' },
  hooks = {
    post_checkout = function()
      local opts = {
        ensure_installed = {},
        sources = {},
      }
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
  },
})
