function Session_name()
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
			local server_address = "/tmp/nvim-" .. name
			if vim.fn.filereadable(server_address) == 1 then
				vim.fn.delete(server_address)
			end
			vim.fn.serverstart(server_address)
		end,
	},
})

local get_sessions = function()
	local sessions = require("possession.query").as_list()
	local new_sessions = {}
	for _, s in pairs(sessions) do
		table.insert(new_sessions, s.name)
	end
	return new_sessions
end

local load_session = function()
	local session = require("possession.session")
	local sessions = get_sessions()
	require("fzf-lua").fzf_exec(sessions, {
		actions = {
			["default"] = {
				function(selected)
					session.close()
					vim.api.nvim_buf_delete(0, { force = true })
					session.load(selected[1])
				end,
			},
		},
	})
end

-- create neovim command for FzfLoadSession
vim.api.nvim_create_user_command("FzfLoadSession", load_session, { nargs = 0 })
