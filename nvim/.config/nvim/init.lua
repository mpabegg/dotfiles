-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("mpabegg.options")
require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function() 
      vim.cmd.colorscheme "catppuccin-macchiato"
    end
  },
  { 
    "alexghergh/nvim-tmux-navigation",
    config = { 
      disable_when_zoomed = true,
      keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
      },
    },
  },
  { 
    'nvim-treesitter/nvim-treesitter',
    init = function ()
      require("nvim-treesitter.configs").setup({
        highlight = { enabled = true },
        indent = { enabled = true },
        ensure_installed = {
          "bash",
          "elixir",
          "html",
          "javascript",
          "json",
          "luadoc", 
          "markdown",
          "markdown_inline",
          "query",
          "ruby",
          "tsx",
          "typescript",
          "vim",
          "vimdoc", 
          "yaml",
        }
      })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
  },
  {
    "mbbill/undotree",
    init = function ()
      vim.keymap.set("n", "<leader>U", vim.cmd.UndotreeToggle)
    end
  }
})
