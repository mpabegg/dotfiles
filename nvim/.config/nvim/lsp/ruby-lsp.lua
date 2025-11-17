return {
  filetypes = { 'ruby' },
  cmd = { 'ruby-lsp' }, -- or { "bundle", "exec", "ruby-lsp" } if you prefer
  root_markers = { 'Gemfile', '.git' },
  init_options = {
    formatter = 'syntax_tree', -- never use RuboCop here
    linters = {}, -- no RuboCop diagnostics from ruby-lsp
  },
}
