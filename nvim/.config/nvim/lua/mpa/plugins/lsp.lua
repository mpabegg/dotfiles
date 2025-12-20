Add({
  source = 'neovim/nvim-lspconfig',
  depends = {
    'williamboman/mason.nvim',
    'SmiteshP/nvim-navic',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'folke/lazydev.nvim',
  },
})

Later(function()
  require('lazydev').setup({ library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } })
  require('mason').setup()
  require('mason-tool-installer').setup({})

  local capabilities = require('blink.cmp').get_lsp_capabilities({}, true)
  local ufo_ok, _ = pcall(require, 'ufo')
  if ufo_ok then
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
  end

  vim.lsp.config('*', { capabilities = capabilities })
  vim.lsp.enable({ 'lua_ls', 'ruby_lsp', 'vtsls', 'elixirls' })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if not client then
        return
      end

      local buffer = event.buf

      if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, buffer)
      end

      local map = function(mode, lhs, rhs, opts)
        vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend('keep', opts or {}, { buffer = buffer }))
      end

      map('n', 'K', vim.lsp.buf.hover, { desc = 'LSP hover' })
      map('n', 'gl', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
      map('n', '[d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = 'Previous diagnostic' })
      map('n', ']d', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = 'Next diagnostic' })

      map('n', 'gd', vim.lsp.buf.definition)
      map('n', 'grr', vim.lsp.buf.references)
      map('n', 'gra', vim.lsp.buf.code_action)
      map('n', 'gri', vim.lsp.buf.implementation)
      map('n', 'grn', vim.lsp.buf.rename)
      map('n', 'grt', vim.lsp.buf.type_definition)
      map('n', 'gO', vim.lsp.buf.document_symbol)
      map('n', '<localleader>f', vim.lsp.buf.format, { desc = 'LSP Format' })
      map('i', '<C-s>', vim.lsp.buf.signature_help)
    end,
  })
end)
