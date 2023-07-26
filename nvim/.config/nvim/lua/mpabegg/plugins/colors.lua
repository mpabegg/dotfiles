return {
  'catppuccin/nvim',
  name = 'catppuccin',
  init = function()
    require('catppuccin').setup({
      flavour = 'frappe',
    })
    vim.cmd.colorscheme('catppuccin')
  end,
}
