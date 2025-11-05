local add = MiniDeps.add

add({
  source = 'alexghergh/nvim-tmux-navigation',
  hooks = {
    post_checkout = function()
      require('nvim-tmux-navigation').setup({
        disable_when_zoomed = true,
        keybindings = {
          left = '<C-h>',
          down = '<C-j>',
          up = '<C-k>',
          right = '<C-l>',
        },
      })
    end,
  },
})

add({ source = 'NStefan002/visual-surround.nvim', hooks = { post_checkout = function() require('visual-surround').setup({}) end } })

add({
  source = 'kylechui/nvim-surround',
  hooks = {
    post_checkout = function()
      require('nvim-surround').setup({})
    end,
  },
})

add({
  source = 'RRethy/vim-illuminate',
  hooks = {
    post_checkout = function()
      require('illuminate').configure({})
    end,
  },
})

add({
  source = 'echasnovski/mini.bufremove',
  hooks = {
    post_checkout = function()
      require('mini.bufremove').setup({})
      vim.keymap.set('n', '<leader>bd', function()
        require('mini.bufremove').delete()
      end, { desc = 'Delete Buffer' })
    end,
  },
})

add({ source = 'echasnovski/mini.comment', hooks = { post_checkout = function() require('mini.comment').setup({}) end } })

add({ source = 'echasnovski/mini.indentscope', hooks = { post_checkout = function() require('mini.indentscope').setup({}) end } })

add({ source = 'echasnovski/mini.trailspace', hooks = { post_checkout = function() require('mini.trailspace').setup({}) end } })

add({ source = 'echasnovski/mini.splitjoin', hooks = { post_checkout = function() require('mini.splitjoin').setup({}) end } })

add({
  source = 'echasnovski/mini.files',
  hooks = {
    post_checkout = function()
      vim.keymap.set('n', '<leader>fm', require('mini.files').open)
    end,
  },
})
