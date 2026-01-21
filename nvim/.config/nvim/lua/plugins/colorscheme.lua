return {
  {
    'norcalli/nvim-colorizer.lua',
    name = 'colorizer',
    config = true,
  },
  {
    'e-ink-colorscheme/e-ink.nvim',
    enabled = false,
    config = function()
      require('e-ink').setup()
      vim.opt.background = 'dark'
      vim.cmd.colorscheme('e-ink')
    end,
  },
  {
    'sainnhe/everforest',
    lazy = false,
    enabled = false,
    config = function()
      vim.g.everforest_background = 'soft'
      vim.cmd.colorscheme([[everforest]])
    end,
  },
  {
    'catppuccin/nvim',
    enabled = false,
    lazy = false,
    config = function() vim.cmd.colorscheme([[catppuccin-frappe]]) end,
  },
  {
    'folke/tokyonight.nvim',
    -- enabled = false,
    lazy = false,
    config = function() vim.cmd.colorscheme([[tokyonight]]) end,
  },
}
