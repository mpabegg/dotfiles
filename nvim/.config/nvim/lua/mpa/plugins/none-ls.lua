Later(function()
  local null_ls = require('null-ls')
  local formatting = null_ls.builtins.formatting

  local sources = {
    formatting.stylua,
    formatting.prettier.with({ prefer_local = 'node_modules/.bin' }),
  }

  -- ESLint from extras
  local ok_fmt, eslint_fmt = pcall(require, 'none-ls.formatting.eslint')
  if ok_fmt then
    table.insert(sources, eslint_fmt.with({ prefer_local = 'node_modules/.bin' }))
  end

  local ok_diag, eslint_diag = pcall(require, 'none-ls.diagnostics.eslint')

  if ok_diag then
    table.insert(sources, eslint_diag.with({ prefer_local = 'node_modules/.bin' }))
  end

  null_ls.setup({
    sources = sources,
    -- Auto-formatting is now handled by mpa.utils.auto_format
  })
end)
