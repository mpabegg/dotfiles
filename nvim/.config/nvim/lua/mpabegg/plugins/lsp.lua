local add = MiniDeps.add

local function on_attach(client, bufnr)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Goto Declaration' })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'LSP Definitions' })
  vim.keymap.set('n', 'gr', function()
    require('trouble').open('lsp_references')
  end, { buffer = bufnr, desc = 'Goto References' })
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP Hover' })

  vim.keymap.set('n', 'K', function()
    local ufo_ok, ufo = pcall(require, 'ufo')
    if ufo_ok then
      local winid = ufo.peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    else
      vim.lsp.buf.hover()
    end
  end, { buffer = bufnr, desc = 'LSP Hover' })

  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Help' })

  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set('n', 'g=', function()
      vim.lsp.buf.format({ timeout_ms = 30000 })
    end, { buffer = bufnr, desc = 'Format Buffer' })
  end

  vim.keymap.set('n', '<leader>lF', function()
    vim.lsp.buf.format({ async = true })
  end, { buffer = bufnr, desc = 'Format Buffer (async)' })

  if client.server_capabilities.renameProvider then
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename' })
  end
  if client.server_capabilities.codeActionProvider then
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
  end
end

add({ source = 'hrsh7th/cmp-nvim-lsp' })

add({ source = 'williamboman/mason.nvim', hooks = { post_checkout = function() require('mason').setup({}) end } })

add({
  source = 'williamboman/mason-lspconfig.nvim',
  depends = { 'williamboman/mason.nvim' },
})

add({
  source = 'neovim/nvim-lspconfig',
  depends = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'hrsh7th/cmp-nvim-lsp' },
  hooks = {
    post_checkout = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
      if ok then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      local opts = {
        defaults = {
          on_attach = on_attach,
          capabilities = capabilities,
        },
        servers = {},
      }

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(opts.servers or {}),
        handlers = {
          function(server_name)
            local config = vim.tbl_deep_extend('force', opts.defaults, opts.servers[server_name] or {})
            require('lspconfig')[server_name].setup(config)
          end,
        },
      })
    end,
  },
})

add({ source = 'j-hui/fidget.nvim', checkout = 'legacy', hooks = { post_checkout = function() require('fidget').setup({}) end } })
