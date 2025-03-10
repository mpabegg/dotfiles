local icons = require('mpabegg.icons')
local diagnosticSigns = {
  { name = 'DiagnosticSignError', text = icons.diagnostics.error },
  { name = 'DiagnosticSignWarn', text = icons.diagnostics.warn },
  { name = 'DiagnosticSignHint', text = icons.diagnostics.hint },
  { name = 'DiagnosticSignInfo', text = icons.diagnostics.info },
}

for _, sign in ipairs(diagnosticSigns) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

vim.diagnostic.config({
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
