local M = {}

M.on_attach = function(client, bufnr)
  require('mpabegg.plugins.lsp.ruby').on_attach(client, bufnr)

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Goto Declaration' })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Goto Definition' })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Goto References' })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP Hover' })
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Help' })
  vim.keymap.set('n', 'g=', vim.lsp.buf.format, { buffer = bufnr, desc = 'Format Buffer' })
  vim.keymap.set('n', '<leader>lF', function()
    vim.lsp.buf.format({ async = true })
  end, { buffer = bufnr, desc = 'Format Buffer' })

  if client.server_capabilities.renameProvider then
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename' })
  end
  if client.server_capabilities.codeActionProvider then
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
  end
end

M.setup_mason = function(lsp)
  require('mason').setup({})
  require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = { 'tsserver', 'lua_ls', 'solargraph', 'clangd' },
    handlers = {
      lsp.default_setup,
      lua_ls = function()
        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
      end,
      solargraph = require('mpabegg.plugins.lsp.ruby').solargraph,
    },
  })
end

M.setup_null_ls = function()
  require('mason-null-ls').setup({
    ensure_installed = {
      'stylua',
    },
    automatic_installation = false,
    handlers = {},
  })
  require('mpabegg.plugins.lsp.ruby').null_ls()
end

return M
