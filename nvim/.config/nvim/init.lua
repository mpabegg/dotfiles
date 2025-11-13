local config_file = vim.fn.expand("$MYVIMRC")
vim.keymap.set("n", "<leader>hr", function()
  vim.cmd("source " .. config_file)
  print("Reloaded " .. config_file)
end, { desc = "Reload Neovim config" })

vim.g.mapleader = " "
vim.g.maplocalleader = ","

require('mpa.opts')
require('mpa.colors')
require('mpa.tmux')

vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.nvim" },
}, { confirm = false })

require("mini.pick").setup()

vim.keymap.set("n", "<leader>hh", MiniPick.builtin.help)
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>")
vim.keymap.set("n", "<leader>ws", ":split<CR>")
vim.keymap.set("n", "<leader>wd", ":quit<CR>")
