vim.cmd('TSBufEnable highlight')

vim.keymap.set('n', '<LocalLeader>be', function()
  vim.cmd([[:w]])
  vim.cmd([[!elixir %]])
end, { buffer = 0, desc = 'Eval Buffer' })
