vim.pack.add{ { src = "https://github.com/lewis6991/gitsigns.nvim" } }
require('gitsigns').setup({
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
  },
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  signs_staged = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
  },
  on_attach = function(buffer)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
    end

    -- stylua: ignore start
    map("n", "]h", gs.next_hunk, "Next Hunk")
    map("n", "[h", gs.prev_hunk, "Prev Hunk")
    map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
    map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
  end,
})

vim.pack.add{
  { src = "https://github.com/NeogitOrg/neogit" },  
  { src = "https://github.com/nvim-lua/plenary.nvim" },
}
local icons = require'mpa.icons'
require('neogit').setup({
  signs = {
    -- { CLOSED, OPENED }
    section = { icons.ui.carret_right, icons.ui.carret_down },
    item = { icons.ui.carret_right, icons.ui.carret_down },
  },
})
-- Neogit keymaps
vim.keymap.set('n', '<leader>gs', require('neogit').open, { desc = 'Git Status' }
)
