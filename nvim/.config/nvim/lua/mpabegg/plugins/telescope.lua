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
}
