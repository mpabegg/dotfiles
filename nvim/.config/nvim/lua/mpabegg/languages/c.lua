local add = MiniDeps.add

add({
  source = 'neovim/nvim-lspconfig',
  hooks = {
    post_checkout = function()
      require('lspconfig').clangd.setup({})
    end,
  },
})

add({
  source = 'nvim-treesitter/nvim-treesitter',
  hooks = {
    post_checkout = function()
      local configs = require('nvim-treesitter.configs')
      local current_config = configs.get_config()
      if not current_config.ensure_installed then
        current_config.ensure_installed = {}
      end
      vim.list_extend(current_config.ensure_installed, { 'c', 'cpp' })
    end,
  },
})
