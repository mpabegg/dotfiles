return {
	{
		'VonHeikemen/lsp-zero.nvim',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'}, -- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
			{"folke/neodev.nvim"},
		},
		init = function()
			require("neodev").setup()

			local lsp = require('lsp-zero')
			lsp.preset('recommended')
	                lsp.ensure_installed({
				"sumneko_lua", "solargraph", "elixirls", "tsserver"
			})
			lsp.setup()

			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			lsp.setup_nvim_cmp({
				mapping = lsp.defaults.cmp_mappings({
					["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({select=true}),
					["<C-space>"] = cmp.mapping.complete({}),
				})
			})

			lsp.on_attach(function(client, bufnr)
				local opts = { buffer = bufnr }
				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
			end)
		end
	},
	{
		'j-hui/fidget.nvim',
		init = function ()
			require"fidget".setup{}
		end
	}
}
