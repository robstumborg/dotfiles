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

	-- refactor
	vim.keymap.set("n", "<leader>rv", vim.lsp.buf.rename, { buffer = buffer })

	-- lsp restart
	vim.keymap.set("n", "<leader>lr", ":LspRestart<cr>", { buffer = buffer })

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
			init_options = {
				globalStoragePath = os.getenv("HOME") .. "/.local/state/intelephense",
			},
			settings = {
				intelephense = {
					environment = {
						phpVersion = 8.3,
					},
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
						"random",
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
require("luasnip").filetype_extend("typescript", { "javascript" })
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
	preselect = cmp.PreselectMode.None,
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local icon = kind_icons[vim_item.kind]
			local text = vim_item.kind
			text = text .. string.rep(" ", 10 - #text)
			text = string.lower(text)

			local source = ({
				nvim_lsp = "lsp",
				luasnip = "luasnip",
				path = "path",
				buffer = "buffer",
				tmux = "tmux",
			})[entry.source.name]

			vim_item.kind = icon
			vim_item.menu = text .. (source and " " .. source or "")

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
	formatting = {
		fields = { "abbr" },
		format = function(entry, vim_item)
			return vim_item
		end,
	},
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	formatting = {
		fields = { "abbr" },
		format = function(entry, vim_item)
			return vim_item
		end,
	},
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
