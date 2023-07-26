return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.1',
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
          },
          ['n'] = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
            ['x'] = actions.toggle_selection,
          },
        },
      },
    })

    pcall(telescope.load_extension('fzf'))
  end,
}
