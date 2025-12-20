return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    { 'j-hui/fidget.nvim', opts = {} },
    { 'mason-org/mason-lspconfig.nvim', opts = {} },
    'saghen/blink.cmp',
    'SmiteshP/nvim-navic',
    -- TODO: Decide between none-ls vs conform...
  },
  opts = {},
  config = function(_, opts)
    require('languages.diagnostics')

    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local ufo_ok, _ = pcall(require, 'ufo')
    if ufo_ok then
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
    end

    local servers = opts.servers or {}
    for server, server_opts in pairs(servers) do
      server_opts.capabilities =
        vim.tbl_deep_extend('force', capabilities, server_opts.capabilities or {})
      server_opts.capabilities = require('blink.cmp').get_lsp_capabilities(server_opts.capabilities)
      vim.lsp.config(server, server_opts)
      vim.lsp.enable(server)
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
          return
        end

        local buffer = event.buf

        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, buffer)
        end

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP hover' })
        vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
        vim.keymap.set(
          'n',
          '[d',
          function() vim.diagnostic.jump({ count = 1, float = true }) end,
          { desc = 'Previous diagnostic' }
        )
        vim.keymap.set(
          'n',
          ']d',
          function() vim.diagnostic.jump({ count = -1, float = true }) end,
          { desc = 'Next diagnostic' }
        )

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
        vim.keymap.set('n', 'grr', vim.lsp.buf.references)
        vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
        vim.keymap.set('n', 'gri', vim.lsp.buf.implementation)
        vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
        vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition)
        vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol)
        vim.keymap.set('n', '<localleader>f', vim.lsp.buf.format, { desc = 'LSP Format' })
        vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)
      end,
    })
  end,
}
