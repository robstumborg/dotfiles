-- gitsigns
require("gitsigns").setup({
	current_line_blame = true,
	attach_to_untracked = true,
	yadm = {
		enable = true,
	},
	-- _signs_staged_enable = true,
})

require("yadm").setup({})

vim.api.nvim_set_var('fugitive_gitea_domains', {'https://code.stumb.org'})
