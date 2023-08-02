local M = {}

M.on_attach = function(client, bufnr)
  if client.name == 'solargraph' then
    client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
  end
end

local with_gemfile = function(utils)
  return utils.root_has_file({ 'Gemfile', '*.gemspec' })
end

local without_gemfile = function(utils)
  return not with_gemfile(utils)
end

local bundler_opts_for = function(builtin)
  return {
    command = 'bundle',
    args = vim.list_extend({ 'exec', 'rubocop', '-a' }, builtin._opts.args),
    timeout = -1,
  }
end

M.null_ls = function()
  local null_ls = require('null-ls')
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup({
    update_in_insert = false,
    debounce = 150,
    sources = {
      formatting.rubocop.with(
        vim.tbl_extend('force', { condition = with_gemfile }, bundler_opts_for(formatting.rubocop))
      ),
      formatting.rubocop.with({ condition = without_gemfile }),
      diagnostics.rubocop.with(
        vim.tbl_extend('force', { condition = with_gemfile }, bundler_opts_for(diagnostics.rubocop))
      ),
      diagnostics.rubocop.with({ condition = without_gemfile }),
    },
  })
end

M.solargraph = function()
  require('lspconfig').solargraph.setup({
    root_dir = require('lspconfig.util').root_pattern('.git'),
    debounce_text_changes = 150,
  })
end

return M
