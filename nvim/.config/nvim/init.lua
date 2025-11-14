require'mpa.opts'
require'mpa.folds'
require'mpa.colors'
require'mpa.git'
require'mpa.lang'
require'mpa.tmux'
require'mpa.diagnostics'

vim.pack.add{{src="https://github.com/folke/snacks.nvim"}}
vim.pack.add{{src="https://github.com/folke/ts-comments.nvim"}}
vim.pack.add{{src="https://github.com/folke/lazydev.nvim"}}
require'ts-comments'.setup()
require'snacks'.setup({
  indent = { enable = true },
  explorer = { enable = true },
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = mpabegg,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 100,
    })
  end,
})

vim.pack.add{
  { src = "https://github.com/folke/flash.nvim" },
}
require'flash'.setup{}
vim.keymap.set({ "n", "x", "o" }, 's', require'flash'.jump )
vim.keymap.set({ "n", "x", "o" }, 'S', require'flash'.treesitter )
vim.keymap.set('o', 'r', require'flash'.remote )
vim.keymap.set({ 'o', 'x' }, 'R', require'flash'.treesitter_search )
vim.keymap.set( 'c' , '<c-s>', require'flash'.toggle )

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

