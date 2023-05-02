-- leader
vim.g.mapleader = " "

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

--
-- settings
--
-- color scheme
require("onedarkpro").setup({
	options = {
		cursorline = true,
		bold = false,
		italic = false,
		transparency = true,
	},
})
vim.o.termguicolors = true
vim.cmd("colorscheme onedark")

-- disable start message
vim.o.shortmess = "I"

-- relative line numbers
vim.wo.relativenumber = true

-- mouse mode
vim.o.mouse = "a"

-- break indent
vim.o.breakindent = true

-- undo history
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("state") .. "/undo"

-- search settings
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true

-- quick update time
vim.o.updatetime = 100
vim.wo.signcolumn = "yes"

-- use system clipboard
vim.o.clipboard = "unnamedplus"

-- set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- indenting
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- word wrap
vim.wo.wrap = false

-- backup
vim.opt.backup = false
vim.opt.writebackup = false

-- textwidth
-- vim.o.textwidth = 80
local textwidth = vim.api.nvim_create_augroup("textwidth", { clear = true })
vim.api.nvim_create_autocmd("filetype", {
	group = textwidth,
	pattern = { "html" },
	callback = function()
		vim.o.textwidth = 120
	end,
})

-- vimux
vim.g.vimuxheight = 32

-- codeium
vim.g.codeium_enabled = false
vim.g.codeium_disable_bindings = 1

local function codeium_status()
	local status = vim.fn["codeium#GetStatusString"]()
	status = string.gsub(status, "^%s+", "")
	status = string.lower(status)
	return status
end

-- use <leader>ai to toggle codeium
vim.keymap.set("n", "<leader>ai", function()
	if codeium_status() == "on" then
		vim.g.codeium_enabled = false
	else
		vim.g.codeium_enabled = true
	end
end, { noremap = true })

-- notes
local notes_dir = vim.fn.expand("$HOME/notes")
vim.api.nvim_create_autocmd({ "bufenter", "bufleave" }, {
	pattern = { notes_dir .. "/**/*.md" },
	command = "setl noswapfile noundofile nobackup viminfo=",
})

require("mkdnflow").setup({
	perspective = {
		priority = "current",
	},
	links = {
		transform_explicit = function(text)
			text = text:gsub(" ", "-")
			text = text:lower()
			return text
		end,
	},
})

local function daily_file()
	local date_string = os.date("%Y-%m-%d")
	local dir = vim.fn.expand(notes_dir .. "/daily/")
	return dir .. date_string .. ".md"
end

-- create daily journal entry command
vim.api.nvim_create_user_command("Today", function()
	local file_path = daily_file()
	local f = io.open(file_path, "r")
	if f ~= nil then
		f:close()
	else
		local dir = vim.fn.expand(notes_dir .. "/daily/")
		local template = io.open(dir .. "template.md", "r")
		if template == nil then
			vim.cmd("echo 'no daily template found in " .. dir .. "'")
			return
		end
		local template_content = template:read("*all")
		template:close()
		local new_file = io.open(file_path, "w")
		if new_file ~= nil then
			new_file:write("# " .. os.date("%Y-%m-%d") .. "\n\n")
			new_file:write(template_content)
			new_file:close()
		end
	end
	vim.cmd("edit " .. file_path)
end, {})

vim.api.nvim_create_user_command("Yesterday", function()
	local date_string = os.date("%Y-%m-%d", os.time() - 86400)
	local file_path = vim.fn.expand(notes_dir .. "/daily/" .. date_string .. ".md")
	if vim.fn.filereadable(file_path) == 1 then
		vim.cmd("edit " .. file_path)
	else
		vim.cmd("echo 'no daily entry for " .. date_string .. "'")
	end
end, {})

local function daily_status()
	if vim.fn.filereadable(daily_file()) == 1 then
		return ""
	else
		return "pending"
	end
end

--
-- keymaps (these should be set before plugins are initialized)
--
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- buffer navigation
vim.keymap.set("n", "<c-k>", "<plug>(cokeline-focus-next)", { silent = true })
vim.keymap.set("n", "<c-j>", "<plug>(cokeline-focus-prev)", { silent = true })
vim.keymap.set("n", "<c-w>", ":bd!<cr>", { silent = true })

-- new file, save file
vim.keymap.set("n", "<c-n>", ":enew<cr>", { silent = true })
vim.keymap.set("n", "<c-s>", ":update<cr>", { silent = true })

-- splits
vim.keymap.set("n", "ss", ":split<cr>", { silent = true })
vim.keymap.set("n", "sv", ":vsplit<cr>", { silent = true })
vim.keymap.set("n", "sc", ":close<cr>", { silent = true })
vim.keymap.set("n", "sh", "<c-w>h", { silent = true })
vim.keymap.set("n", "sj", "<c-w>j", { silent = true })
vim.keymap.set("n", "sk", "<c-w>k", { silent = true })
vim.keymap.set("n", "sl", "<c-w>l", { silent = true })

-- deal w/ word wrap (treat wrapped lines as their own)
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- toggle highlight
vim.keymap.set("n", "<a-h>", ":set hls!<cr>", { silent = true })

-- toggle file explorer
vim.keymap.set("n", "<c-b>", ":NvimTreeToggle<cr>")

-- toggle hightlight
vim.keymap.set("n", "<a-z>", ":set wrap!<cr>", { silent = true })

-- find files
vim.keymap.set("n", "<c-p>", ":Telescope find_files<cr>")

-- find in files
vim.keymap.set("n", "<c-f>", ":Telescope live_grep<cr>")

-- switch buffers via telescope
vim.keymap.set("n", "<c-h>", ":Telescope buffers<cr>")

-- session switcher
vim.keymap.set("n", "<leader>s", ":Telescope possession list<cr>")

-- markdown preview
vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<cr>")

-- colorcolumn toggle
vim.keymap.set("n", "<a-c>", function()
	if vim.o.colorcolumn == "" then
		vim.o.colorcolumn = "80"
	elseif vim.o.colorcolumn == "80" then
		vim.o.colorcolumn = "120"
	else
		vim.o.colorcolumn = ""
	end
end)

-- format buffer w/ formatter.nvim
vim.keymap.set("n", "<leader>ff", ":Format<cr>")

-- preview git hunk
vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<cr>")

-- vimux
vim.keymap.set("n", "<leader>tt", ":VimuxTogglePane<cr>", { silent = true })

-- vimux executors
vim.keymap.set("n", "<leader>tr", ':echo "can\'t execute this file"<cr>')
vim.api.nvim_create_augroup("vimux", { clear = true })
local vimuxtable = {
	["php"] = "php",
	["python"] = "python",
	["go"] = "go run",
	["sh"] = "bash",
	["javascript"] = "node",
	["typescript"] = "node",
	["rust"] = "rust-script",
}
for ft, exec in pairs(vimuxtable) do
	vim.api.nvim_create_autocmd("filetype", {
		group = "vimux",
		pattern = ft,
		callback = function()
			vim.api.nvim_buf_set_keymap(
				0,
				"n",
				"<leader>tr",
				':VimuxRunCommand "' .. exec .. " " .. vim.fn.expand("%:p") .. '"<cr>',
				{ noremap = true }
			)
		end,
	})
end

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- send visual selections as commands to execute in tmux pane
-- todo: turn this into lua, C-U wouldn't work w/ keymap.set for some reason
-- You can add range = true in the options argument of nvim_create_user_command, it will avoid an error if the user leaves the range in the command.
--

vim.cmd([[
vn <silent> <leader>ts :<C-U>VimuxRunCommand(VisualSelection())<cr>
function! VisualSelection()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction]])

-- send entire current line as command to execute in tmux pane, if line ends in \ then send next line too
vim.keymap.set("n", "<leader>tl", function()
	local line = vim.fn.getline(".")
	vim.cmd("VimuxRunCommand '" .. line .. "'")
end)

-- todo
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end)
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end)

-- find digit

vim.keymap.set("n", "<leader>fd", function()
	vim.fn.search("\\d\\+")
end)

-- trouble.nvim
vim.keymap.set("n", "<leader>dw", "<cmd>TroubleToggle workspace_diagnostics<cr>")

--
-- load plugins
--

-- session management
local function session_name()
	return require("possession.session").session_name or "no session"
end

require("possession").setup({
	session_dir = vim.fn.stdpath("state") .. "/session",
	plugins = {
		delete_hidden_buffers = false,
	},
	autosave = {
		current = true,
	},
	silent = true,
	commands = {
		save = "SaveSession",
		load = "LoadSession",
	},
	hooks = {
		-- rename the tmux window to the name of the session we're loading
		before_load = function(name)
			return vim.fn.system("tmux rename-window " .. name)
		end,
		after_load = function(name)
			return vim.fn.serverstart("/tmp/nvim-" .. name)
		end,
	},
})

local colors = require("onedarkpro.helpers").get_colors()

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local function random_icon()
	local symbols = { "󰊠", "󰊮", "󰣐", "󰊓", "󰊔", "󰇥" }
	local randomIndex = math.random(1, #symbols)
	return symbols[randomIndex]
end

local function lsp_servers()
	local servers = {}
	for _, server in pairs(vim.lsp.buf_get_clients()) do
		table.insert(servers, server.name)
	end
	return table.concat(servers, ", ")
end

-- lualine
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "onedark",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = { "NvimTree" },
	},
	sections = {
		lualine_a = {
			{
				"mode",
				-- 󰊠
				icon = random_icon(),
				color = { gui = "bold" },
				fmt = string.lower,
			},
		},
		lualine_c = {
			{
				"branch",
				color = { fg = colors.fg },
			},
			{
				"diff",
				source = diff_source,
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.yellow },
					removed = { fg = colors.red },
				},
				symbols = { added = " ", modified = "󱋮 ", removed = " " },
			},
			{
				"diagnostics",
				symbols = {
					error = "󰅗 ",
					warn = "󰅉 ",
					info = "󰅍 ",
					hint = "󰌵 ",
				},
			},
			{
				lsp_servers,
				icon = "",

				color = function()
					if vim.lsp.util.get_progress_messages()[1] then
						return { fg = colors.red }
					end
					return { fg = colors.purple }
				end,
			},
			{
				codeium_status,
				icon = "󰧑 ai:",

				color = function()
					if codeium_status() == "on" then
						return { fg = colors.green }
					else
						return { fg = colors.red }
					end
				end,
			},
		},
		lualine_b = {
			{
				session_name,
				icon = "ⵢ",
				color = { fg = colors.fg },
			},
		},
		lualine_x = {
			{
				daily_status,
				icon = "daily:",
			},
			{
				"encoding",
			},
			{
				"fileformat",
			},
			{
				"filetype",
			},
		},
		lualine_y = { { "progress", color = { fg = colors.fg }, fmt = string.lower } },
	},
})

-- cokeline
require("cokeline").setup({
	default_hl = {
		fg = function(buffer)
			if buffer.is_modified then
				return colors.blue
			else
				return buffer.is_focused and colors.purple or colors.white
			end
		end,
		bg = colors.black,
		style = function(buffer)
			return buffer.is_focused and "bold" or nil
		end,
	},
	sidebar = {
		filetype = "NvimTree",
		components = {
			{
				text = "  nvim-tree",
				fg = colors.purple,
				bg = colors.black,
				style = "bold",
			},
		},
	},

	components = {
		{ text = " " },
		{
			text = function(buffer)
				return (buffer.index ~= 1) and "" or ""
			end,
		},
		{ text = " " },
		{
			text = function(buffer)
				return buffer.devicon.icon
			end,
			fg = function(buffer)
				return buffer.devicon.color
			end,
		},
		{ text = " " },
		{
			text = function(buffer)
				return buffer.unique_prefix
			end,
			style = "italic",
			fg = function(buffer)
				if buffer.is_focused and buffer.is_modified then
					return colors.blue
				elseif buffer.is_focused then
					return colors.purple
				else
					return colors.gray
				end
			end,
		},
		{
			text = function(buffer)
				return buffer.filename .. "  "
			end,
			style = function(buffer)
				return buffer.is_focused and "bold" or nil
			end,
		},
		{
			text = function(buffer)
				-- don't show separator on the last tab
				if buffer.index < #vim.fn.getbufinfo({ buflisted = 1 }) then
					return ""
				else
					return ""
				end
			end,
			fg = colors.white,
			style = "bold",
		},
	},
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

-- telescope
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

-- treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"go",
		"python",
		"tsx",
		"php",
		"html",
		"css",
		"javascript",
		"dart",
	},
	highlight = {
		enable = true,
		disable = { "html" },
	},
	indent = {
		enable = true,
		disable = { "html", "python" },
	},
	autotag = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

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
vim.cmd("command! Diff DiffviewOpen")

-- smooth scrolling
require("neoscroll").setup({
	hide_cursor = false,
	mappings = {
		"<C-u>",
		"<C-d>",
	},
})

--
-- lsp settings
--

-- set lsp diagnostic icons for gutter
local signs = { Error = "󰅗 ", Warn = "󰅉 ", Information = "󰅍 ", Hint = "󰌵 " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- this runs when a buffer is using an lsp
local border = {
	{ "🭽", "FloatBorder" },
	{ "▔", "FloatBorder" },
	{ "🭾", "FloatBorder" },
	{ "▕", "FloatBorder" },
	{ "🭿", "FloatBorder" },
	{ "▁", "FloatBorder" },
	{ "🭼", "FloatBorder" },
	{ "▏", "FloatBorder" },
}
local on_attach = function(_, buffer)
	-- goto definition
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buffer })

	-- references
	vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = buffer })

	-- hover code signature
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer })

	-- diagnostic keymaps
	vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { buffer = buffer })
	vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { buffer = buffer })

	-- disable inline error messages
	vim.diagnostic.config({ virtual_text = false })
end

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- setup mason so it can manage installing lsps for us
require("mason").setup()

local nvim_lsp = require("lspconfig")
local lspconfig = require("mason-lspconfig")

-- manual lsp configuration (not available via mason)
nvim_lsp["dartls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- tell mason to ensure these language servers are installed
lspconfig.setup({
	ensure_installed = {
		"pyright",
		"tsserver",
		"eslint",
		"intelephense",
		"cssls",
		"html",
		"emmet_ls",
		"vuels",
		"lua_ls",
	},
})

-- this configures all language servers installed via mason
-- we can define optional settings for each one here if desired
lspconfig.setup_handlers({
	function(server_name)
		nvim_lsp[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
	-- lua language server settings
	["lua_ls"] = function()
		nvim_lsp.lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			root_dir = function()
				return vim.loop.cwd()
			end,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
	-- javascript language server settings
	["tsserver"] = function()
		nvim_lsp.tsserver.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			root_dir = function()
				return vim.loop.cwd()
			end,
			init_options = {
				preferences = {
					disableSuggestions = true,
				},
			},
		})
	end,
	-- php language server settings
	["intelephense"] = function()
		nvim_lsp.intelephense.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				intelephense = {
					stubs = {
						"apache",
						"bcmath",
						"bz2",
						"calendar",
						"com_dotnet",
						"Core",
						"ctype",
						"curl",
						"date",
						"dba",
						"dom",
						"enchant",
						"exif",
						"FFI",
						"fileinfo",
						"filter",
						"fpm",
						"ftp",
						"gd",
						"gettext",
						"gmp",
						"hash",
						"iconv",
						"imap",
						"imagick",
						"intl",
						"json",
						"ldap",
						"libxml",
						"mbstring",
						"meta",
						"mysqli",
						"oci8",
						"odbc",
						"openssl",
						"pcntl",
						"pcre",
						"PDO",
						"pdo_ibm",
						"pdo_mysql",
						"pdo_pgsql",
						"pdo_sqlite",
						"pgsql",
						"Phar",
						"posix",
						"pspell",
						"readline",
						"Reflection",
						"session",
						"shmop",
						"SimpleXML",
						"snmp",
						"soap",
						"sockets",
						"sodium",
						"SPL",
						"sqlite3",
						"standard",
						"superglobals",
						"sysvmsg",
						"sysvsem",
						"sysvshm",
						"tidy",
						"tokenizer",
						"xml",
						"xmlreader",
						"xmlrpc",
						"xmlwriter",
						"xsl",
						"Zend OPcache",
						"zip",
						"zlib",
						"wordpress",
					},
					environment = {
						phpVersion = 8.1,
					},
				},
			},
		})
	end,
	-- python language server settings
	["pyright"] = function()
		nvim_lsp.pyright.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "off",
					},
				},
			},
			before_init = function(_, config)
				local stubPath = vim.fn.stdpath("data") .. "lazy" .. "python-type-stubs"
				config.settings.python.analysis.stubPath = stubPath
			end,
		})
	end,
	-- html language server settings
	["html"] = function()
		nvim_lsp.html.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				css = {
					lint = {
						validProperties = {},
					},
				},
			},
		})
	end,
	-- rust language server settings
	["rust_analyzer"] = function()
		nvim_lsp.rust_analyzer.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
})

local kind_icons = {
	Text = "",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰇽",
	Variable = "󰂡",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰅲",
}

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").filetype_extend("javascript", { "javascriptreact" })
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
	preselect = cmp.PreselectMode.None,
	formatting = {
		format = function(entry, vim_item)
			local display_kind = string.lower(vim_item.kind)
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], display_kind)
			vim_item.menu = ({
				nvim_lsp = "[lsp]",
				luasnip = "[luasnip]",
				path = "[path]",
				buffer = "[buffer]",
				tmux = "[tmux]",
			})[entry.source.name]
			return vim_item
		end,
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<c-u>"] = cmp.mapping.scroll_docs(-4),
		["<c-d>"] = cmp.mapping.scroll_docs(4),
		["<c-space>"] = cmp.mapping.complete({ reason = cmp.ContextReason.Auto }),
		["<cr>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
		["<tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<s-tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "tmux" },
	},
	window = {
		completion = {
			border = cmp_border("CmpBorder"),
			winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
		},
		documentation = {
			border = cmp_border("CmpBorder"),
			winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
		},
	},
})

-- `/` cmdline setup.
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})

-- autopairs
require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt", "vim" },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- code formatter
require("formatter").setup({
	filetype = {
		html = { require("formatter.filetypes.html").prettier },
		css = { require("formatter.filetypes.css").prettier },
		javascript = { require("formatter.filetypes.javascript").prettier },
		typescript = { require("formatter.filetypes.typescript").prettier },
		python = { require("formatter.filetypes.python").black },
		rust = { require("formatter.filetypes.rust").rustfmt },
		sh = { require("formatter.filetypes.sh").shfmt },
		go = { require("formatter.filetypes.go").gofmt },
		json = { require("formatter.filetypes.json").jq },
		php = { require("formatter.filetypes.php").phpcbf },
		lua = { require("formatter.filetypes.lua").stylua },
		markdown = { require("formatter.filetypes.markdown").prettier },
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

-- copilot
vim.api.nvim_create_user_command("CopilotToggle", function()
	require("copilot").setup({
		suggestion = {
			enabled = true,
			auto_trigger = true,
		},
		filetypes = {
			mail = false,
			yaml = false,
			markdown = true,
			help = false,
			gitcommit = false,
			gitrebase = false,
			hgcommit = false,
			svn = false,
			cvs = false,
			["."] = false,
		},
	})
end, {})

-- enable copilot with <leader>cp
vim.api.nvim_set_keymap("n", "<leader>cp", ":CopilotToggle<CR>", { noremap = true, silent = true })

-- eyeliner (quick-scope lua replacement)
require("eyeliner").setup({
	highlight_on_key = true,
})

-- open tmux panes in nvim's cwd
vim.api.nvim_create_autocmd("dirchanged", {
	pattern = "*",
	command = 'call chansend(v:stderr, printf("\\033]7;%s\\033", v:event.cwd))',
})
