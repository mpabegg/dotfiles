# Neovim Configuration

A modern, modular Neovim configuration built with Lua and organized for maintainability.

## Features

- **Modular Structure**: Clean separation of concerns with core config, plugins, and modules
- **One Plugin Per File**: Each plugin has its own configuration file for easy management
- **Modern Plugin Manager**: Uses [mini.deps](https://github.com/nvim-mini/mini.deps) for fast, lightweight plugin management
- **LSP Support**: Full Language Server Protocol support with Mason for tool installation
- **Modern UI**: Beautiful statusline, colorschemes, and UI enhancements
- **Git Integration**: Comprehensive git workflow with Neogit and Gitsigns
- **Fuzzy Finding**: Powerful file and buffer navigation with Snacks
- **Code Intelligence**: Treesitter, completion, and LSP for enhanced coding experience

## Structure

```
nvim/
├── init.lua                 # Entry point
├── lua/
    └── mpa/
        ├── init.lua         # Main configuration loader
        ├── deps.lua         # Plugin manager setup
        ├── icons.lua         # Icon definitions
        ├── core/             # Core Neovim settings
        │   ├── options.lua   # Editor options
        │   ├── keymaps.lua   # Key mappings
        │   └── autocmds.lua  # Autocommands
        └── plugins/          # Individual plugin configurations
            ├── init.lua      # Plugin loader
            ├── neogit.lua
            ├── gitsigns.lua
            ├── snacks.lua
            └── ...           # One file per plugin
```

## Installation

1. **Clone this repository** to your Neovim config directory:

   ```bash
   git clone <repository-url> ~/.config/nvim
   ```

2. **Start Neovim** - Plugins will be automatically installed on first launch:

   ```bash
   nvim
   ```

3. **Wait for plugin installation** - The first startup may take a moment as plugins are downloaded.

## Plugin Manager

This configuration uses [mini.deps](https://github.com/nvim-mini/mini.deps), a fast and lightweight plugin manager that:

- Installs plugins automatically on first use
- Supports lazy loading
- Minimal overhead
- No external dependencies

## Plugins

### Git

- **[neogit](https://github.com/NeogitOrg/neogit)** - Magit for Neovim
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git signs in the gutter

### UI & Themes

- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Statusline
- **[catppuccin.nvim](https://github.com/catppuccin/nvim)** - Colorscheme (active)
- **[zenbones.nvim](https://github.com/zenbones-theme/zenbones.nvim)** - Colorscheme (available)
- **[everforest-nvim](https://github.com/neanias/everforest-nvim)** - Colorscheme (available)
- **[nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)** - Color highlighter (disabled)

### Editor Enhancements

- **[mini.trailspace](https://github.com/nvim-mini/mini.trailspace)** - Trailing whitespace management
- **[nvim-tmux-navigation](https://github.com/alexghergh/nvim-tmux-navigation)** - Seamless tmux navigation
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Key binding hints
- **[nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)** - Advanced folding

### Coding

- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting
- **[nvim-surround](https://github.com/kylechui/nvim-surround)** - Surround text objects
- **[visual-surround.nvim](https://github.com/NStefan002/visual-surround.nvim)** - Visual mode surround
- **[mini.splitjoin](https://github.com/nvim-mini/mini.splitjoin)** - Split/join code
- **[blink.cmp](https://github.com/saghen/blink.cmp)** - Completion engine
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configuration
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP/DAP/Linter installer
- **[none-ls.nvim](https://github.com/nvimtools/none-ls.nvim)** - Formatting and linting

### Tools & Utilities

- **[snacks.nvim](https://github.com/folke/snacks.nvim)** - File explorer, picker, and utilities
- **[noice.nvim](https://github.com/folke/noice.nvim)** - UI for messages, cmdline, and popupmenu
- **[sidekick.nvim](https://github.com/folke/sidekick.nvim)** - AI CLI integration (tmux)

## Key Mappings

### Leader Key

- `<leader>` = `<Space>`
- `<localleader>` = `,`

### Snacks (File Management)

- `<leader><leader>` - Smart find
- `<leader>ff` - Find files
- `<leader>fg` - Find git files
- `<leader>e` - File explorer
- `<leader>/` - Grep
- `<leader>0` - Focus Snacks explorer

### Git

- `<leader>gg` - Open Neogit
- `<leader>gs` - Git status
- `<leader>gb` - Git branches
- `<leader>gl` - Git log
- `<leader>gd` - Git diff

### LSP

- `gd` - Go to definition
- `gr` - References
- `gI` - Go to implementation
- `gy` - Go to type definition

### Editor

- `<C-h/j/k/l>` - Navigate between tmux panes and Neovim windows
- `zR` - Open all folds
- `zM` - Close all folds

## Language Support

### Configured LSP Servers

- **Lua**: `lua_ls`
- **Ruby**: `ruby_lsp`
- **TypeScript/JavaScript**: `vtsls`

### Formatters & Linters

- **Stylua** - Lua formatter
- **Prettier** - JavaScript/TypeScript formatter
- **ESLint** - JavaScript linter

## Configuration

### Adding a Plugin

1. Create a new file in `lua/mpa/plugins/`:

   ```lua
   -- lua/mpa/plugins/my-plugin.lua
   Add {
     source = 'user/repo',
   }
   Later(function()
     require('my-plugin').setup {
       -- configuration
     }
   end)
   ```

2. Add it to `lua/mpa/plugins/init.lua`:
   ```lua
   require 'mpa.plugins.my-plugin'
   ```

### Disabling a Plugin

Use `XAdd` instead of `Add` in the plugin file, or comment out the require in `plugins/init.lua`.

### Customizing Options

- **Editor Options**: `lua/mpa/core/options.lua`
- **Key Mappings**: `lua/mpa/core/keymaps.lua`
- **Autocommands**: `lua/mpa/core/autocmds.lua`

## Requirements

- **Neovim** >= 0.9.0 (or latest stable)
- **Git** (for plugin installation)
- **tmux** (optional, for tmux navigation)

## License

This configuration is for personal use. Individual plugins have their own licenses.
