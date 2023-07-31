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
        -- lualine_a = { { "mode", fmt = function(str) return str:sub(1,1) end } },
        lualine_a = { { 'branch', color = { gui = 'italic' } } },
        lualine_b = {
          { 'diff', symbols = icons.git },
          { 'filename', path = 1, symbols = { modified = icons.file.modified, readonly = '', unnamed = '' } },
        },
        lualine_c = {
          {
            function()
              return require('nvim-navic').get_location()
            end,
            cond = function()
              return package.loaded['nvim-navic'] and require('nvim-navic').is_available()
            end,
          },
        },
        lualine_x = {
          {
            'diagnostics',
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          {
            function()
              local shiftwidth = vim.api.nvim_buf_get_option(0, 'shiftwidth')
              return icons.ui.tab .. ' ' .. shiftwidth
            end,
            padding = 1,
          },
        },
        lualine_y = {
          { 'filetype', icon_only = false, separator = '', padding = { left = 1, right = 2 } },
        },
        lualine_z = {
          { 'fileformat', padding = { left = 1, right = 2 } },
        },
      },
      extensions = { 'neo-tree', 'lazy' },
    }
  end,
}
