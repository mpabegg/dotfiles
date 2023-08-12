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

-- Don't auto commenting new lines
vim.api.nvim_create_autocmd('BufEnter', {
  group = mpabegg,
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o',
})

local M = {}

function M.format_on_save(filetypes)
  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = mpabegg,
    pattern = filetypes,
    callback = function()
      vim.lsp.buf.format()
    end,
  })
end

return M
