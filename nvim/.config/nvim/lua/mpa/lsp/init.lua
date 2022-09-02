local ok, _ = pcall(require, "lspconfig")
if not ok then
  return
end

require "mpa.lsp.configs"
require("mpa.lsp.handlers").setup()
require "mpa.lsp.null-ls"
