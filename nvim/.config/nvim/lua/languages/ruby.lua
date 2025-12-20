local utils = require('mpa.utils')
utils.auto_format('*.rb')

local ruby_lsp_cmd = function()
  local cmd = { 'ruby-lsp' }
  if vim.fn.executable('ruby-lsp') == 1 then
    local paths = vim.fn.systemlist('which -a ruby-lsp')
    for _, p in ipairs(paths) do
      if not string.find(p, 'mason') then
        cmd = { p }
        break
      end
    end
  end
  return cmd
end

local function find_umbrella_root(arg)
  -- Handle the case where arg might be the filename (if standard lspconfig behavior applies)
  local fname
  if type(arg) == 'number' then
    fname = vim.api.nvim_buf_get_name(arg)
  else
    fname = arg
  end

  if not fname or fname == '' then
    return vim.fn.getcwd()
  end

  local path = vim.fs.dirname(fname)

  -- First, try to find git root (most reliable for umbrella projects)
  -- Note: vim.fs.find returns the path including the found item (e.g., /path/to/.git)
  -- We want the parent of .git
  local git_item = vim.fs.find('.git', { path = path, upward = true, type = 'directory' })[1]
  if git_item then
    local root = vim.fs.dirname(git_item)
    return root
  end

  -- Fall back to finding topmost Gemfile by walking up the tree
  local current = path
  local topmost_gemfile = nil
  while current ~= '/' and current ~= '' do
    local gemfile = vim.fs.joinpath(current, 'Gemfile')
    if vim.fn.filereadable(gemfile) == 1 then
      topmost_gemfile = current
    end
    local parent = vim.fs.dirname(current)
    if parent == current then
      break
    end
    current = parent
  end

  if topmost_gemfile then
    return topmost_gemfile
  end

  -- Fallback: use CWD if it contains a Gemfile
  local cwd = vim.fn.getcwd()
  if vim.fn.filereadable(vim.fs.joinpath(cwd, 'Gemfile')) == 1 then
    return cwd
  end

  -- Fallback to current file's directory
  return path
end

local root_dir = function(bufnr, on_dir)
  local root = find_umbrella_root(bufnr)
  if root then
    on_dir(root)
  end
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      return utils.deep_extend(opts, {
        ensure_installed = { 'ruby' },
      })
    end,
  },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = function(_, opts) return utils.deep_extend(opts, { ensure_installed = { 'ruby_lsp' } }) end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      return utils.deep_extend(opts, {
        servers = {
          ruby_lsp = {
            root_dir = root_dir,
            cmd = ruby_lsp_cmd(),
            on_new_config = function(new_config, new_root_dir)
              if vim.fn.filereadable(vim.fs.joinpath(new_root_dir, 'bin', 'rubocop')) == 1 then
                new_config.init_options = new_config.init_options or {}
                new_config.init_options.formatter = 'none'
                new_config.init_options.enabledFeatures = new_config.init_options.enabledFeatures
                  or {}
              end
            end,
          },
        },
      })
    end,
  },
}
