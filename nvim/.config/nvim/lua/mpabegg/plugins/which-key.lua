return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local wk = require("which-key")
		wk.register({
			b = {
				b = { require("telescope.builtin").buffers, "List Buffers" },
			},
			f = {
				name = "+file",
				b = { "<cmd>Telescope file_browser<cr>", "File Browser" },
				f = { "<cmd>Telescope find_files<cr>", "Find File" },
				r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
			},
			w = {
				name = "+window",
				s = { "<C-w>s", "Split Below" },
				v = { "<C-w>v", "Split to the Right" },
				h = { "<C-w>h", "Focus Left" },
				l = { "<C-w>l", "Focus Right" },
			},
			["/"] = { "<cmd>Telescope live_grep<cr>", "Search Project" },
			["*"] = { "<cmd>Telescope grep_string<cr>", "Find Word" },
			["U"] = { vim.cmd.UndotreeToggle, "Undo Tree" },
		}, { prefix = "<leader>" })
	end,
}
