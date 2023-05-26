local mpabegg = vim.api.nvim_create_augroup('mpabegg', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = mpabegg,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 100,
    })
  end,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = mpabegg,
  pattern = '*',
  callback = function()
    require('mini.trailspace').trim()
    require('mini.trailspace').trim_last_lines()
  end,
})
