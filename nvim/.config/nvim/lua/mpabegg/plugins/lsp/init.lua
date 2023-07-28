return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',

    -- Completion capabilities for LSP
    -- 'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    -- Setup neovim lua configuration
    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
    if cmp_ok then
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    end

    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', 'solargraph' },
    })

    require('mason-lspconfig').setup_handlers({
      function(server_name)
        require('lspconfig')[server_name].setup({
          capabilities = capabilities,
          on_attach = require('mpabegg.plugins.lsp.config').on_attach
        })
      end,
    })
  end,
}
