vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/folke/ts-comments.nvim" },
  { src = "https://github.com/folke/lazydev.nvim" },
  { src = "https://github.com/folke/flash.nvim" },
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = "https://github.com/stevearc/oil.nvim" },
}, { confirm = false })

require 'ts-comments'.setup()

require 'snacks'.setup({
  indent = { enable = true },
  explorer = { enable = true },
})

require 'mpa.opts'
require 'mpa.folds'
require 'mpa.colors'
require 'mpa.git'
require 'mpa.lang'
require 'mpa.tmux'

vim.api.nvim_create_autocmd('TextYankPost', {
  group = mpabegg,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 100,
    })
  end,
})

require 'flash'.setup {}
vim.keymap.set({ "n", "x", "o" }, 's', require 'flash'.jump)
vim.keymap.set({ "n", "x", "o" }, 'S', require 'flash'.treesitter)
vim.keymap.set('o', 'r', require 'flash'.remote)
vim.keymap.set({ 'o', 'x' }, 'R', require 'flash'.treesitter_search)
vim.keymap.set('c', '<c-s>', require 'flash'.toggle)

require 'oil'.setup {}
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

local config_file = vim.fn.expand("$MYVIMRC")
vim.keymap.set("n", "<leader>x", function()
  vim.cmd("source " .. config_file)
  print("Reloaded " .. config_file)
end, { desc = "Reload Neovim config" })

require 'mini.splitjoin'.setup {}

Snacks.keymap.set("n", "<leader>wv", "<c-w>v")
Snacks.keymap.set("n", "<leader>ws", "<c-w>s")
Snacks.keymap.set("n", "<leader>wd", function()
  if #vim.api.nvim_list_wins() > 1 then
    vim.cmd('close')
  end
end
)

local api = vim.api

local function ToggleMaximizeWindow()
  local cur_tab = api.nvim_get_current_tabpage()

  -- If this tab knows where to go back, we're in the "zoom" tab
  if vim.t._max_restore_tab and api.nvim_tabpage_is_valid(vim.t._max_restore_tab) then
    local restore_tab = vim.t._max_restore_tab

    -- Go back to the original tab
    api.nvim_set_current_tabpage(restore_tab)

    -- Close the zoom tab (the one we were just in)
    local zoom_tabnr = api.nvim_tabpage_get_number(cur_tab)
    vim.cmd(zoom_tabnr .. "tabclose")

    -- Clean up the tab-local var
    vim.t._max_restore_tab = nil
  else
    -- We are in a normal tab: create a "zoom" tab
    local original_tab = cur_tab

    -- Open the current window in a new tab as the only window
    vim.cmd("tab split")

    -- In the new tab, remember where to go back
    vim.t._max_restore_tab = original_tab
  end
end

vim.keymap.set("n", "<leader>wm", ToggleMaximizeWindow, {
  desc = "Toggle maximize current window (zoom tab)",
})

Snacks.keymap.set('n', '<leader>wm', ToggleMaximizeWindow, {
  desc = "Toggle maximize window"
})

Snacks.keymap.set("n", "<leader>ff", Snacks.picker.smart)
Snacks.keymap.set("n", "<leader>ft", Snacks.picker.explorer)
Snacks.keymap.set("n", "<leader>bb", Snacks.picker.buffers)
Snacks.keymap.set("n", "<leader>hh", Snacks.picker.help)
