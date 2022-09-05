local null_ls = require "null-ls"
local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

local rubocop = function()
  local utils = require("null-ls.utils").make_conditional_utils()
  local bundled = utils.root_has_file "Gemfile"
  local opts = bundled and {
    command = "bundle",
    args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.formatting.rubocop._opts.args),
  } or {}

  return formatting.rubocop.with(opts)
end

null_ls.setup({
  debug = false,
  sources = {
    formatting.stylua,
    rubocop(),
  },
})
