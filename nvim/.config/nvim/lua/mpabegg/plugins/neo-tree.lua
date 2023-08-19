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
      ['<Space>'] = 'none',
    },
  },
  filesystem = {
    filtered_items = {
      visible = true,
    },
    use_libuv_file_watcher = true,
    hijack_netrw_behavior = 'disabled',
    bind_to_cwd = false,
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
      symbols = icons.diagnostics,
    },
    icon = {
      folder_closed = icons.file.folder_closed,
      folder_open = icons.file.folder_open,
      folder_empty = icons.file.folder_empty,
      folder_empty_open = icons.file.folder_empty_open,
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = '*',
      highlight = 'NeoTreeFileIcon',
    },
    modified = {
      symbol = icons.file.modified,
    },
    git_status = {
      symbols = icons.git,
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
