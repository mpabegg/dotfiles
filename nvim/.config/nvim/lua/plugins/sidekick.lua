return {
      'folke/sidekick.nvim',
      config = function()
        require'sidekick'.setup({
          cli = {
            mux = {
              backend = 'tmux',
              enabled = true,
            },
          },
        })

        vim.keymap.set('n', '<leader>aa',  require'sidekick.cli'.toggle ,{ desc = 'Sidekick Toggle CLI' })
        vim.keymap.set({ 'n', 'x' }, '<leader>ap',require('sidekick.cli').prompt ,{  desc = 'Sidekick Select Prompt'} )
        vim.keymap.set({ 'n', 'x' }, '<leader>at', function() require('sidekick.cli').send({ msg = '{this}' }) end,  { desc = 'Send This' })
        vim.keymap.set('n', '<leader>af', function() require('sidekick.cli').send({ msg = '{file}' }) end, { desc = 'Send File' })
      end,
    }
