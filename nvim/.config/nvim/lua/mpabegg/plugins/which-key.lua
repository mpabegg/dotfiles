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
    vim.keymap.set('n', 'q:', '<nop>')
    vim.keymap.set('n', '?:', '<nop>')

    vim.keymap.set('n', 'g=', vim.cmd.FormatWrite, { desc = 'Format Buffer' })

    local wk = require('which-key')
    wk.register({
      b = {
        name = '+buffers',
        b = { require('telescope.builtin').buffers, 'List Buffers' },
        d = { require('mini.bufremove').delete, 'Delete Buffer' },
      },
      f = {
        name = '+file',
        f = { '<cmd>Telescope find_files<cr>', 'Find File' },
        r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
        t = { '<cmd>Neotree toggle<CR>', 'Neotree' },
        s = { '<cmd>w<cr>', 'Save File' },
        S = { '<cmd>wa<cr>', 'Save File' },
      },
      l = {
        name = '+lsp',
      },
      w = {
        name = '+window',
        s = { '<C-w>s', 'Split Below' },
        v = { '<C-w>v', 'Split to the Right' },
        h = { '<C-w>h', 'Focus Left' },
        l = { '<C-w>l', 'Focus Right' },
        j = { '<C-w>j', 'Focus Down' },
        k = { '<C-w>k', 'Focus Up' },
        d = { '<C-w>c', 'Delete' },
      },
      h = {
        name = '+help',
        k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
        h = { '<cmd>Telescope help_tags<cr>', 'Help' },
      },
      g = {
        name = '+git',
        h = { name = '+hunk' },
        s = { require('neogit').open, 'Git Status' },
      },
      x = {
        name = '+trouble',
        x = { '<cmd>TroubleToggle<cr>', 'Toggle Trouble' },
        w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Workspace Diagnostics' },
        d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'Document Diagnostics' },
        q = { '<cmd>TroubleToggle quickfix<cr>', 'Quickfix' },
        l = { '<cmd>TroubleToggle loclist<cr>', 'Loclist' },
      },
      ['/'] = { '<cmd>Telescope live_grep<cr>', 'Search Project' },
      ['*'] = { '<cmd>Telescope grep_string<cr>', 'Find Word' },
      ['U'] = { vim.cmd.UndotreeToggle, 'Undo Tree' },
      ['rk'] = { '<cmd>ReloadPlugin which-key.nvim<cr>', 'Reloads which-key' },
      ['0'] = { vim.cmd.Neotree, 'Focus on Neotree' },
    }, { prefix = '<leader>' })

    wk.register({
      d = { [["_d]], 'Delete into void register' },
    }, { prefix = '<leader>', mode = { 'n', 'v' } })
  end,
}
