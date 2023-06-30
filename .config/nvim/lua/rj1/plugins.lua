local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"olimorris/onedarkpro.nvim",
	-- lsp
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{ "hrsh7th/nvim-cmp", dependencies = "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-path", dependencies = "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-buffer", dependencies = "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help", dependencies = "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-cmdline", dependencies = "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip", dependencies = "saadparwaiz1/cmp_luasnip" },
	"andersevenrud/cmp-tmux",
	"microsoft/python-type-stubs",
	"rafamadriz/friendly-snippets",

	-- codeium
	{
		"Exafunction/codeium.vim",
		config = function()
			vim.keymap.set("i", "<a-l>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<a-]>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<a-[>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<a-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
		end,
	},

	-- syntax / editing
	{ "nvim-treesitter/nvim-treesitter-textobjects", dependencies = "nvim-treesitter/nvim-treesitter" },
	"windwp/nvim-ts-autotag",
	"windwp/nvim-autopairs",
	"mhartington/formatter.nvim",
	"Vimjas/vim-python-pep8-indent",
	"jidn/vim-dbml",
	"b3nj5m1n/kommentary",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"kylechui/nvim-surround",
	"leafOfTree/vim-matchtag",
	"folke/todo-comments.nvim",
	"junegunn/vim-easy-align",
	"mbbill/undotree",
	"jwalton512/vim-blade",
	"NMAC427/guess-indent.nvim",

	-- git
	{ "lewis6991/gitsigns.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

	-- visual
	"olimorris/onedarkpro.nvim",
	{ "nvim-lualine/lualine.nvim", dependencies = "kyazdani42/nvim-web-devicons" },
	{ "noib3/nvim-cokeline", dependencies = "kyazdani42/nvim-web-devicons" },
	{ "nvim-tree/nvim-tree.lua", dependencies = "kyazdani42/nvim-web-devicons" },
	"karb94/neoscroll.nvim",
	{ "iamcco/markdown-preview.nvim", build = ":call mkdp@util#install()" },
	"uga-rosa/ccc.nvim",
	"tversteeg/registers.nvim",
	"jinh0/eyeliner.nvim",

	"lukas-reineke/indent-blankline.nvim",
	"https://github.com/folke/trouble.nvim",

	{ "jakewvincent/mkdnflow.nvim", rocks = "luautf8" },

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},

	-- session management
	{ "jedrzejboczar/possession.nvim", dependencies = "nvim-lua/plenary.nvim" },

	-- tmux integration
	"preservim/vimux",

	-- Rename/Delete/Chmod/etc
	"tpope/vim-eunuch",
})

-- kommentary
require("kommentary.config").configure_language("php", {
	single_line_comment_string = "//",
	multi_line_comment_strings = { "/*", "*/" },
})

-- gitsigns
require("gitsigns").setup({
	current_line_blame = true,
	attach_to_untracked = true,
	yadm = {
		enable = true,
	},
})

-- nvim-surround
require("nvim-surround").setup({})

-- diffview
require("diffview").setup({})

-- nvim-tree
require("nvim-tree").setup({
	on_attach = function(bufnr)
		local api = require("nvim-tree.api")
		api.config.mappings.default_on_attach(bufnr)
		vim.keymap.set("n", "s", "", { buffer = bufnr })
		vim.keymap.del("n", "s", { buffer = bufnr })
	end,

	view = {
		relativenumber = true,
	},
})

-- smooth scrolling
require("neoscroll").setup({
	hide_cursor = false,
	mappings = {
		"<C-u>",
		"<C-d>",
	},
})

-- todo highlighter
require("todo-comments").setup({})

-- registers preview popup
require("registers").setup({})

-- hotreload flutter on save
vim.api.nvim_create_autocmd("bufwritepost", {
	pattern = "*.dart",
	command = "silent execute '!kill -SIGUSR1 $(pgrep -f \"[f]lutter_tool.*run\")'",
})

-- eyeliner (quick-scope lua replacement)
require("eyeliner").setup({
	highlight_on_key = true,
})

require("guess-indent").setup({})
