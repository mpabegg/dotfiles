return {
  'catppuccin/nvim',
  name = 'catppuccin',
  init = function()
    ---@diagnostic disable-next-line: missing-fields
    require('catppuccin').setup({
      flavour = 'frappe',
    })
    vim.cmd.colorscheme('catppuccin')
  end,
}
