local general = vim.api.nvim_create_augroup('General', { clear = true })

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = general,
  pattern = '*',
  callback = function() vim.hl.on_yank({ higroup = 'IncSearch', timeout = 200 }) end,
  desc = 'Highlight yanked text',
})

-- Restore cursor position when opening a file
vim.api.nvim_create_autocmd('BufReadPost', {
  group = general,
  pattern = '*',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = 'Restore cursor position',
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd('VimResized', {
  group = general,
  pattern = '*',
  callback = function() vim.cmd('tabdo wincmd =') end,
  desc = 'Auto-resize splits',
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = general,
  pattern = { 'help', 'qf', 'lspinfo', 'man', 'checkhealth', 'netrw' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
  desc = 'Close with q',
})

vim.api.nvim_create_autocmd('FileType', {
  group = general,
  pattern = { 'netrw' },
  callback = function(event)
    vim.keymap.set('n', '<C-h>', '<C-w>h', { buffer = event.buf, silent = true })
    vim.keymap.set('n', '<C-l>', '<C-w>l', { buffer = event.buf, silent = true })
  end,
  desc = 'Use <C-h> and <C-l> as <C-w>h and <C-w>l in Netrw',
})

-- Disable auto-comment on newline globally
vim.api.nvim_create_autocmd('FileType', {
  callback = function() vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' }) end,
  desc = 'Disable auto-comment on newline',
})
