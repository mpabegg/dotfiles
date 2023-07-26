return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300

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
        t = { vim.cmd.Neotree, 'Neotree' },
        s = { '<cmd>w<cr>', 'Save File' },
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
        name = "+help",
        k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
        h = { '<cmd>Telescope help_tags<cr>', 'Help' },
      },
      ['/'] = { '<cmd>Telescope live_grep<cr>', 'Search Project' },
      ['*'] = { '<cmd>Telescope grep_string<cr>', 'Find Word' },
      ['U'] = { vim.cmd.UndotreeToggle, 'Undo Tree' },
      ['rk'] = { '<cmd>ReloadPlugin which-key.nvim<cr>', 'Reloads which-key' },
    }, { prefix = '<leader>' })

    wk.register({
      d = { [["_d]], "Delete into void register" }
    }, { prefix = '<leader>', mode = { 'n', 'v' }})
  end,
}
