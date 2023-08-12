local function on_attach(client, bufnr)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Goto Declaration' })
  vim.keymap.set('n', 'gd', function()
    require('trouble').open('lsp_definitions')
  end, { buffer = bufnr, desc = 'Goto Definition' })
  vim.keymap.set('n', 'gr', function()
    require('trouble').open('lsp_references')
  end, { buffer = bufnr, desc = 'Goto References' })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP Hover' })
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Help' })

  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set('n', 'g=', vim.lsp.buf.format, { buffer = bufnr, desc = 'Format Buffer' })
  end

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

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

return {
  {
    'neovim/nvim-lspconfig',
    opts = function()
      return {
        defaults = {
          on_attach = on_attach,
          capabilities = capabilities,
        },
      }
    end,
    config = function(_, opts)
      require('mason').setup({})
      require('mason-lspconfig').setup({ ensure_installed = vim.tbl_keys(opts.servers) })
      require('mason-lspconfig').setup_handlers({
        function(server_name)
          local config = vim.tbl_deep_extend('force', opts.defaults, opts.servers[server_name] or {})
          require('lspconfig')[server_name].setup(config)
        end,
      })
    end,
  },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig', dependencies = { 'hrsh7th/cmp-nvim-lsp' } },
  { 'j-hui/fidget.nvim', tag = 'legacy', config = true },
}
