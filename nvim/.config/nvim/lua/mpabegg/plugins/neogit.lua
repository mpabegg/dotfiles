local icons = require('mpabegg.icons')

return {
  'NeogitOrg/neogit',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {
    signs = {
      -- { CLOSED, OPENED }
      section = { icons.ui.carret_right, icons.ui.carret_down },
      item = { icons.ui.carret_right, icons.ui.carret_down },
    },
  },
}
