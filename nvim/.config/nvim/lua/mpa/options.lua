local icons = require('mpa.icons')

-- Leader keys: Space for global leader, comma for local leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Line numbers: Show absolute line numbers (not relative)
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 2

-- Indentation: Use 2 spaces for tabs and indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

-- Search: Case-insensitive by default, but case-sensitive when uppercase is used
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

-- Colors: Enable 24-bit RGB colors and use dark background
vim.o.termguicolors = true
vim.o.background = 'dark'

-- UI: Show sign column, highlight current line, and mark column 120
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.colorcolumn = '120'
vim.o.laststatus = 3
vim.opt.winborder = 'rounded'

-- Text wrapping and list mode
vim.o.wrap = false
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Folding: Managed by nvim-ufo
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = 'manual'

-- Scrolling: Keep 10 lines above/below cursor when scrolling
vim.o.scrolloff = 10

-- Splitting: Open new splits to the right and below
vim.o.splitright = true
vim.o.splitbelow = true

-- Command display: Hide mode indicator, show partial commands
vim.o.showmode = false
vim.o.showcmd = true
vim.o.cmdheight = 1

-- Completion: Show completion menu with single match, don't auto-select
vim.o.completeopt = 'menu,menuone,noselect'

-- Undo: Enable persistent undo across sessions
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('data') .. '/undodir'

-- Backup files: Disable backup, writebackup, and swap files
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- Auto-read: Automatically reload files changed outside of Neovim
vim.o.autoread = true

-- Netrw (file explorer): Open in current window, hide banner, set window size
vim.g.netrw_browse_split = 0 -- vertically splits window
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Mouse: Enable mouse support in all modes
vim.o.mouse = 'a'

-- Clipboard: Use system clipboard for yank/delete/put operations
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Update timing: Faster updates for better responsiveness
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Conceal: Hide * markup for bold and italic, but not markers with substitutions
vim.opt.conceallevel = 2

-- Confirm: Confirm to save changes before exiting modified buffer
vim.opt.confirm = true

-- Directory: Don't automatically change working directory
vim.o.autochdir = false

vim.opt.statuscolumn = [[%!v:lua.Snacks.statuscolumn()]]
