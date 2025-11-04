return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
  },
  init = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      extensions = {
        file_browser = {
          initial_mode = 'normal',
          theme = 'ivy',
          prview = false,
        },
      },
      defaults = {
        mappings = {
          ['i'] = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-x>'] = actions.toggle_selection,
            ['<C-q>'] = actions.send_to_qflist,
          },
          ['n'] = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-q>'] = actions.send_to_qflist,
            ['x'] = actions.toggle_selection,
            ['d'] = actions.delete_buffer,
          },
        },
      },
    })

    pcall(telescope.load_extension('fzf'))
  end,
  config = function()
    -- Telescope keymaps
    vim.keymap.set('n', '<leader>ff', function()
      require('telescope.builtin').find_files({ hidden = false })
    end, { desc = 'Find File' })
    vim.keymap.set('n', '<leader>bb', require('telescope.builtin').buffers, { desc = 'List Buffers' })
    vim.keymap.set('n', '<leader>hk', '<cmd>Telescope keymaps<cr>', { desc = 'Keymaps' })
    vim.keymap.set('n', '<leader>hh', '<cmd>Telescope help_tags<cr>', { desc = 'Help' })
    vim.keymap.set('n', '<leader>sq', require('telescope.builtin').quickfix, { desc = 'Quickfix' })
    vim.keymap.set('n', '<leader>sl', require('telescope.builtin').resume, { desc = 'Resume' })
    vim.keymap.set('n', '<leader>/', '<cmd>Telescope live_grep<cr>', { desc = 'Search Project' })
    vim.keymap.set('n', '<leader>*', '<cmd>Telescope grep_string<cr>', { desc = 'Find Word' })
  end,
}
