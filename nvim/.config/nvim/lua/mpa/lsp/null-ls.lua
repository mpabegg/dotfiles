local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

local conditional = function(fn)
  local utils = require("null-ls.utils").make_conditional_utils()
  return fn(utils)
end

null_ls.setup({
  debug = false,
  sources = {
    formatting.stylua.with({ extra_args = { "--search-parent-directories" } }),
    conditional(function(utils)
      return utils.root_has_file "Gemfile"
          and null_ls.builtins.formatting.rubocop.with({
            command = "bundle",
            args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.formatting.rubocop._opts.args),
          })
        or null_ls.builtins.formatting.rubocop
    end),
  },
})
