-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('mpabegg.options')
require('mpabegg.autocmd')
require('mpabegg.remap')
require('lazy').setup({
  spec = 'mpabegg.plugins',
  install = {
    colorscheme = { 'catppuccin frappe' },
  },
  change_detection = {
    notify = false,
  },
})
