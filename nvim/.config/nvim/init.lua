require'mpa.opts'
require'mpa.folds'
require'mpa.colors'
require'mpa.git'

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

vim.pack.add { 
  { src = "https://github.com/stevearc/oil.nvim" },
}
require'oil'.setup {}

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

local config_file = vim.fn.expand("$MYVIMRC")
vim.keymap.set("n", "<leader>x", function()
  vim.cmd("source " .. config_file)
  print("Reloaded " .. config_file)
end, { desc = "Reload Neovim config" })
 
vim.pack.add({ 
	{ src = 'https://github.com/nvim-mini/mini.nvim' } }, 
{ confirm = false })

require'mini.pick'.setup {}

vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files)
vim.keymap.set("n", "<leader>hh", MiniPick.builtin.help)
