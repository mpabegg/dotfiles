local function init()
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>ff', builtin.find_files)
	vim.keymap.set('n', '<leader>pf', builtin.git_files)
	vim.keymap.set('n', '<leader>/', builtin.live_grep)
end

return {
	'nvim-telescope/telescope.nvim', tag = '0.1.0',
	-- or                            , branch = '0.1.x',
	dependencies = { {'nvim-lua/plenary.nvim'} },
	init = init,
}
