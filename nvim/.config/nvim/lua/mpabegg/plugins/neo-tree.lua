local icons = require('mpabegg.icons')
local config = {
  enable_diagnostics = true,
  enable_git_status = true,
  enable_modified_markers = true, -- Show markers for files with unsaved changes.
  enable_opened_markers = true, -- Enable tracking of opened files. Required for `components.name.highlight_opened_files`
  enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
  enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
  open_files_in_last_window = true, -- false = open files in top left window
  window = {
    auto_expand_width = true, -- expand the window when file exceeds the window width. does not work with position = "float"
    mappings = {
      ['h'] = 'close_node',
      ['l'] = 'open',
      ['s'] = 'open_split',
      ['v'] = 'open_vsplit',
    },
  },
  filesystem = {
    follow_current_file = {
      enabled = true, -- This will find and focus the file in the active buffer every time
      --               -- the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
  },
  default_component_configs = {
    name = {
      use_git_status_colors = false,
    },
    diagnostics = {
      symbols = {
        hint = icons.diagnostics.hint,
        info = icons.diagnostics.info,
        warn = icons.diagnostics.warn,
        error = icons.diagnostics.error,
      },
    },
    icon = {
      folder_closed = '',
      folder_open = '',
      folder_empty = '󰜌',
      folder_empty_open = '󰜌',
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = '*',
      highlight = 'NeoTreeFileIcon',
    },
    modified = {
      symbol = '',
    },
    git_status = {
      symbols = {
        -- Change type
        added = ' ',
        modified = ' ',
        removed = ' ',
        deleted = '✖',
        renamed = '󰁕',
        -- Status type
        untracked = '',
        ignored = '◌',
        unstaged = '󰄱',
        staged = '',
        conflict = '',
      },
    },
    kinds = {
      Unknown = { icon = '?', hl = '' },
      Root = { icon = '', hl = 'NeoTreeRootName' },
      File = { icon = '󰈙', hl = 'Tag' },
      Module = { icon = '', hl = 'Exception' },
      Namespace = { icon = '󰌗', hl = 'Include' },
      Package = { icon = '󰏖', hl = 'Label' },
      Class = { icon = '󰌗', hl = 'Include' },
      Method = { icon = '', hl = 'Function' },
      Property = { icon = '󰆧', hl = '@property' },
      Field = { icon = '', hl = '@field' },
      Constructor = { icon = '', hl = '@constructor' },
      Enum = { icon = '󰒻', hl = '@number' },
      Interface = { icon = '', hl = 'Type' },
      Function = { icon = '󰊕', hl = 'Function' },
      Variable = { icon = '', hl = '@variable' },
      Constant = { icon = '', hl = 'Constant' },
      String = { icon = '󰀬', hl = 'String' },
      Number = { icon = '󰎠', hl = 'Number' },
      Boolean = { icon = '', hl = 'Boolean' },
      Array = { icon = '󰅪', hl = 'Type' },
      Object = { icon = '󰅩', hl = 'Type' },
      Key = { icon = '󰌋', hl = '' },
      Null = { icon = '', hl = 'Constant' },
      EnumMember = { icon = '', hl = 'Number' },
      Struct = { icon = '󰌗', hl = 'Type' },
      Event = { icon = '', hl = 'Constant' },
      Operator = { icon = '󰆕', hl = 'Operator' },
      TypeParameter = { icon = '󰊄', hl = 'Type' },
      -- ccls
      -- TypeAlias = { icon = ' ', hl = 'Type' },
      -- Parameter = { icon = ' ', hl = '@parameter' },
      -- StaticMethod = { icon = '󰠄 ', hl = 'Function' },
      -- Macro = { icon = ' ', hl = 'Macro' },
    },
  },
}

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  opts = config,
}
