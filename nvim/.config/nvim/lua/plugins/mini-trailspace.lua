return
    {
      "nvim-mini/mini.trailspace",
      config = function()
        require('mini.trailspace').setup()
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('mini-trailspace', { clear = false }),
          pattern = '*',
          callback = function()
            require('mini.trailspace').trim()
            require('mini.trailspace').trim_last_lines()
          end,
          desc = 'Remove trailing whitespace on save',
        })
      end
    }
