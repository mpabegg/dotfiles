local add = MiniDeps.add

add({
  source = 'NeogitOrg/neogit',
  depends = { 'nvim-lua/plenary.nvim' },
  hooks = {
    post_checkout = function()
      local icons = require('mpabegg.icons')
      require('neogit').setup({
        signs = {
          -- { CLOSED, OPENED }
          section = { icons.ui.carret_right, icons.ui.carret_down },
          item = { icons.ui.carret_right, icons.ui.carret_down },
        },
      })
      -- Neogit keymaps
      vim.keymap.set('n', '<leader>gs', require('neogit').open, { desc = 'Git Status' })
    end,
  },
})
