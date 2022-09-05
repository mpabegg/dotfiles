local colorscheme = "tokyonight"

vim.o.background = "dark"
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_trasnparent = true

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
