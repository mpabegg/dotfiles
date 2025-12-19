vim.pack.add({ 'https://github.com/folke/lazy.nvim' })

require('mpa.options')
require('mpa.keymaps')
require('mpa.autocmds')

require('lazy').setup({
  spec = {
    { import = 'plugins' },
    { import = 'languages' },
  }, ---@type LazySpec
  checker = { notify = false },
  change_detection = { notify = false },
})
