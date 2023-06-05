local function cmp_border(hl_name)
	return {
		{ "🭽", hl_name },
		{ "▔", hl_name },
		{ "🭾", hl_name },
		{ "▕", hl_name },
		{ "🭿", hl_name },
		{ "▁", hl_name },
		{ "🭼", hl_name },
		{ "▏", hl_name },
	}
end

require("ccc").setup({
	bar_char = "󰋘",
	point_char = "󰋙",
	bar_len = 50,
	highlighter = {
		auto_enable = true,
	},
	win_opts = {
		border = cmp_border("CccBorder"),
	},
})
vim.cmd("command! Color CccPick")
vim.keymap.set("n", "<leader>cc", ":Color<CR>", { silent = true })
