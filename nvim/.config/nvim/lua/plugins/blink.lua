return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  opts = {
    keymap = { preset = 'default' },
    appearance = { nerd_font_variant = 'normal' },
    completion = { documentation = { auto_show = true, auto_show_delay_ms = 300 } },
    sources = {
      default = { 'lsp', 'path', 'snippets',  },
    },
    fuzzy = { implementation = 'lua' },
    signature = { enabled = true },
  },
}
