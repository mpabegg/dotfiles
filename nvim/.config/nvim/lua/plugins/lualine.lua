local function unique(list)
  local seen = {}
  local result = {}
  for _, item in ipairs(list) do
    if not seen[item] then
      seen[item] = true
      table.insert(result, item)
    end
  end
  return result
end

local get_attached_tools = function()
  local buf_ft = vim.bo.filetype
  local tools = {}

  local null_ls_s, null_ls = pcall(require, 'null-ls')

  if null_ls_s then
    local sources = null_ls.get_sources()
    for _, source in ipairs(sources) do
      if source._validated then
        for ft_name, ft_active in pairs(source.filetypes) do
          if ft_name == buf_ft and ft_active then
            table.insert(tools, source.name)
          end
        end
      end
    end
  end

  local unique_client_names = unique(tools)
  if #unique_client_names == 0 then
    return nil
  end

  local client_names_str = table.concat(unique_client_names, '  ')
  return string.format('󱁤 %s', client_names_str)
end

local function get_attached_clients()
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  if #buf_clients == 0 then
    return nil
  end

  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    if client.name ~= 'null-ls' then
      table.insert(buf_client_names, client.name)
    end
  end

  local unique_client_names = unique(buf_client_names)
  if #unique_client_names == 0 then
    return nil
  end
  local client_names_str = table.concat(unique_client_names, '  ')

  return string.format('󱐋 %s', client_names_str)
end

return { 'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
local icons = require('mpa.icons')

  require('lualine').setup({
      options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        theme = 'auto',
        globalstatus = true,
        disabled_filetypes = {
          statusline = { 'snacks_picker_list', 'netrw', 'snacks_layout_box', 'sidekick_terminal' },
          winbar = { 'snacks_picker_list', 'netrw', 'snacks_layout_box' , 'sidekick_terminal'},
        },
      },
    winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          'filetype',
          colored = false,
          icon_only = true,
          separator = '',
          padding = { left = 1, right = 0 },
        },
        {
          'filename',
          path = 1,
          file_status = true,
          newfile_status = true,
          symbols = {
            modified = icons.file.modified,
            readonly = icons.file.readonly,
          },
          separator = '',
        },
        {
          'navic',
          separator = '',
        },
      },
      lualine_x = {
        { 'diagnostics', symbols = icons.diagnostics },
      },
      lualine_y = {},
      lualine_z = {},
    },
    inactive_winbar = {
      lualine_a = {},
      lualine_b = {
        {
          'filename',
          file_status = true,
          newfile_status = true,
          path = 0,

          symbols = {
            modified = icons.file.modified,
            readonly = icons.file.readonly,
          },
        },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        {
          function()
            local cwd = vim.fn.getcwd()
            local home = vim.fn.expand('~')
            if string.find(cwd, home, 1, true) == 1 then
              return string.gsub(cwd, home, '~', 1)
            else
              return cwd
            end
          end,
          separator = '',
        },
        { 'branch', color = { gui = 'italic' } },
      },
      lualine_c = { { 'diagnostics', sources = { 'nvim_workspace_diagnostic' }, symbols = icons.diagnostics } },
      lualine_x = {
        {
          function()
            local recording_register = vim.fn.reg_recording()
            if recording_register == '' then
              return ''
            else
              return ' ' .. recording_register
            end
          end,
        },
      },
      lualine_y = {
        {
          get_attached_tools,
          cond = function() return get_attached_tools() ~= nil end,
        },
        {
          get_attached_clients,
          cond = function() return get_attached_clients() ~= nil end,
        },
      },
      lualine_z = {
        { 'location' },
      },
    },
  })
  end
}
