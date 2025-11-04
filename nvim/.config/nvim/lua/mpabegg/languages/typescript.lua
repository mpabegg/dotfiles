require('mpabegg.autocmd').format_on_save({
  '*.ts',
  '*.tsx',
  '*.jsx',
}, function()
  vim.cmd([[EslintFixAll]])
end)

return {
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      return vim.tbl_deep_extend('force', opts or {}, {
        servers = {
          eslint = {
            on_attach = function(client, bufnr)
              if client.name == 'eslint' then
                vim.keymap.set('n', 'g=', function()
                  vim.cmd([[EslintFixAll]])
                end, { buffer = bufnr, desc = 'Eslint Fix All' })
              end
              opts.defaults.on_attach(client, bufnr)
            end,
          },
          tsserver = {
            on_attach = function(client, bufnr)
              if client.name == 'tsserver' then
                client.server_capabilities.documentFormattingProvider = false
              end
              opts.defaults.on_attach(client, bufnr)
            end,
          },
        },
      })
    end,
  },
  {
    'jay-babu/mason-null-ls.nvim',
    opts = function(_, opts)
      local with_gemfile = function(utils)
        return utils.root_has_file({ 'Gemfile', '*.gemspec' })
      end

      local without_gemfile = function(utils)
        return not with_gemfile(utils)
      end

      local null_ls = require('null-ls')
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics

      return vim.tbl_deep_extend('force', opts, {
        sources = {
          sources = {
            formatting.rubocop.with({ condition = with_gemfile, command = 'bin/rubocop', timeout = -1 }),
            formatting.rubocop.with({ condition = without_gemfile, timeout = -1 }),
            diagnostics.rubocop.with({ condition = with_gemfile, command = 'bin/rubocop', timeout = -1 }),
            diagnostics.rubocop.with({ condition = without_gemfile, timeout = -1 }),
          },
        },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'javascript', 'tsx', 'typescript' })
    end,
  },
}
