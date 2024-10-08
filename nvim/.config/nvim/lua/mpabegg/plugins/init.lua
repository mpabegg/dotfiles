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

  { 'NStefan002/visual-surround.nvim', config = true },
  { 'kylechui/nvim-surround', event = 'VeryLazy', config = true },
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
  { 'echasnovski/mini.splitjoin', config = true },
  {
    'echasnovski/mini.files',
    config = function()
      vim.keymap.set('n', '<leader>fm', require('mini.files').open)
    end,
  },

  {
    'folke/persistence.nvim',
    event = 'VeryLazy',
    config = true,
    keys = {
      { '<leader>qq', [[:lua require("persistence").save(); vim.cmd.quitall()<CR>]], desc = 'Quit', silent = true },
      { '<leader>qr', [[:lua require("persistence").load({ last = true })<CR>]], desc = 'Restore', silent = true },
      { '<leader>ql', [[:lua require("persistence").load()<CR>]], desc = 'Load', silent = true },
    },
  },
}
