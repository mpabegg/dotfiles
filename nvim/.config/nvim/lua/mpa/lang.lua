vim.pack.add({
  { src = 'https://github.com/folke/lazydev.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/j-hui/fidget.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/nvimtools/none-ls.nvim' },
})

require('lazydev').setup()
require('fidget').setup({})
require('mason').setup()
require('nvim-treesitter.configs').setup({
  sync_install = false,
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})

local has_binstub = (vim.fn.filereadable(vim.fn.getcwd() .. '/bin/rubocop') == 1)
local function project_rubocop()
  return has_binstub and 'bin/rubocop' or 'rubocop'
end

vim.lsp.config('ruby_lsp', has_binstub and {
  init_options = { formatter = 'syntax_tree', linters = {} },
} or {
  init_options = { formatter = 'rubocop', linters = { 'rubocop' } },
})

vim.lsp.enable({ 'lua_ls', 'ruby_lsp', 'ts_ls', 'eslint' })

-- TS/JS: first ts_ls formats, then ESLint fixAll
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.ts', '*.tsx', '*.js', '*.jsx', '*.mjs', '*.cjs' },
  callback = function(args)
    local buf = args.buf

    -- 1) Format via ts_ls only
    -- vim.lsp.buf.format({
    --   bufnr = buf,
    --   timeout_ms = 15000,
    --   filter = function(client)
    --     -- prefer the new name ("ts_ls"); fall back to "tsserver" if needed
    --     return client.name == 'ts_ls' or client.name == 'tsserver'
    --   end,
    -- })

    -- 2) ESLint: apply "source.fixAll.eslint"
    local has_eslint = #vim.lsp.get_clients({ bufnr = buf, name = 'eslint' }) > 0
    if has_eslint then
      vim.lsp.buf.code_action({
        context = { only = { 'source.fixAll.eslint' } },
        apply = true,
      })
    end
  end,
})

local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
    null_ls.builtins.formatting.rubocop.with({ command = project_rubocop(), timeout = -1 }),
    null_ls.builtins.diagnostics.rubocop.with({ command = project_rubocop(), timeout = -1 }),
  },
})

vim.keymap.set('n', '<localleader>f', function()
  vim.lsp.buf.format({ timeout_ms = 15000 })
end)

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.lua', '*.rb' },
  callback = function()
    vim.lsp.buf.format()
  end,
})

local icons = require('mpa.icons')
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.warn,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.info,
    },
  },
  virtual_text = false,
  update_in_insert = false,
  underline = false,
  severity_sort = true,
  float = {
    focusable = true,
    style = 'minimal',
    source = false,
    header = '',
    prefix = '',
  },
})

Snacks.keymap.set('n', 'gl', vim.diagnostic.open_float)
Snacks.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = 1, float = true }) end)
Snacks.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = -1, float = true }) end)

Snacks.keymap.set("n", "gd", vim.lsp.buf.definition)
Snacks.keymap.set('n', 'K', function()
  local ufo_ok, ufo = pcall(require, 'ufo')
  if ufo_ok then
    local winid = ufo.peekFoldedLinesUnderCursor()
    if not winid then
      vim.lsp.buf.hover()
    end
  else
    vim.lsp.buf.hover()
  end
end, {
  lsp = { method = "textDocument/hover" } })
