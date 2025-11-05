local add = MiniDeps.add

add({
  source = 'nvim-treesitter/nvim-treesitter-textobjects',
})

add({
  source = 'nvim-treesitter/nvim-treesitter',
  depends = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  hooks = {
    post_checkout = function()
      vim.cmd('TSUpdate')
      require('nvim-treesitter.configs').setup({
        highlight = { enabled = true },
        indent = { enabled = true },
        ensure_installed = {
          'bash',
          'html',
          'json',
          'markdown',
          'markdown_inline',
          'query',
          'vim',
          'vimdoc',
          'yaml',
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
        },
      })
    end,
  },
})
