vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('gleam', { clear = true }),
  pattern = '*.gleam',
  callback = function()
    vim.cmd([[TSEnable highlight]])
    vim.cmd([[TSEnable indent]])
  end,
})

return {
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      return vim.tbl_deep_extend('force', opts or {}, {
        servers = {
          gleam = {},
        },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'gleam' })
    end,
  },
}
