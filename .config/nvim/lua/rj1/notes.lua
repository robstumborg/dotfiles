local notes_dir = vim.fn.expand("$HOME/notes")
local work_notes_dir = vim.fn.expand("$HOME/notes/work")
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

-- create daily journal entry command
local function daily_file(directory)
	local date_string = os.date("%Y-%m-%d")
	local dir = vim.fn.expand(directory .. "/daily/")
	return dir .. date_string .. ".md"
end

local function create_or_open_file(directory, template_path)
	local file_path = daily_file(directory)
	local f = io.open(file_path, "r")
	if f ~= nil then
		f:close()
	else
		local dir = vim.fn.expand(directory .. "/daily/")
		local template = io.open(dir .. template_path, "r")
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
end

-- create daily journal entry command
vim.api.nvim_create_user_command("Today", function()
	create_or_open_file(notes_dir, "template.md")
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

vim.api.nvim_create_user_command("WorkToday", function()
	create_or_open_file(work_notes_dir, "template.md")
end, {})

vim.api.nvim_create_user_command("WorkYesterday", function()
	local date_string = os.date("%Y-%m-%d", os.time() - 86400)
	local file_path = vim.fn.expand(work_notes_dir .. "/daily/" .. date_string .. ".md")
	if vim.fn.filereadable(file_path) == 1 then
		vim.cmd("edit " .. file_path)
	else
		vim.cmd("echo 'no daily entry for " .. date_string .. "'")
	end
end, {})

function Daily_status(directory)
	if vim.fn.filereadable(daily_file(directory)) == 1 then
		return ""
	else
		return "pending"
	end
end

vim.api.nvim_create_user_command("QuickNote", function(opts)
	local note = opts.args or nil
	local file_path = vim.fn.expand(notes_dir .. "/quick-notes.md")
	local f = io.open(file_path, "a")
	if f ~= nil then
		f:write("\n\n" .. note .. "\n\n")
		f:close()
	end
end, { nargs = "?" })
