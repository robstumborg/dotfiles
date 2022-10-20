--
-- install packer
--
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

--
-- define our plugins
--
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
  use 'b3nj5m1n/kommentary'
  use 'nvim-treesitter/nvim-treesitter'
  use {'nvim-treesitter/nvim-treesitter-textobjects', after = {'nvim-treesitter'}}
  use 'windwp/nvim-ts-autotag'
  use 'windwp/nvim-autopairs'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use {'hrsh7th/nvim-cmp', requires = {'hrsh7th/cmp-nvim-lsp'}}
  use {'L3MON4D3/LuaSnip', requires = {'saadparwaiz1/cmp_luasnip'}}
  use 'olimorris/onedarkpro.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'akinsho/bufferline.nvim'
  use 'tpope/vim-sleuth'
  use {'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = {'nvim-lua/plenary.nvim'}}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1}
  use {'jedrzejboczar/possession.nvim', requires = {'nvim-lua/plenary.nvim'}}
  use 'norcalli/nvim-colorizer.lua'

  if is_bootstrap then
    require('packer').sync()
  end
end)

if is_bootstrap then
  print '=================================='
  print '    plugins are being installed'
  print '    wait until packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', {clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})


--
-- settings
--

-- highlight on search
vim.o.hlsearch = false

-- relative line numbers
vim.wo.relativenumber = true

-- mouse mode
vim.o.mouse = 'a'

-- break indent
vim.o.breakindent = true

-- undo history
vim.o.undofile = true

-- case insensitive searching unless /c or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- quick update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- set colorscheme
vim.o.termguicolors = true
vim.cmd('colorscheme onedarkpro')

-- use system clipboard
vim.o.clipboard = 'unnamedplus'

-- set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'


--
-- keymaps (these should be set before plugins are initialized)
--

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- buffer navigation
vim.keymap.set('n', '<c-k>', ':bn!<cr>', {silent = true})
vim.keymap.set('n', '<c-j>', ':bp!<cr>', {silent = true})
vim.keymap.set('n', '<c-w>', ':bd!<cr>', {silent = true})

-- new file, save file
vim.keymap.set('n', '<c-n>', ':enew<cr>', {silent = true})
vim.keymap.set('n', '<c-s>', ':update<cr>', {silent = true})

-- splits
vim.keymap.set('n', 'ss', ':split<cr>', {silent = true})
vim.keymap.set('n', 'sv', ':vsplit<cr>', {silent = true})
vim.keymap.set('n', 'sc', ':close<cr>', {silent = true})
vim.keymap.set('n', 'sh', '<c-w>h', {silent = true})
vim.keymap.set('n', 'sj', '<c-w>j', {silent = true})
vim.keymap.set('n', 'sk', '<c-w>k', {silent = true})
vim.keymap.set('n', 'sl', '<c-w>l', {silent = true})

-- deal w/ word wrap (treat wrapped lines as their own)
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true })

-- toggle highlight
vim.keymap.set('n', '<a-h>', ':set hls!<cr>', {silent = true})

-- toggle hightlight
vim.keymap.set('n', '<a-z>', ':set wrap!<cr>', {silent = true})

-- telescope session switcher
vim.keymap.set('n', '<leader>s', ':Telescope possession list<cr>')

-- colorcolumn toggle
vim.keymap.set('n', '<a-c>', ':execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<cr>', {silent = true})

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


--
-- load plugins
--


-- session management
local function session_name()
  return require('possession.session').session_name or 'no session'
end

require('possession').setup{
  plugins = {
    delete_hidden_buffers = false,
  },
  autosave = {
    current = true
  },
  silent = true,
  hooks = {
    -- rename the tmux window to the name of the session we're loading
    before_load = function(name)
      return vim.fn.system("tmux rename-window " .. name)
    end
  }
}


-- lualine
require('lualine').setup{
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '•',
    section_separators = {left = '', right = '' }
  },
  sections = {
      lualine_c = {session_name},
    }
}


-- bufferline
require("bufferline").setup{
  options = {
    buffer_close_icon = '',
    indicator = {
      style = 'none'
    },
    always_show_bufferline = true,
    color_icons = true,
    show_close_icon = false,
    separator_style = 'thin',
  },
  highlights = {
    buffer_selected = {
      bold = true,
      italic = false,
    }
  }
}


-- kommentary
require('kommentary.config').configure_language("php", {
  single_line_comment_string = "//",
  multi_line_comment_strings = {"/*", "*/"},
})


-- gitsigns
require('gitsigns').setup {}


-- telescope
require('telescope').setup {
  defaults = {
    layout_config = {
      vertical = { width = 0.5 },
    },
    mappings = {
      i = {
        -- close telescope by pressing esc only once
        ["<esc>"] = require("telescope.actions").close,
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- vroom (still slower than vim-fzf)
pcall(require('telescope').load_extension, 'fzf')
require('telescope').load_extension('possession')

telescope = require('telescope.builtin')

-- find files
vim.keymap.set('n', '<c-p>', function() 
  telescope.find_files(require('telescope.themes').get_dropdown {
    winblend = 20,
  })
end)

-- find in files
vim.keymap.set('n', '<c-f>', function() 
  telescope.live_grep(require('telescope.themes').get_dropdown {
    winblend = 20,
  })
end)


-- treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'php', 'html'},

  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = {"javascript", "typescript.tsx"}

-- diagnostic keymaps
vim.keymap.set('n', '[e', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']e', vim.diagnostic.goto_next)

--
-- lsp settings
--

-- this runs when an lsp connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, {buffer = bufnr, desc = desc })
  end

  nmap('gd', vim.lsp.buf.definition)
  nmap('K', vim.lsp.buf.hover)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- setup mason so it can manage installing lsps for us
require('mason').setup()

-- enable the following language servers
local servers = {'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'sumneko_lua', 'intelephense'}

-- ensure the servers above are installed
require('mason-lspconfig').setup {
  ensure_installed = servers,
}

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- javascript config
require('lspconfig').tsserver.setup {
  on_attach = on_attach,
  filetypes = {"typescript", "typescriptreact", "typescript.tsx"},
  cmd = {"typescript-language-server", "--stdio"}
}

-- lua config
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {library = vim.api.nvim_get_runtime_file('', true)},
      telemetry = {enable = false },
    },
  },
}

-- completion plugin
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<c-u>'] = cmp.mapping.scroll_docs(-4),
    ['<c-d>'] = cmp.mapping.scroll_docs(4),
    ['<c-space>'] = cmp.mapping.complete({reason = cmp.ContextReason.Auto}),
    ['<cr>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<s-tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
  },
}


-- autopairs
require('nvim-autopairs').setup{
  disable_filetype = {'TelescopePrompt', 'vim'}
}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)


-- colorizer --
require('colorizer').setup{
  'css';
  'javascript';
  'javascriptreact';
  html = {
    mode = 'foreground';
  }
}

-- vim: ts=2 sts=2 sw=2 et
