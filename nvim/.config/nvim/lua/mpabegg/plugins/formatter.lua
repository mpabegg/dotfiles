return {
  'mhartington/formatter.nvim',
  config = function()
    local util = require('formatter.util')
    require('formatter').setup({
      log_level = vim.log.levels.DEBUG,
      logging = true,
      filetype = {
        lua = { require('formatter.filetypes.lua').stylua },
        elixir = { require('formatter.filetypes.elixir').mixformat },
        ruby = {
          function()
            return {
              exe = 'bundle',
              args = {
                'exec',
                'rubocop',
                '--auto-correct-all',
                '--stdin',
                util.escape_path(util.get_current_buffer_file_name()),
                '--format',
                'files',
                '--stderr',
              },
              stdin = true,
            }
          end,
        },
      },
    })
  end,
}
