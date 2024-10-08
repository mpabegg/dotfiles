-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local mpa_augroup = vim.api.nvim_create_augroup('mpa', { clear = true })

now(function()
  add("catppuccin/nvim")
  require("catppuccin").setup({flavour = 'frappe'})
  vim.cmd.colorscheme("catppuccin")
end)

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
  local icons = require('mpa.icons')
  local diagnosticSigns = {
    { name = 'DiagnosticSignError', text = icons.diagnostics.error },
    { name = 'DiagnosticSignWarn', text = icons.diagnostics.warn },
    { name = 'DiagnosticSignHint', text = icons.diagnostics.hint },
    { name = 'DiagnosticSignInfo', text = icons.diagnostics.info },
  }

  for _, sign in ipairs(diagnosticSigns) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = false,
    underline = false,
    severity_sort = true,
    float = {
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  })

  vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
end)

later(function()
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
end)

later(function()
  add('alexghergh/nvim-tmux-navigation')
  require('nvim-tmux-navigation').setup({
      disable_when_zoomed = true,
      keybindings = {
        left = '<C-h>',
        down = '<C-j>',
        up = '<C-k>',
        right = '<C-l>',
      },
  })
end)

later(function()
  add( 'RRethy/vim-illuminate')
  require('illuminate').configure()
end)

now(function()
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify()
end)

later(function()
  require'mini.bufremove'.setup()
  require'mini.comment'.setup()
  require'mini.indentscope'.setup()
  require'mini.trailspace'.setup()
  require'mini.files'.setup()
  vim.keymap.set('n', '<leader>fm', require('mini.files').open)

  vim.api.nvim_create_autocmd({"BufWritePre"}, {
  group = mpa_augroup,
  pattern = '*',
  callback = function()
    require('mini.trailspace').trim()
    require('mini.trailspace').trim_last_lines()
  end,
  })
end)

later(function()
  add("folke/persistence.nvim")
  require("persistence").setup()
  vim.keymap.set('n', '<leader>qq', function() require("persistence").save(); vim.cmd.quitall() end, {silent=true, desc="Quit"})
  vim.keymap.set("n",  '<leader>qr',function() require("persistence").load({ last = true }) end, {silent=true, desc = 'Restore'})
  vim.keymap.set("n",  '<leader>ql', require("persistence").load, {silent=true, desc = 'Load'})
end)

later(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    -- Use 'master' while monitoring updates in 'main'
    checkout = 'master',
    monitor = 'main',
    -- Perform action after every checkout
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'lua', 'vimdoc' },
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
    },
  })
end)
