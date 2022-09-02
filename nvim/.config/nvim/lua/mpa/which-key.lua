local ok, which_key = pcall(require, "which-key")
if not ok then
  return
end

local function cmd(s)
  return function() vim.cmd(s) end
end

local leader_mappings = {
  f = {
    name = "File",
    s = { cmd "w", "Save" },
    m = { cmd "Ex", "Ex" }
  },
  w = {
    name = "Window",
    v = { cmd "vsplit", "Split Right" },
    s = { cmd "split", "Split Below" },
    d = { cmd "quit", "Close" },
    j = { "<C-w>j", "down" },
    h = { "<C-w>h", "left" },
    l = { "<C-w>l", "right" },
    k = { "<C-w>k", "up" }
  },
  l = {
    name = "LSP",
    f = { vim.lsp.buf.formatting, "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
  }
}
which_key.register(leader_mappings, { prefix = "<leader>" })
