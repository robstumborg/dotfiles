require("telescope").setup({
	pickers = {
		find_files = {
			previewer = false,
			hidden = true,
			file_ignore_patterns = { ".git/" },
		},
		buffers = {
			previewer = false,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
	defaults = {
		borderchars = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
		prompt_prefix = " 󰍉 ",
		entry_prefix = "   ",
		selection_caret = " 󰅂 ",
		layout_config = {
			width = 0.8,
			height = 0.5,
		},
		mappings = {
			i = {
				-- close telescope by pressing esc only once
				["<esc>"] = require("telescope.actions").close,
				["<c-j>"] = require("telescope.actions").move_selection_next,
				["<c-k>"] = require("telescope.actions").move_selection_previous,
				["<c-u>"] = false,
				["<c-d>"] = false,
			},
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("possession")
