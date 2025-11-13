vim.pack.add({ 
  { src = "https://github.com/folke/lazydev.nvim" }
})

require('mason-lspconfig').setup({
  ensure_installed = { "lua_ls", "stylua" }
})

require'lazydev'.setup()
