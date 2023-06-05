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
			return vim.fn.serverstart("/tmp/nvim-" .. name)
		end,
	},
})
