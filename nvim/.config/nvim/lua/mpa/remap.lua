local nnoremap = require("mpa.keymap").nnoremap

local function leader(rhs, lhs)
  nnoremap("<leader>" .. rhs, lhs)
end

vim.g.mapleader = " "

leader("fs", "<cmd>w<Cr>")
leader("fm", "<cmd>Ex<Cr>")

leader("wV", "C-wv")
