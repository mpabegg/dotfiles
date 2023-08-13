return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  opts = function()
    return {
      highlight = { enabled = true },
      indent = { enabled = true },
      ensure_installed = {
        'bash',
        'html',
        'javascript',
        'json',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'tsx',
        'typescript',
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
    }
  end,
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
