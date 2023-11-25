-- codeium
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

-- openai
local function fetch_openai_key()
	local handle = io.popen("pass dev/openai.com/openai_key")
	if handle ~= nil then
		local key = string.gsub(handle:read("*a"), "\n", "")
		handle:close()
		return key
	end
end

require("gp").setup({
	openai_api_key = fetch_openai_key(),
	openai_api_endpoint = "https://api.openai.com/v1/chat/completions",
	chat_model = { model = "gpt-3.5-turbo-16k", temperature = 1.1, top_p = 1 },
	chat_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/chatgpt/chats",
	chat_user_prefix = "## prompt",
	chat_assistant_prefix = "## response",
})
