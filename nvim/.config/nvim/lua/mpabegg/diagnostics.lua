local icons = require('mpabegg.icons')

vim.diagnostic.config({
  signs = {
    Error = { text = icons.diagnostics.error, texthl = 'DiagnosticSignError', numhl = 'DiagnosticSignError' },
    Warn = { text = icons.diagnostics.warn, texthl = 'DiagnosticSignWarn', numhl = 'DiagnosticSignWarn' },
    Hint = { text = icons.diagnostics.hint, texthl = 'DiagnosticSignHint', numhl = 'DiagnosticSignHint' },
    Info = { text = icons.diagnostics.info, texthl = 'DiagnosticSignInfo', numhl = 'DiagnosticSignInfo' },
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
