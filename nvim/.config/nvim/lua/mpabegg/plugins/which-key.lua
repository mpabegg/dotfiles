return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    -- Remap for dealing with word wrap
    vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

    -- Move text on visual mode
    vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
    vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

    vim.keymap.set('n', 'J', 'mzJ`z')
    vim.keymap.set('n', '<C-d>', '<C-d>zz')
    vim.keymap.set('n', '<C-u>', '<C-u>zz')
    vim.keymap.set('n', 'n', 'nzzzv')
    vim.keymap.set('n', 'N', 'Nzzzv')
    vim.keymap.set('n', 'Q', '<nop>')
    vim.keymap.set('n', '>', '>gv')
    vim.keymap.set('n', '<', '<gv')
    vim.keymap.set('i', '<C-c>', '<Esc>')
    vim.keymap.set('i', 'kj', '<Esc>')
    vim.keymap.set('i', 'jk', '<Esc>')

    -- General keymaps using vim.keymap.set
    -- File operations
    vim.keymap.set('n', '<leader>fs', '<cmd>w<cr>', { desc = 'Save File' })
    vim.keymap.set('n', '<leader>fS', '<cmd>wa<cr>', { desc = 'Save All Files' })

    -- Window operations
    vim.keymap.set('n', '<leader>ws', '<C-w>s', { desc = 'Split Below' })
    vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split to the Right' })
    vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Focus Left' })
    vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = 'Focus Right' })
    vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = 'Focus Down' })
    vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = 'Focus Up' })
    vim.keymap.set('n', '<leader>wd', '<C-w>c', { desc = 'Delete Window' })

    -- Delete into void register
    vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete into void register' })

    -- Reload which-key
    vim.keymap.set('n', '<leader>rk', '<cmd>ReloadPlugin which-key.nvim<cr>', { desc = 'Reloads which-key' })
  end,
  config = function()
    require('which-key').setup({})
  end,
}
