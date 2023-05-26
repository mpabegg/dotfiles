return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    init = function()
      require('catppuccin').setup({
        flavour = 'frappe',
        custom_highlights = function(colors)
          return {
            ['Error'] = { bg = colors.red, fg = colors.base },
          }
        end,
      })
      vim.cmd.colorscheme('catppuccin')
    end,
  },

  {
    'alexghergh/nvim-tmux-navigation',
    config = {
      disable_when_zoomed = true,
      keybindings = {
        left = '<C-h>',
        down = '<C-j>',
        up = '<C-k>',
        right = '<C-l>',
      },
    },
  },

  'mbbill/undotree',
  'tpope/vim-sleuth',
  'tpope/vim-surround',

  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({
        min_count_to_highlight = 2,
      })
    end,
  },

  { 'echasnovski/mini.bufremove', config = true },
  { 'echasnovski/mini.comment', config = true },
  { 'echasnovski/mini.indentscope', config = true },
  { 'echasnovski/mini.trailspace', config = true },
}
