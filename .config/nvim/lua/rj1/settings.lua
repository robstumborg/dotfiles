local color = require("onedarkpro.helpers")
require("onedarkpro").setup({
	options = {
		cursorline = true,
		bold = false,
		italic = false,
		transparency = true,
	},
	highlights = {
		Comment = { fg = color.lighten("comment", 15, "onedark") },
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

-- open tmux panes in nvim's cwd
vim.api.nvim_create_autocmd("dirchanged", {
	pattern = "*",
	command = 'call chansend(v:stderr, printf("\\033]7;%s\\033", v:event.cwd))',
})

-- toggle relative line numbers when entering/leaving splits
local splitswitch = vim.api.nvim_create_augroup("splitswitch", { clear = true })

vim.api.nvim_create_autocmd("WinEnter", {
	group = splitswitch,
	pattern = "*",
	callback = function()
		vim.opt.relativenumber = true
	end,
})

vim.api.nvim_create_autocmd("WinLeave", {
	group = splitswitch,
	pattern = "*",
	callback = function()
		vim.opt.relativenumber = false
		vim.opt.number = true
	end,
})
