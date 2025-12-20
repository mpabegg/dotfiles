return {
  {
    'e-ink-colorscheme/e-ink.nvim',
    lazy = false,
    enabled = false,
    config = function()
      require('e-ink').setup()
      vim.cmd.colorscheme('e-ink')
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    name = 'colorizer',
    config = true,
  },
  {
    'sainnhe/everforest',
    lazy = false,
    -- enabled = false,
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
    enabled = false,
    'folke/tokyonight.nvim',
    lazy = false,
    config = function() vim.cmd.colorscheme([[tokyonight]]) end,
  },
}
