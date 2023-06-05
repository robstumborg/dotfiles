vim.g.codeium_enabled = false
vim.g.codeium_disable_bindings = 1

function Codeium_status()
	local status = vim.fn["codeium#GetStatusString"]()
	status = string.gsub(status, "^%s+", "")
	status = string.lower(status)
	return status
end

-- use <leader>ai to toggle codeium
vim.keymap.set("n", "<leader>ai", function()
	if Codeium_status() == "on" then
		vim.g.codeium_enabled = false
	else
		vim.g.codeium_enabled = true
	end
end, { noremap = true })
