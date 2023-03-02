-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-h>", vim.cmd.NvimTmuxNavigateLeft)
vim.keymap.set("n", "<C-j>", vim.cmd.NvimTmuxNavigateDown)
vim.keymap.set("n", "<C-k>", vim.cmd.NvimTmuxNavigateUp)
vim.keymap.set("n", "<C-l>", vim.cmd.NvimTmuxNavigateRight)
vim.keymap.set("n", "<C-\\>", vim.cmd.NvimTmuxNavigateLastActive)
vim.keymap.set("n", "<C-Space>", vim.cmd.NvimTmuxNavigateNext)

vim.keymap.set("n", "<leader>ws", "<C-W>s", { desc = "Split window below" })
vim.keymap.set("n", "<leader>wv", "<C-W>v", { desc = "Split window right" })

vim.keymap.set("n", "<leader>fs", vim.cmd.write, { desc = "Save File" })

vim.keymap.set("n", "<leader>*", function()
  require("telescope.builtin").grep_string()
end, { desc = "Find Word" })

--     wk.setup(opts)
--     wk.register({
--       mode = { "n", "v" },
--       ["g"] = { name = "+goto" },
--       ["gz"] = { name = "+surround" },
--       ["]"] = { name = "+next" },
--       ["["] = { name = "+prev" },
-- -- which-key
-- },
