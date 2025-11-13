require'mpa.opts'
require'mpa.folds'
require'mpa.colors'
require'mpa.git'

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
