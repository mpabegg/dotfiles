local add = MiniDeps.add

add({
  source = 'catppuccin/nvim',
  hooks = {
    post_checkout = function()
      ---@diagnostic disable-next-line: missing-fields
      require('catppuccin').setup({
        flavour = 'frappe',
      })
      vim.cmd.colorscheme('catppuccin')
    end,
  },
})
