
local icons = require('mpa.icons')
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
      [vim.diagnostic.severity.WARN]  = icons.diagnostics.warn,
      [vim.diagnostic.severity.HINT]  = icons.diagnostics.hint,
      [vim.diagnostic.severity.INFO]  = icons.diagnostics.info,
    }
  },
  virtual_text = false,
  update_in_insert = false,
  underline = false,
  severity_sort = true,
  float = {
    focusable = true,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
