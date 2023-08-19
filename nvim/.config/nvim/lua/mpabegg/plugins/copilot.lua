return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = { 'zbirenbaum/copilot.lua' },
    opts = {},
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  {
    'onsails/lspkind.nvim',
    opts = {
      symbol_map = {
        Copilot = require('mpabegg.icons').kinds.copilot,
      },
    },
    config = function(_, opts)
      require('lspkind').init(opts)
    end,
  },
}
