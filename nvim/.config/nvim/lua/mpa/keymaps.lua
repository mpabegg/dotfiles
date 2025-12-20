-- ============================================================================
-- Keymaps
-- ============================================================================

-- local map = require('clutter').map
local map = vim.keymap.set

-- Disable command-line window
vim.keymap.set('n', 'q:', '<Nop>')

vim.keymap.set('n', ' ', '<Nop>')

-- General keymaps
map({ 'n', 'v' }, '<localleader>x', '<CMD>so<CR>', { desc = 'Run Selection' })
map('n', '<leader>fm', '<cmd>Lexplore<CR>', { desc = 'Toggle/Focus Netrw' })

-- Window resizing
map('n', '<C-S-Up>', '<CMD>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-S-Down>', '<CMD>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-S-Left>', '<CMD>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-S-Right>', '<CMD>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Search
map('n', '<Esc>', '<CMD>noh<CR>', { desc = 'Clear search highlighting', silent = true })
map('n', 'n', 'nzzzv', { desc = 'Next search result' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result' })

map('n', '<leader>c', '<cmd>copen<cr>', { desc = 'Toggle Quickfix Window' })
map('n', '[c', '<CMD>cprev<CR>', { desc = 'Previous Quickfix' })
map('n', ']c', '<CMD>cnext<CR>', { desc = 'Next Quickfix' })

-- Visual mode
map({ 'v', 'x' }, '<', '<gv', { desc = 'Indent left' })
map({ 'v', 'x' }, '>', '>gv', { desc = 'Indent right' })
map('v', 'J', "<CMD>m '>+1<CR>gv=gv", { desc = 'Move text down' })
map('v', 'K', "<CMD>m '<-2<CR>gv=gv", { desc = 'Move text up' })

-- Scrolling
map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' })

map('n', '<leader>w', '<CMD>w<CR>', { desc = 'Save file' })
map('n', '<leader>fs', '<CMD>w<CR>', { desc = 'Save file' })
map('n', '<S-l>', '<CMD>bnext<CR>', { desc = 'Next buffer' })
map('n', '<S-h>', '<CMD>bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<leader>wv', '<CMD>vsplit<CR>', { desc = 'Split window vertically' })
map('n', '<leader>ws', '<CMD>split<CR>', { desc = 'Split window horizontally' })
map('n', '<leader>wd', '<CMD>close<CR>', { desc = 'Close current split' })
map('n', '<leader>wc', '<CMD>close<CR>', { desc = 'Close current split' })
