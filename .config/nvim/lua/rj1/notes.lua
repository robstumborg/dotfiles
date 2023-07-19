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

function Daily_status()
	if vim.fn.filereadable(daily_file()) == 1 then
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
