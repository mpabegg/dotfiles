local setup_competion = function(lsp)
  lsp.extend_cmp()
  local cmp = require('cmp')
  local cmp_action = require('lsp-zero').cmp_action()
  local select_opts = { behavior = cmp.SelectBehavior.Select }
  cmp.setup({
    mapping = {
      ['<Tab>'] = cmp_action.luasnip_supertab(),
      ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<C-k>'] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item(select_opts)
        else
          cmp.complete()
        end
      end),
      ['<C-j>'] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_next_item(select_opts)
        else
          cmp.complete()
        end
      end),
    },
  })
end

return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'dev-v3',
    config = function()
      require('neodev').setup({})

      local lsp = require('lsp-zero').preset({})
      lsp.on_attach(function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, bufnr)
        end
        lsp.default_keymaps()

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Goto Declaration' })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Goto Definition' })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Goto References' })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP Hover' })
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Help' })
        vim.keymap.set('n', 'g=', vim.lsp.buf.format, { buffer = bufnr, desc = 'Format Buffer' })
      end)

      setup_competion(lsp)

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
          solargraph = function()
            require('lspconfig').solargraph.setup({
              debounce_text_changes = 150,
            })
          end,
        },
      })

      require('mason-null-ls').setup({
        ensure_installed = {
          'solargraph',
          'stylua',
          'clang-format',
        },
        automatic_installation = false,
        handlers = {},
      })

      local null_ls = require('null-ls')
      local rubocop_format = null_ls.builtins.formatting.rubocop
      local rubocop_diagnostic = null_ls.builtins.diagnostics.rubocop
      local has_gemfile = function(utils)
        return utils.root_has_file({ 'Gemfile', '*.gemspec' })
      end
      local does_not_have_gemfile = function(utils)
        return not has_gemfile(utils)
      end

      null_ls.setup({
        sources = {
          rubocop_format.with({
            condition = has_gemfile,
            command = 'bundle',
            args = vim.list_extend({ 'exec', 'rubocop', '-a' }, rubocop_format._opts.args),
            timeout = -1,
          }),
          rubocop_format.with({ condition = does_not_have_gemfile }),
          rubocop_diagnostic.with({
            condition = has_gemfile,
            command = 'bundle',
            args = vim.list_extend({ 'exec', 'rubocop', '-a' }, rubocop_diagnostic._opts.args),
            timeout = -1,
          }),
          rubocop_diagnostic.with({ condition = does_not_have_gemfile }),
        },
      })
    end,
  },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = false,
  },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'folke/neodev.nvim', opts = {} },

  -- LSP Support
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    config = true,
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
    },
  },
  {
    'SmiteshP/nvim-navic',
    dependencies = { 'neovim/nvim-lspconfig' },
  },
  { 'j-hui/fidget.nvim', tag = 'legacy', config = true },
}
