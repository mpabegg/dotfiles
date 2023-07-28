local M = {}

M.on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    local navic_ok, navic = pcall(require, 'nvim-navic')
    if navic_ok then
      require('nvim-navic').attach(client, bufnr)
    end
  end

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Goto Declaration' })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Goto Definition' })
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { buffer = bufnr, desc = 'References' })
  vim.keymap.set('n', 'go', require('telescope.builtin').lsp_document_symbols, { buffer = bufnr, desc = 'Symbols' })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP Hover' })
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Help' })

  if client.server_capabilities.renameProvider then
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename' })
  end
  if client.server_capabilities.codeActionProvider then
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
  end

  -- Hopefully this will work together with linter.nvim or formatters.nvim,
  -- whichever one creates the Format command as well :)
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

return M
