-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

---@diagnostic disable-next-line: missing-parameter
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
   augroup packer_user_config
     autocmd!
     autocmd BufWritePost plugins.lua source <afile> | PackerSync
   augroup end
 ]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end
local util = require "packer.util"

packer.init({
  ensure_dependencies = true, -- Should packer install plugin dependencies?
  snapshot = nil, -- Name of the snapshot you would like to load at startup
  snapshot_path = util.join_paths(vim.fn.stdpath "cache", "packer.nvim"), -- Default save directory for snapshots
  package_root = util.join_paths(vim.fn.stdpath "data", "site", "pack"),
  compile_path = util.join_paths(vim.fn.stdpath "data", "plugin", "packer_compiled.lua"),
  max_jobs = nil, -- Limit the number of simultaneous jobs. nil means no limit
  auto_clean = true, -- During sync(), remove unused plugins
  compile_on_sync = true, -- During sync(), run packer.compile()
  disable_commands = false, -- Disable creating commands
  opt_default = false, -- Default to using opt (as opposed to start) plugins
  transitive_opt = true, -- Make dependencies of opt plugins also opt by default
  transitive_disable = true, -- Automatically disable dependencies of disabled plugins
  auto_reload_compiled = true, -- Automatically reload the compiled file after creating it.
  git = {
    cmd = "git", -- The base command for git operations
    subcommands = { -- Format strings for git subcommands
      update = "pull --ff-only --progress --rebase=false",
      install = "clone --depth %i --no-single-branch --progress",
      fetch = "fetch --depth 999999 --progress",
      checkout = "checkout %s --",
      update_branch = "merge --ff-only @{u}",
      current_branch = "branch --show-current",
      diff = "log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD",
      diff_fmt = "%%h %%s (%%cr)",
      get_rev = "rev-parse --short HEAD",
      get_msg = "log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1",
      submodules = "submodule update --init --recursive --progress",
    },
    depth = 1, -- Git clone depth
    clone_timeout = 60, -- Timeout, in seconds, for git clones
    default_url_format = "https://github.com/%s", -- Lua format string used for "aaa/bbb" style plugins
  },
  display = {
    non_interactive = false, -- If true, disable display windows for all operations
    open_fn = nil, -- An optional function to open a window for packer's display
    open_cmd = "65vnew \\[packer\\]", -- An optional command to open a window for packer's display
    working_sym = "⟳", -- The symbol for a plugin being installed/updated
    error_sym = "✗", -- The symbol for a plugin with an error in installation/updating
    done_sym = "✓", -- The symbol for a plugin which has completed installation/updating
    removed_sym = "-", -- The symbol for an unused plugin which was removed
    moved_sym = "→", -- The symbol for a plugin which was moved (e.g. from opt to start)
    header_sym = "━", -- The symbol for the header line in packer's display
    show_all_info = true, -- Should packer show all update details automatically?
    prompt_border = "double", -- Border style of prompt popups.
    keybindings = { -- Keybindings for the display window
      quit = "q",
      toggle_info = "<CR>",
      diff = "d",
      prompt_revert = "r",
    },
  },
  luarocks = {
    python_cmd = "python", -- Set the python command to use for running hererocks
  },
  log = { level = "warn" }, -- The default print log level. One of: "trace", "debug", "info", "warn", "error", "fatal".
  profile = {
    enable = false,
    threshold = 1, -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
  },
  autoremove = false, -- Remove disabled or unused plugins without prompting the user
})

packer.startup(function(use)
  -- Basics
  use "wbthomason/packer.nvim" -- Packer can manage itself
  use "nvim-lua/plenary.nvim" -- Bunch of utlils, used by many plugins

  -- Colorschemes
  use "folke/tokyonight.nvim"

  --Keybindings
  use "folke/which-key.nvim"

  -- Completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-nvim-lsp"

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use "jose-elias-alvarez/null-ls.nvim"

  -- snippets
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "rafamadriz/friendly-snippets"

  use "RRethy/vim-illuminate"
  use "folke/lua-dev.nvim"

  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  })
  use "p00f/nvim-ts-rainbow"
  use "theHamsta/nvim-treesitter-pairs"

  use 'sunjon/shade.nvim'

  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
  })

  use 'christoomey/vim-tmux-navigator'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
