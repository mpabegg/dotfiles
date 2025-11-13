vim.opt.backup = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.colorcolumn = '120'
vim.opt.completeopt = { 'menu', 'menuone' }
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = false
vim.opt.scrolloff = 8
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undodir = vim.fn.stdpath('data') .. '/undodir'
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.autochdir = false

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

