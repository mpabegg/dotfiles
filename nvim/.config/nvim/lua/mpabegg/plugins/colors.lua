return {
	{
		"catppuccin/nvim", 
		name = "catppuccin",
		init = function()
			vim.cmd.colorscheme 'catppuccin-frappe'
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = vim.cmd.TSUpdate,
		init = function()
			require('nvim-treesitter.configs').setup ({
				ensure_installed = {  "help",  "query", "ruby", "lua", "javascript", "typescript", "elixir" },
			})
		end
	},
	'nvim-treesitter/playground'
}
