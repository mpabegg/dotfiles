return {
  {
    'alexghergh/nvim-tmux-navigation',
    opts = {
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
  { 'tpope/vim-surround', dependencies = { 'tpope/vim-repeat' } },

  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({})
    end,
  },

  { 'echasnovski/mini.bufremove', config = true },
  { 'echasnovski/mini.comment', config = true },
  { 'echasnovski/mini.indentscope', config = true },
  { 'echasnovski/mini.trailspace', config = true },
  { 'echasnovski/mini.pairs', config = true },
}
