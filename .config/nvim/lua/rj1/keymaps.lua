local wk = require("which-key")
wk.register()

vim.cmd([[
noremap n h|        "move Left
noremap e gj|       "move Down
noremap i gk|       "move Up
noremap o l|        "move Right
noremap t i|        "(t)ype           replaces (i)nsert
noremap T I|        "(T)ype at bol    replaces (I)nsert
noremap E e|        "end of word      replaces (e)nd
noremap h n|        "next match       replaces (n)ext
noremap k N|        "previous match   replaces (N) prev
noremap <C-m> m|    "mark             replaces (m)ark
noremap l o|
noremap L O|
nnoremap cl cl|
nnoremap ci ci|
nnoremap di di|
nnoremap vi vi|
nnoremap yi yi|
nnoremap ct ct|
nnoremap dt dt|
nnoremap vt vt|
nnoremap yt yt|
]])

-- buffer navigation
vim.keymap.set("n", "<c-i>", "<plug>(cokeline-focus-next)", { silent = true })
vim.keymap.set("n", "<c-e>", "<plug>(cokeline-focus-prev)", { silent = true })
vim.keymap.set("n", "<c-w>", ":bd!<cr>", { silent = true })

-- new file, save file
vim.keymap.set("n", "<c-n>", ":enew<cr>", { silent = true })
vim.keymap.set("n", "<c-s>", ":update<cr>", { silent = true })

-- splits
vim.keymap.set("n", "ss", ":split<cr>", { silent = true })
vim.keymap.set("n", "sv", ":vsplit<cr>", { silent = true })
vim.keymap.set("n", "sc", ":close<cr>", { silent = true })
vim.keymap.set("n", "sn", "<c-w>h", { silent = true })
vim.keymap.set("n", "se", "<c-w>j", { silent = true })
vim.keymap.set("n", "si", "<c-w>k", { silent = true })
vim.keymap.set("n", "so", "<c-w>l", { silent = true })

-- don't let fugitive remap our s key so wo maintain our split navigation
vim.api.nvim_create_autocmd("FileType", {
	pattern = "fugitive",
	callback = function()
		vim.keymap.set("n", "s", "", { buffer = true, silent = true })
	end,
})

-- deal w/ word wrap (treat wrapped lines as their own)
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- toggle highlight
vim.keymap.set("n", "<Left>", ":set hls!<cr>", { silent = true })

-- toggle file explorer
vim.keymap.set("n", "<c-b>", ":NvimTreeToggle<cr>")

-- toggle highlight
vim.keymap.set("n", "<a-z>", ":set wrap!<cr>", { silent = true })

-- telescope
vim.keymap.set("n", "<c-p>", ":Telescope find_files<cr>")
vim.keymap.set("n", "<c-f>", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<c-h>", ":Telescope buffers<cr>")
vim.keymap.set("n", "<leader>s", ":Telescope possession list<cr>")

-- markdown preview
vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<cr>")

-- colorcolumn toggle
vim.keymap.set("n", "<a-c>", function()
	vim.o.colorcolumn = (vim.o.colorcolumn == "") and "80" or (vim.o.colorcolumn == "80") and "120" or ""
end)

-- format buffer w/ formatter.nvim
vim.keymap.set("n", "<leader>ff", ":Format<cr>")

-- format selection w/ formatter.nvim
vim.keymap.set("v", "<leader>ff", ":Format<cr>")

-- place filepath in clipboard
vim.keymap.set('n', '<leader>fp', "<cmd>let @+ = expand('%')<cr>", {noremap = true, silent = true})

-- git
vim.keymap.set("n", "<leader>gg", ":Git<cr>", { desc = "git: fugitive interface" })
vim.keymap.set("n", "<leader>gaf", ":Gitsigns stage_buffer<cr>", { desc = "git: stage this entire buffer" })
vim.keymap.set("n", "<leader>grf", ":Gitsigns reset_buffer<cr>", { desc = "git: reset buffer" })
vim.keymap.set({ "n", "v" }, "<leader>gah", ":Gitsigns stage_hunk<cr>", { desc = "git: stage this hunk" })
vim.keymap.set({ "n", "v" }, "<leader>guh", ":Gitsigns undo_stage_hunk<cr>", { desc = "git: undo stage this hunk" })
vim.keymap.set({ "n", "v" }, "<leader>grh", ":Gitsigns reset_hunk<cr>", { desc = "git: reset this hunk" })
vim.keymap.set("n", "<leader>gph", ":Gitsigns preview_hunk<cr>", { desc = "git: preview this hunk" })
vim.keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<cr>", { desc = "git: browse to next hunk" })
vim.keymap.set("n", "<leader>gp", ":Gitsigns prev_hunk<cr>", { desc = "git: browse to previous hunk" })

-- vimux
vim.keymap.set("n", "<leader>tt", ":VimuxTogglePane<cr>", { silent = true })

-- vimux executors
vim.keymap.set("n", "<leader>tr", ':echo "can\'t execute this file"<cr>', { desc = "vimux: run this file" })
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
end, { desc = "vimux: execute visual selection as shell command" })

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

-- bind :W to :write
vim.api.nvim_create_user_command("W", "write", {})

vim.keymap.set({ "n", "x", "o" }, "H", "0", { silent = true })
vim.keymap.set({ "n", "x", "o" }, "L", "$", { silent = true })

-- keymap to toggle between relative and absolute line numbers
vim.keymap.set("n", "<c-l>", function()
	if vim.o.relativenumber == true then
		vim.wo.relativenumber = false
	else
		vim.wo.relativenumber = true
	end
end)

-- angular file switching
vim.api.nvim_create_autocmd("FileType", {
	pattern = "html",
	callback = function()
		vim.keymap.set("n", "<leader>ngc", ":e %<.ts<cr>", { desc = "angular: switch to component", buffer = true, silent = true })
		vim.keymap.set("n", "<leader>ngs", ":e %<.scss<cr>", { desc = "angular: switch to stylesheet", buffer = true, silent = true })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "typescript",
	callback = function()
		vim.keymap.set("n", "<leader>ngt", ":e %<.html<cr>", { desc = "angular: switch to template", buffer = true, silent = true })
		vim.keymap.set("n", "<leader>ngs", ":e %<.scss<cr>", { desc = "angular: switch to stylesheet", buffer = true, silent = true })
	end,
})

-- openai
vim.keymap.set("n", "<leader>an", ":GpChatNew<cr>", { desc = "gpt: new chat buffer" })
vim.keymap.set("n", "<leader>ap", ":GpChatToggle<cr>", { desc = "gpt: chat popup" })
vim.keymap.set("n", "<leader>as", ":GpChatRespond<cr>", { desc = "gpt: send message" })

vim.keymap.set("v", "<leader>an", ":<C-u>'<,'>GpChatNew<cr>", { desc =  "gpt: new chat buffer" })
vim.keymap.set("v", "<leader>ap", ":<C-u>'<,'>GpChatPaste<cr>", { desc = "gpt: chat paste" })
vim.keymap.set("v", "<leader>ar", ":<C-u>'<,'>GpRewrite<cr>", { desc = "gpt: rewrite selection" })
