-- Put this at the top of 'init.lua'
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    -- Uncomment next line to use 'stable' branch
    -- '--branch', 'stable',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
end

-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  vim.opt.backup = false
  vim.opt.clipboard = "unnamedplus"
  vim.opt.colorcolumn = "120"
  vim.opt.completeopt = { "menu", "menuone" }
  vim.opt.cursorline = true
  vim.opt.expandtab = true
  vim.opt.shiftwidth = 2
  vim.opt.tabstop = 2
  vim.opt.hlsearch = false
  vim.opt.ignorecase = true
  vim.opt.incsearch = true
  vim.opt.laststatus = 3
  vim.opt.number = true
  vim.opt.numberwidth = 2
  vim.opt.relativenumber = false
  vim.opt.scrolloff = 8
  vim.opt.showmode = false
  vim.opt.signcolumn = "yes"
  vim.opt.smartcase = true
  vim.opt.smartindent = true
  vim.opt.splitbelow = true
  vim.opt.splitright = true
  vim.opt.swapfile = false
  vim.opt.termguicolors = true
  vim.opt.undodir = vim.fn.stdpath "data" .. "/undodir"
  vim.opt.undofile = true
  vim.opt.wrap = false
  vim.opt.autochdir = false

  vim.g.netrw_browse_split = 0
  vim.g.netrw_banner = 0
  vim.g.netrw_winsize = 25

  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
  vim.g.mapleader = " "
  vim.g.maplocalleader = ","
end)

now(function()
  add "echasnovski/mini.files"
  require("mini.files").setup({})
end)
