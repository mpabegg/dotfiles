return {
      'folke/snacks.nvim',
      config = function()
        require'snacks'.setup({
          picker = {
            actions = {
              sidekick_send = require('sidekick.cli.picker.snacks').send,
            },
            win = {
              input = {
                keys = {
                  ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
                },
              },
            },
          },
          explorer = {
            enabled = true,
            replace_netrw = false,
            trash = true,
          },
          bigfile = { enabled = true },
          indent = { enabled = true },
        })

        Snacks.toggle.zoom():map('<leader>z')

        vim.keymap.set('n','<leader><leader>', Snacks.picker.smart, { desc = 'Smart Find' })
        vim.keymap.set('n','<localleader><localleader>', Snacks.picker.buffers ,  { desc = 'Find Buffer' })
        vim.keymap.set('n', '<leader>uC', Snacks.picker.colorschemes, { desc = 'Colorschemes' })
        vim.keymap.set('n', '<leader>hh', Snacks.picker.help, { desc = 'Help Pages' })
        vim.keymap.set('n', '<leader>hk', Snacks.picker.keymaps, { desc = 'Keymaps' })
        vim.keymap.set('n', '<leader>e', Snacks.explorer.open, { desc = 'File Explorer' })
        vim.keymap.set('n', '<leader>/', Snacks.picker.grep, { desc = 'Search in Project' })
        vim.keymap.set('n', '<leader>*', Snacks.picker.grep_word, { desc = 'Search word' })
        vim.keymap.set('n', '<leader>bd', Snacks.bufdelete.delete, { desc = 'Delete Buffer' })
        -- vim.keymap.set('n', '<leader>ff', Snacks.picker.files, { desc = 'Find Files' })
        -- vim.keymap.set('n', '<leader>fr', function() Snacks.explorer.reveal({ buf = 0 }) end, { desc = 'File Explorer' })

        -- map('n', '<leader>:', Snacks.picker.command_history, { desc = 'Command History' })
        -- map('n', '<leader>n', Snacks.picker.notifications, { desc = 'Notification History' })
        -- map('n', '<leader>.', Snacks.scratch.open, { desc = 'Toggle Scratch Buffer' })
        -- map('n', '<leader>S', Snacks.scratch.select, { desc = 'Select Scratch Buffer' })
        -- map('n', '<leader>n', Snacks.notifier.show_history, { desc = 'Notification History' })
        --
        -- map( 'n', '<leader>fc', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end, { desc = 'Find Config File' })
        -- map('n', '<leader>fg', Snacks.picker.git_files, { desc = 'Find Git Files' })
        -- map('n', '<leader>fr', Snacks.picker.recent, { desc = 'Recent' })
        -- map('n', '<leader>sb', Snacks.picker.lines, { desc = 'Buffer Lines' })
        -- map('n', '<leader>sB', Snacks.picker.grep_buffers, { desc = 'Grep Open Buffers' })
        -- map('n', '<leader>sr', Snacks.picker.registers, { desc = 'Registers' })
        -- map('n', '<leader>s/', Snacks.picker.search_history, { desc = 'Search History' })
        -- map('n', '<leader>sa', Snacks.picker.autocmds, { desc = 'Autocmds' })
        -- map('n', '<leader>sc', Snacks.picker.command_history, { desc = 'Command History' })
        -- map('n', '<leader>sC', Snacks.picker.commands, { desc = 'Commands' })
        -- map('n', '<leader>sd', Snacks.picker.diagnostics, { desc = 'Diagnostics' })
        -- map('n', '<leader>sD', Snacks.picker.diagnostics_buffer, { desc = 'Buffer Diagnostics' })
        -- map('n', '<leader>sH', Snacks.picker.highlights, { desc = 'Highlights' })
        -- map('n', '<leader>si', Snacks.picker.icons, { desc = 'Icons' })
        -- map('n', '<leader>sj', Snacks.picker.jumps, { desc = 'Jumps' })
        -- map('n', '<leader>sl', Snacks.picker.loclist, { desc = 'Location List' })
        -- map('n', '<leader>sm', Snacks.picker.marks, { desc = 'Marks' })
        -- map('n', '<leader>sM', Snacks.picker.man, { desc = 'Man Pages' })
        -- map('n', '<leader>sq', Snacks.picker.qflist, { desc = 'Quickfix List' })
        -- map('n', '<leader>sR', Snacks.picker.resume, { desc = 'Resume' })
        -- map('n', '<leader>su', Snacks.picker.undo, { desc = 'Undo History' })
        -- map('n', '<leader>uC', Snacks.picker.colorschemes, { desc = 'Colorschemes' })
        -- map('n', '<leader>un', Snacks.notifier.hide, { desc = 'Dismiss All Notifications' })
        --
        -- -- Git
        -- map('n', '<leader>gb', Snacks.picker.git_branches, { desc = 'Git Branches' })
        -- map('n', '<leader>gl', Snacks.picker.git_log, { desc = 'Git Log' })
        -- map('n', '<leader>gL', Snacks.picker.git_log_line, { desc = 'Git Log Line' })
        -- map('n', '<leader>gs', Snacks.picker.git_status, { desc = 'Git Status' })
        -- map('n', '<leader>gS', Snacks.picker.git_stash, { desc = 'Git Stash' })
        -- map('n', '<leader>gd', Snacks.picker.git_diff, { desc = 'Git Diff (Hunks)' })
        -- map('n', '<leader>gf', Snacks.picker.git_log_file, { desc = 'Git Log File' })
      end,
    }
