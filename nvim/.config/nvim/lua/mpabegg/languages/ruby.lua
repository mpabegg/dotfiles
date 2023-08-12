return {
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      return vim.tbl_deep_extend('force', opts or {}, {
        servers = {
          solargraph = {
            root_dir = require('lspconfig.util').root_pattern('.git'),
            debounce_text_changes = 150,
            on_attach = function(client, bufnr)
              opts.defaults.on_attach(client, bufnr)

              if client.name == 'solargraph' then
                client.server_capabilities.documentFormattingProvider = false
              end
            end,
          },
        },
      })
    end,
  },
}
