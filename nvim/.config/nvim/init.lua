-- Install package manager
--    https://github.com/nvim-mini/mini.nvim
--    `:help mini-deps.txt` for more info
local minideps_path = vim.fn.stdpath('data') .. '/site/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(minideps_path) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/nvim-mini/mini.nvim.git',
    '--depth=1',
    minideps_path,
  })
end
vim.opt.rtp:prepend(minideps_path)

require('mpabegg.options')
require('mpabegg.autocmd')
require('mpabegg.diagnostics')

-- Setup mini.deps
require('mini.deps').setup({})

-- Load plugins
require('mpabegg.plugins')
require('mpabegg.languages')
