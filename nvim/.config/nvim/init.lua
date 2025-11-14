require'mpa.opts'
require'mpa.folds'
require'mpa.colors'
require'mpa.git'
require'mpa.lang'

vim.pack.add({ { src = 'https://github.com/alexghergh/nvim-tmux-navigation' } })
require('nvim-tmux-navigation').setup({
  disable_when_zoomed = true,
  keybindings = {
    left = '<C-h>',
    down = '<C-j>',
    up = '<C-k>',
    right = '<C-l>',
  },
})

vim.pack.add{{src="https://github.com/folke/snacks.nvim"}}
vim.pack.add{{src="https://github.com/folke/ts-comments.nvim"}}
vim.pack.add{{src="https://github.com/folke/lazydev.nvim"}}
require'ts-comments'.setup()
require'snacks'.setup({
  indent = { enable = true },
  scope = { enable = true },
  explorer = { enable = true },
})

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

vim.pack.add{
  { src = "https://github.com/folke/flash.nvim" },
}
require'flash'.setup{}
vim.keymap.set({ "n", "x", "o" }, 's', require'flash'.jump )
vim.keymap.set({ "n", "x", "o" }, 'S', require'flash'.treesitter )
vim.keymap.set('o', 'r', require'flash'.remote )
vim.keymap.set({ 'o', 'x' }, 'R', require'flash'.treesitter_search )
vim.keymap.set( 'c' , '<c-s>', require'flash'.toggle )
-- keys = {
--   { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
--   -- Simulate nvim-treesitter incremental selection
--   { "<c-space>", mode = { "n", "o", "x" },
--   function()
--     require("flash").treesitter({
--       actions = {
--         ["<c-space>"] = "next",
--         ["<BS>"] = "prev"
--       }
--     }) 
--   end, desc = "Treesitter Incremental Selection" },
-- },
--   },

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
  {src = 'https://github.com/nvim-mini/mini.nvim'}
}, { confirm = false })
require'mini.splitjoin'.setup{}

Snacks.keymap.set("n", "<leader>ff", Snacks.picker.smart)
Snacks.keymap.set("n", "<leader>ft", Snacks.picker.explorer)
Snacks.keymap.set("n", "<leader>bb", Snacks.picker.buffers)
Snacks.keymap.set("n", "<leader>hh", Snacks.picker.help)

