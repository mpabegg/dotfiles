return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = function()
    local icons = require('mpabegg.icons')
    return {
      options = {
        theme = 'auto',
        globalstatus = true,
        disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
      },
      sections = {
        lualine_a = {
          {
            'filetype',
            icon_only = true,
            separator = '',
            colored = false,
            padding = {
              left = 1,
              right = 1,
            },
          },
        },
        lualine_b = {
          { 'filename', path = 4, symbols = { modified = icons.file.modified, readonly = '', unnamed = '' } },
        },
        lualine_c = {
          {
            'diagnostics',
            symbols = {
              error = icons.diagnostics.error,
              warn = icons.diagnostics.warn,
              info = icons.diagnostics.info,
              hint = icons.diagnostics.hint,
            },
          },
        },
        lualine_x = {
          { 'diff', symbols = icons.git },
        },
        lualine_y = {
          { 'branch', color = { gui = 'italic' } },
        },
        lualine_z = {
          { 'fileformat', padding = { left = 1, right = 2 } },
        },
      },
      extensions = { 'neo-tree', 'lazy' },
    }
  end,
}
