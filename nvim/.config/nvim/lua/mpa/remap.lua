local n = require("mpa.keymap").nnoremap
local v = require("mpa.keymap").vnoremap
local i = require("mpa.keymap").inoremap

local function l(rhs, lhs)
  n("<leader>" .. rhs, lhs)
end


vim.g.mapleader = " "

-- Better defaults
v("<", "<gv")
v(">", ">gv")
i("jk", "<ESC>")
i("kj", "<ESC>")


-- File
l("fs", "<cmd>w<Cr>")
l("fm", "<cmd>Ex<Cr>")

-- Window
l("wv", "<cmd>vsplit<Cr>")
l("ws", "<cmd>split<Cr>")
l("wd", "<cmd>quit<Cr>")
l("wj", "<C-w>j")
l("wh", "<C-w>h")
l("wl", "<C-w>l")
l("wk", "<C-w>k")
