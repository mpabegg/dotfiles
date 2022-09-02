local function bind(op, outer_opts)
  outer_opts = outer_opts or { noremap = true }
  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("force", outer_opts, opts or {})
    vim.keymap.set(op, lhs, rhs, opts)
  end
end

local n = bind "n"
local v = bind "v"
local i = bind "i"
local x = bind "x"

vim.g.mapleader = " "

-- Better defaults
n("<M-S-v>", "<C-v>") -- Workaround for WSL
x("<", "<gv")
x(">", ">gv")
i("jk", "<ESC>")
i("kj", "<ESC>")
