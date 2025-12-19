return
    {
      "kevinhwang91/nvim-ufo",
      dependencies = { 'kevinhwang91/promise-async' },
      config = function()
        local ufo = require'ufo'
        ufo.setup({
          provider_selector = function(bufnr)
            local clients = vim.lsp.get_clients({ bufnr = bufnr })
            for _, client in ipairs(clients) do
              if client.server_capabilities.foldingRangeProvider then
                return { 'lsp', 'indent' }
              end
            end
            return { 'treesitter', 'indent' }
          end})
        vim.keymap.set('n', 'zR', require'ufo'.openAllFolds, { desc = "Reset/Open all folds" })
        vim.keymap.set('n', 'zM', require'ufo'.closeAllFolds, { desc = "Minimize/Close all folds" })
      end,
  }
