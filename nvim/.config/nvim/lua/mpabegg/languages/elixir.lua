require('mpabegg.autocmd').format_on_save({ '*.ex', '*.eex' })

return {
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      return vim.tbl_deep_extend('force', opts or {}, {
        servers = {
          elixirls = {},
        },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'elixir',
        'heex',
        'eex',
      })
    end,
  },
}
