local M = {}

M.on_attach = function(client, bufnr)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Goto Declaration' })
  vim.keymap.set('n', 'gd', function()
    require('trouble').open('lsp_definitions')
  end, { buffer = bufnr, desc = 'Goto Definition' })
  vim.keymap.set('n', 'gr', function()
    require('trouble').open('lsp_references')
  end, { buffer = bufnr, desc = 'Goto References' })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP Hover' })
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Help' })
  vim.keymap.set('n', '<leader>lF', function()
    vim.lsp.buf.format({ async = false })
  end, { buffer = bufnr, desc = 'Format Buffer' })

  if client.server_capabilities.renameProvider then
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename' })
  end
  if client.server_capabilities.codeActionProvider then
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
  end
  if client.server_capabilities.inlayHintProvider then
    vim.keymap.set('n', '<leader>lh', function()
      require('mpabegg.state').toggle('inlay_hint')
      vim.lsp.inlay_hint(bufnr, require('mpabegg.state').get('inlay_hint'))
    end, { buffer = bufnr, desc = 'Toggle Inlay Hint' })
  end
end

M.setup_mason = function(lsp)
  require('mason').setup({})
  require('mason-lspconfig').setup({
    ensure_installed = { 'tsserver', 'lua_ls', 'solargraph', 'clangd', 'elixirls' },
    handlers = {
      lsp.default_setup,
      lua_ls = function()
        require('lspconfig').lua_ls.setup(vim.tbl_deep_extend('force', lsp.nvim_lua_ls(), {
          settings = {
            Lua = {
              hint = {
                enable = true,
                arrayIndex = 'Enable',
                setType = true,
              },
            },
          },
        }))
      end,
      solargraph = require('lspconfig').solargraph.setup({
        root_dir = require('lspconfig.util').root_pattern('.git'),
        debounce_text_changes = 150,
      }),
    },
  })
end

return M
