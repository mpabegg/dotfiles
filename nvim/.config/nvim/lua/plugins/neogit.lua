return {  'NeogitOrg/neogit',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
      },
      config = function()
        local neogit = require('neogit')
        neogit.setup({
          graph_style = 'unicode',
          integrations = { snacks = true },
        })
        vim.keymap.set('n', '<leader>gg', neogit.open, { desc = 'NeoGit' })
      end}
