local ok, which_key = pcall(require, "which-key")
if not ok then
  return
end

local telescope = require "telescope.builtin"
local pairs = require "nvim-treesitter.pairs"

local function cmd(s)
  return function()
    vim.cmd(s)
  end
end

local leader_mappings = {
  ["<leader>"] = {
    f = {
      name = "File",
      s = { cmd "w", "save" },
      m = { cmd "Ex", "Ex" },
      d = {
        function()
          telescope.git_files({ cwd = "$MYDOTDIR", hidden = true })
        end,
        "find",
      },
      f = {
        function()
          telescope.find_files({ hidden = true })
        end,
        "find",
      },
    },
    w = {
      name = "Window",
      v = { cmd "vsplit", "Split Right" },
      s = { cmd "split", "Split Below" },
      d = { cmd "quit", "Close" },
      j = { "<C-w>j", "down" },
      h = { "<C-w>h", "left" },
      l = { "<C-w>l", "right" },
      k = { "<C-w>k", "up" },
    },
    l = {
      name = "LSP",
      f = { vim.lsp.buf.formatting, "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    },
    h = {
      name = "help",
      h = { telescope.help_tags, "telescope" },
      k = { telescope.keymaps, "keys" }
    },
  },
}
which_key.register(leader_mappings)
