local add = MiniDeps.add

add({
  source = 's1n7ax/nvim-window-picker',
  checkout = '2.*',
  hooks = {
    post_checkout = function()
      require('window-picker').setup()
      -- Window-picker keymaps
      vim.keymap.set('n', '<leader>ww', function()
        require('window-picker').pick_window({ hint = 'floating-big-letter' })
      end, { desc = 'Pick Window' })
    end,
  },
})
