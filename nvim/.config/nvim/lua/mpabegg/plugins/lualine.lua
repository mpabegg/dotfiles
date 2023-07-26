return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local icons = require("mpabegg.icons")
    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        -- lualine_a = { { "mode", fmt = function(str) return str:sub(1,1) end } },
        lualine_a = { { "branch", color = { gui = "italic" } }, },
        lualine_b = {
          { "diff", symbols = icons.git, },
          { "filename", path = 1, symbols = { modified = icons.file.modified, readonly = "", unnamed = "" } },
        },
        lualine_c = {
          {
            function() return require("nvim-navic").get_location() end,
            cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
          },
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          {
            function()
              local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }

              -- local buf_ft = vim.bo.filetype
              local buf_client_names = {}

              -- add client
              for _, client in pairs(buf_clients) do
                if client.name ~= "null-ls" then
                  table.insert(buf_client_names, client.name)
                end
              end

              -- local s = require "null-ls.sources"
              -- local supported_formatters = table.sort(sources.get_supported(buf_ft, "formatting"))
              -- local supported_linters = table.sort(sources.get_supported(buf_ft, "diagnostics"))

              -- vim.list_extend(buf_client_names, supported_formatters)
              -- vim.list_extend(buf_client_names, supported_linters)
              --
              local unique_client_names = table.concat(buf_client_names, ", ")
              local language_servers = string.format("[%s]", unique_client_names)

              return language_servers
            end,
            cond = function ()
              local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }
              return #buf_clients ~= 0
            end,
            color = { gui = "bold" },
            separator = "",
          },
          {
            function()
              local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
              return icons.ui.tab .. " " .. shiftwidth
            end,
            padding = 1,
          },
        },
        lualine_y = {
          { "filetype", icon_only = false, separator = "",  padding = { left = 1, right = 2 } },
        },
        lualine_z = {
          { "fileformat", padding = { left = 1, right = 2} },
        },

      },
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
