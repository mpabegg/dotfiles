return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { { 'folke/neodev.nvim' } },
    opts = function(_, opts)
      require('neodev').setup()
      return vim.tbl_deep_extend('force', opts or {}, {
        servers = {
          lua_ls = {
            settings = {
              Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                hint = {
                  enable = true,
                  arrayIndex = 'Enable',
                  setType = true,
                },
              },
            },
          },
        },
      })
    end,
  },
}
