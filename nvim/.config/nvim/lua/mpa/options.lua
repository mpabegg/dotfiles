local opts = {
  autoindent = true,
  autoread = true,
  background = "dark",
  backup = false,
  clipboard = "unnamed",
  completeopt = { "menuone", "preview", "noselect" },
  cursorline = true,
  expandtab = true,
  guifont = { "ComicCode Nerd Font", ":h14" },
  number = true,
  shiftwidth = 2,
  showmode = false,
  signcolumn = "yes",
  smartcase = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 2,
  termguicolors = true,
  timeoutlen = 500,
  undofile = true,
  updatetime = 100,
  wrap = false,
  writebackup = false,
}

vim.opt.formatoptions:remove "c,r,o"
vim.opt.iskeyword:append "_"
vim.opt.fillchars:append({
  eob = " ",
  stl = " ",
})

for k, v in pairs(opts) do
  vim.opt[k] = v
end
