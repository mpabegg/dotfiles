return {
  's1n7ax/nvim-window-picker',
  name = 'window-picker',
  event = 'VeryLazy',
  version = '2.*',
  config = function()
    require('window-picker').setup()
    -- Window-picker keymaps
    vim.keymap.set('n', '<leader>ww', function()
      require('window-picker').pick_window({ hint = 'floating-big-letter' })
    end, { desc = 'Pick Window' })
  end,
}
