local colors = require("onedarkpro.helpers").get_colors()

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
