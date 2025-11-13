vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
}, { confirm = false })

require'nvim-treesitter.configs'.setup {
  sync_install = false,
  auto_install = true,
  ignore_install = { },
  indent = { enable = true },
  highlight = { enable = true },
}

require("mason").setup()
require("mason-lspconfig").setup()

require'mpa.lang.lua'
