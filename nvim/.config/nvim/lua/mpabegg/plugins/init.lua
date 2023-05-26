return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		init = function()
			require("catppuccin").setup({ flavour = "frappe" })
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	{
		"alexghergh/nvim-tmux-navigation",
		config = {
			disable_when_zoomed = true,
			keybindings = {
				left = "<C-h>",
				down = "<C-j>",
				up = "<C-k>",
				right = "<C-l>",
			},
		},
	},

	"mbbill/undotree",
	"tpope/vim-sleuth",
	"tpope/vim-surround",
}
