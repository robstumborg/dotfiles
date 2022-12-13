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

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use {'hrsh7th/nvim-cmp', requires = 'hrsh7th/cmp-nvim-lsp'}
  use {'hrsh7th/cmp-path', requires = 'hrsh7th/nvim-cmp'}
  use {'hrsh7th/cmp-buffer', requires = 'hrsh7th/nvim-cmp'}
  use {'hrsh7th/cmp-nvim-lsp-signature-help', requires = 'hrsh7th/nvim-cmp'}
  use {'L3MON4D3/LuaSnip', requires = 'saadparwaiz1/cmp_luasnip'}
  use 'microsoft/python-type-stubs'
  use 'rafamadriz/friendly-snippets'
  use 'onsails/lspkind.nvim'

  -- syntax
  use 'nvim-treesitter/nvim-treesitter'
  use {'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter'}
  use 'mhartington/formatter.nvim'
  use 'Vimjas/vim-python-pep8-indent'

  -- editing
  use 'windwp/nvim-ts-autotag'
  use 'windwp/nvim-autopairs'
  use 'b3nj5m1n/kommentary'
  use 'kylechui/nvim-surround'
  use 'uga-rosa/ccc.nvim'
  use 'leafOfTree/vim-matchtag'
  use 'phaazon/hop.nvim'
  use {"iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end}
  use {"folke/todo-comments.nvim"}
  use 'tversteeg/registers.nvim'
  use 'gpanders/editorconfig.nvim'
  use 'junegunn/vim-easy-align'

  -- git
  use {'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim'}
  use {'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim'}

  -- visual
  use 'olimorris/onedarkpro.nvim'
  use {'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons'}
  use {'noib3/nvim-cokeline', requires = 'kyazdani42/nvim-web-devicons'}
  use {'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons'}
  use 'karb94/neoscroll.nvim'

  -- telescope
  use {'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim'}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

  -- session management
  use {'jedrzejboczar/possession.nvim', requires = 'nvim-lua/plenary.nvim'}

  -- tmux integration
  use 'preservim/vimux'

  -- upload text
  use 'rktjmp/paperplanes.nvim'

  -- wiki
  use{'jakewvincent/mkdnflow.nvim', rocks = 'luautf8'}

  -- Rename/Delete/Chmod/etc
  use 'tpope/vim-eunuch'

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
-- color scheme
require('onedarkpro').setup{
  options = {
    cursorline = true,
    bold = false,
    italic = false,
    transparency = true
  }
}
vim.o.termguicolors = true
vim.cmd('colorscheme onedarkpro')

-- disable start message
vim.o.shortmess = "I"

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
vim.o.undodir = vim.fn.stdpath 'data' .. '/undo'

-- case insensitive searching unless /c or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- quick update time
vim.o.updatetime = 100
vim.wo.signcolumn = 'yes'

-- use system clipboard
vim.o.clipboard = 'unnamedplus'

-- set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- indenting
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- word wrap
vim.wo.wrap = false

-- backup
vim.opt.backup = false
vim.opt.writebackup = false

-- textwidth
-- vim.o.textwidth = 80
local textwidth_settings = {}
local textwidth = vim.api.nvim_create_augroup('textwidth', {clear=true})
vim.api.nvim_create_autocmd('filetype', {
  group = textwidth,
  pattern = {'html'},
  callback = function() vim.o.textwidth = 120 end
})

-- vimux
vim.g.vimuxheight = 32

-- wiki
local wiki = vim.api.nvim_create_augroup('wiki', {clear = true})
vim.api.nvim_create_autocmd({'bufreadpre', 'filereadpre'}, {
  group = wiki,
  pattern = {'*.wiki.md'},
  command = 'setl noswapfile noundofile nobackup viminfo='
})

--
-- keymaps (these should be set before plugins are initialized)
--
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- buffer navigation
vim.keymap.set('n', '<c-k>', '<plug>(cokeline-focus-next)', {silent = true})
vim.keymap.set('n', '<c-j>', '<plug>(cokeline-focus-prev)', {silent = true})
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
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'",
{expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'",
{expr = true, silent = true })

-- toggle highlight
vim.keymap.set('n', '<a-h>', ':set hls!<cr>', {silent = true})

-- toggle file explorer
vim.keymap.set('n', '<c-b>', ':NvimTreeToggle<cr>')

-- toggle hightlight
vim.keymap.set('n', '<a-z>', ':set wrap!<cr>', {silent = true})

-- find files
vim.keymap.set('n', '<c-p>', ':Telescope find_files<cr>')

-- find in files
vim.keymap.set('n', '<c-f>', ':Telescope live_grep<cr>')

-- switch buffers via telescope
vim.keymap.set('n', '<c-h>', ':Telescope buffers<cr>')

-- session switcher
vim.keymap.set('n', '<leader>s', ':Telescope possession list<cr>')

-- colorcolumn toggle
vim.keymap.set('n', '<a-c>', ':execute "set cc=" . (&cc== "" ? "80" : "")<cr>',
{silent = true})
vim.keymap.set('n', '<s-a-c>', ':execute "set cc=" . (&cc== "" ? "120" : "")<cr>',
{silent = true})

-- format buffer w/ formatter.nvim
vim.keymap.set('n', '<leader>ff', ':Format<cr>')

-- preview git hunk
vim.keymap.set('n', '<leader>gh', ':Gitsigns preview_hunk<cr>')

-- vimux
vim.keymap.set('n', '<leader>tt', ':VimuxTogglePane<cr>', {silent = true})

-- vimux executors
vim.keymap.set('n', '<leader>tr', ':echo "can\'t execute this file"<cr>')
vim.api.nvim_create_augroup('vimux', { clear = true })
local vimuxtable = {
  ['php'] = 'php',
  ['python'] = 'python',
  ['go'] = 'go run',
  ['sh'] = 'bash -c',
  ['javascript'] = 'node',
  ['typescript'] = 'node',
  ['rust'] = 'rust-script'
}
for ft, exec in pairs(vimuxtable) do
  vim.api.nvim_create_autocmd('filetype', {
    group = 'vimux', pattern = ft,
    callback = function()
      vim.api.nvim_buf_set_keymap(0, 'n', '<leader>tr',
      ':VimuxRunCommand "'..exec..' '..vim.fn.expand('%:p')..'"<cr>',
      {noremap=true})
    end
  })
end

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- send visual selections as commands to execute in tmux pane
-- todo: turn this into lua, C-U wouldn't work w/ keymap.set for some reason
-- You can add range = true in the options argument of nvim_create_user_command, it will avoid an error if the user leaves the range in the command.
-- vim.api.nvim_create_user_command('SendSelectionToVimux', 'VimuxRunCommand "'..getv()..'"', {range=true})
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

-- 
-- command aliases
--

vim.cmd 'command! Diff DiffviewOpen'

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
  commands = {
    save = 'SaveSession'
  },
  hooks = {
    -- rename the tmux window to the name of the session we're loading
    before_load = function(name)
      return vim.fn.system("tmux rename-window " .. name)
    end,
    after_load = function(name)
      return vim.fn.serverstart('/tmp/nvim-' .. name)
    end
  }
}

-- lualine
require('lualine').setup{
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = '•',
    section_separators = {left = '', right = '' }
  },
  sections = {
    lualine_c = {session_name},
  }
}

-- cokeline
local colors = require("onedarkpro").get_colors(vim.g.onedarkpro_theme)
require('cokeline').setup{
  default_hl = {
    fg = function(buffer)
      return buffer.is_focused and colors.purple or colors.white
    end,
    bg = colors.black,
    style = function(buffer)
      return buffer.is_focused and "bold" or nil
    end,
  },
  sidebar = {
    filetype = 'NvimTree',
    components = {
    {
        text = '  nvim-tree',
        fg = colors.purple,
        bg = colors.black,
        style = 'bold',
      },
    }
  },

  components = {
    {text = function(buffer) return (buffer.index ~= 1) and '' or '' end},
    {text = ' '},
    {
      text = function(buffer) return buffer.devicon.icon end,
      fg = function(buffer) return buffer.devicon.color end
    },
    {text = ' '},
    {
      text = function(buffer) return buffer.unique_prefix end,
      style = 'italic',
      fg = colors.gray,
    },
    {
      text = function(buffer) return buffer.filename .. '  ' end,
      style = function(buffer) return buffer.is_focused and 'bold' or nil end,
    },
    {
      text = '',
      fg = colors.black,
      bg = function(buffer) return buffer.is_modified and colors.green or colors.fg_gutter end
    },
    {
      text = ''
    }
  },
}

-- kommentary
require('kommentary.config').configure_language("php", {
  single_line_comment_string = "//",
  multi_line_comment_strings = {"/*", "*/"},
})

-- gitsigns
require('gitsigns').setup{
  current_line_blame = true,
  attach_to_untracked = true,
  yadm = {
    enable = true
  }
}

-- telescope
require('telescope').setup{
  pickers = {
    find_files = {
      previewer = false,
      hidden = true
    },
    buffers = {
      previewer = false
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
  defaults = {
    layout_config = {
      vertical = { width = 0.5 },
    },
    mappings = {
      i = {
        -- close telescope by pressing esc only once
        ['<esc>'] = require('telescope.actions').close,
        ['<c-j>'] = require('telescope.actions').move_selection_next,
        ['<c-k>'] = require('telescope.actions').move_selection_previous,
        ['<c-u>'] = false,
        ['<c-d>'] = false,
      },
    },
  },
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('possession')

-- treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'lua',
    'go',
    'python',
    'tsx',
    'php',
    'html',
    'css',
    'javascript'
  },
  highlight = {
    enable = true,
    disable = {'html'},
  },
  indent = {
    enable = true,
    disable = {'html', 'python', 'javascript'}
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = {"javascript", "typescript.tsx"}

require('ccc').setup{
  highlighter = {
    auto_enable = true
  }
}

-- nvim-surround
require('nvim-surround').setup{}

-- diffview
require('diffview').setup{}

-- nvim-tree
require('nvim-tree').setup{
  view = {
    mappings = {
      list = {
        { key = 's', action = '' }
      }
    }
  }
}

-- smooth scrolling
require('neoscroll').setup{
  hide_cursor = false,
  mappings = {
    '<C-u>', '<C-d>'
  }
}

-- hop
require('hop').setup{}
vim.keymap.set('n', 'H', ':HopWord <cr>', {})
vim.keymap.set('n', 'L', ':HopLine <cr>', {})

-- lsp client configuration
-- diagnostic keymaps
vim.keymap.set('n', '[e', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']e', vim.diagnostic.goto_next)

-- disable inline error messages
vim.diagnostic.config({virtual_text = false})

--
-- lsp settings
--
-- this runs when an lsp connects to a particular buffer
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

local nvim_lsp = require('lspconfig')
local lspconfig = require('mason-lspconfig')

-- ensure the servers above are installed
lspconfig.setup {
  ensure_installed = {
    'pyright',
    'tsserver',
    'intelephense',
    'cssls',
    'html',
    'emmet_ls',
    'vuels'
  }
}

-- this configures all language servers installed via mason
-- we can define optional settings for each one here if desired
lspconfig.setup_handlers{
  function(server_name)
    nvim_lsp[server_name].setup{
      on_attach = on_attach,
      capabilities = capabilities
    }
  end,
  -- javascript language server settings
  ['tsserver'] = function()
    nvim_lsp.tsserver.setup{
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = function() return vim.loop.cwd() end,
      init_options = {
        preferences = {
          disableSuggestions = true
        }
      }
    }
  end,
  -- php language server settings
  ['intelephense'] = function()
    nvim_lsp.intelephense.setup{
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        intelephense = {
          stubs = {
            'apache', 'bcmath', 'bz2', 'calendar', 'com_dotnet', 'Core', 'ctype',
            'curl', 'date', 'dba', 'dom', 'enchant', 'exif', 'FFI', 'fileinfo',
            'filter', 'fpm', 'ftp', 'gd', 'gettext', 'gmp', 'hash', 'iconv', 'imap',
            'imagick', 'intl', 'json', 'ldap', 'libxml', 'mbstring', 'meta',
            'mysqli', 'oci8', 'odbc', 'openssl', 'pcntl', 'pcre', 'PDO', 'pdo_ibm',
            'pdo_mysql', 'pdo_pgsql', 'pdo_sqlite', 'pgsql', 'Phar', 'posix',
            'pspell', 'readline', 'Reflection', 'session', 'shmop', 'SimpleXML',
            'snmp', 'soap', 'sockets', 'sodium', 'SPL', 'sqlite3', 'standard',
            'superglobals', 'sysvmsg', 'sysvsem', 'sysvshm', 'tidy', 'tokenizer',
            'xml', 'xmlreader', 'xmlrpc', 'xmlwriter', 'xsl', 'Zend OPcache', 'zip',
            'zlib', 'wordpress'
          },
          environment = {
            phpVersion = 8.1
          },
        };
      }
    }
  end,
  -- python language server settings
  ['pyright'] = function()
    nvim_lsp.pyright.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = 'off'
          }
        }
      },
      before_init = function(_, config)
        config.settings.python.analysis.stubPath = path.concat {
          vim.fn.stdpath 'data',
          'site',
          'pack',
          'packer',
          'start',
          'python-type-stubs',
        }
      end,
    }
  end,
  -- html language server settings
  ['html'] = function()
    nvim_lsp.pyright.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        css = {
          lint = {
            validProperties = {},
          }
        }
      }
    }
  end,
  -- rust language server settings
  ['rust_analyzer'] = function()
    nvim_lsp.rust_analyzer.setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
end
}

-- completion plugin
require('luasnip.loaders.from_vscode').lazy_load()
local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      menu = ({
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
      })
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<c-u>'] = cmp.mapping.scroll_docs(-4),
    ['<c-d>'] = cmp.mapping.scroll_docs(4),
    ['<c-space>'] = cmp.mapping.complete({reason = cmp.ContextReason.Auto}),
    ['<cr>'] = cmp.mapping.confirm {behavior = cmp.ConfirmBehavior.Replace, select = false},
    ['<tab>'] = cmp.mapping(
      function(fallback)
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
    {name = 'luasnip'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lsp_signature_help'},
    {name = 'path'},
    {name = 'buffer'},
  }
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

-- code formatter
require("formatter").setup{
  filetype = {
    html = {require('formatter.filetypes.html').prettier},
    css = {require('formatter.filetypes.css').prettier},
    javascript = {require('formatter.filetypes.javascript').prettier},
    python = {require('formatter.filetypes.python').black},
    rust = {require('formatter.filetypes.rust').rustfmt},
    sh = {require('formatter.filetypes.sh').shfmt}
  }
}

-- todo highlighter
require("todo-comments").setup{}

-- text upload
require("paperplanes").setup{
  register = "+",
  provider = "0x0.st",
  provider_options = {},
  notifier = vim.notify or print,
}

-- registers preview popup
require("registers").setup{}

-- wiki
require('mkdnflow').setup{
  links = {
    implicit_extension = 'wiki.md',
    transform_explicit = function(text)
      text = text:gsub(' ', '-')
      text = text:lower()
      return(text)
    end
  }
}

