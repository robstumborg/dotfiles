let config_dir = $XDG_CONFIG_HOME . '/nvim'
if empty(glob(config_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo ' . config_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugins')
" theme
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'olimorris/onedarkpro.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'xiyaowong/nvim-transparent'

" autocomplete/errors/etc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" file navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'

" git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" session management
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

" html
Plug 'mattn/emmet-vim'
Plug 'AndrewRadev/tagalong.vim'
Plug 'gregsexton/MatchTag'
Plug 'alvan/vim-closetag'
Plug 'ap/vim-css-color'

" Rename/Delete/etc
Plug 'tpope/vim-eunuch'

" text editing
Plug 'tpope/vim-surround'
Plug 'b3nj5m1n/kommentary'
Plug 'Raimondi/delimitMate'
Plug 'unblevable/quick-scope'
Plug 'matze/vim-move'

" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" yank preview
Plug 'junegunn/vim-peekaboo'

" note taking
Plug 'vimwiki/vimwiki'

" syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'yioneko/nvim-yati'
Plug 'isobit/vim-caddyfile'
Plug 'LeonB/vim-nginx'
Plug 'mtdl9/vim-log-highlighting'
Plug 'jidn/vim-dbml'
Plug 'jamespeapen/swayconfig.vim'
Plug 'fcpg/vim-weblogs'
Plug '1995parham/vim-tcpdump'
Plug 'chunkhang/vim-mbsync'


" language/framework specific
Plug 'nvim-lua/plenary.nvim'
Plug 'thosakwe/vim-flutter'
Plug 'dart-lang/dart-vim-plugin'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'phelipetls/vim-hugo'
Plug 'leafOfTree/vim-vue-plugin'

" sudo edit
Plug 'lambdalisue/suda.vim'

" tmux
Plug 'preservim/vimux'

Plug 'editorconfig/editorconfig-vim'
Plug 'vim-vdebug/vdebug'
call plug#end()

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "php",
      "go",
      "python",
      "typescript",
      "javascript",
      "json",
      "c",
      "lua",
      "rust"
    },

  sync_install = false,
  ignore_install = {},

  indent = {
    enable = true,
    },

  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
}
require("nvim-treesitter.configs").setup {
  yati = { enable = true },
}

require('transparent').setup({
  enable = true
})

require('gitsigns').setup()

require('kommentary.config').configure_language("php", {
    single_line_comment_string = "//",
    multi_line_comment_strings = {"/*", "*/"},
})

EOF

" color scheme
colorscheme onedarkpro

" vim settings
set shortmess=I
set background=dark
set termguicolors
set encoding=utf-8
set number relativenumber
set hidden
set ignorecase
set incsearch
set hlsearch
set smartcase
set expandtab
set nosmartindent
set confirm
set clipboard=unnamedplus
set undofile
set splitbelow
set noswapfile
set nowrap
set mouse=a

" disable consecutive comment lines
au bufnewfile,bufread,bufwritepre * setlocal formatoptions-=ro

filetype plugin on
syntax on

" tabbing
set shiftwidth=4 tabstop=4 softtabstop=4
au filetype html setl shiftwidth=2
au filetype css setl shiftwidth=2
au filetype htmlhugo setl shiftwidth=2
au filetype javascript setl shiftwidth=2
au filetype vue setl shiftwidth=2
au filetype vim setl shiftwidth=2 tabstop=4
au filetype dart setl shiftwidth=2
au filetype yaml setl shiftwidth=2

" yyeol
nno Y y$

" buffer switching
nno <silent> <c-k> :bn!<cr>
nno <silent> <c-j> :bp!<cr>
nno <silent> <c-q> :bd<cr>

" splits
nm ss :split<cr>
nm sv :vsplit<cr>
nm sc :close<cr>
map sh <c-w>h
map sj <c-w>j
map sk <c-w>k
map sl <c-w>l

" vim-move
let g:move_map_keys = 0
nmap <a-k> <plug>MoveLineUp
nmap <a-j> <plug>MoveLineDown
vmap <a-k> <plug>MoveBlockUp
vmap <a-j> <plug>MoveBlockDown

" save
nn <c-s> :update<cr>
ino <c-s> <c-o>:update<cr>

" file navigation
nn <c-p> :FZF<cr>
nn <c-f> :Rg<cr>

" nerd tree toggle
nn <c-b> :NERDTreeToggle<cr>

" new temp file
nn <silent> <c-n> :enew<cr>

" word wrap toggle
nn <silent><a-z> :set wrap!<cr>

" search highlight toggle
nmap <silent> <a-h> :set hls! <cr>

" colorcolumn toggle
nn <silent> <a-c> :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<cr>

" switch sessions fzf
nn <silent> <leader>s :call fzf#run({'source': prosession#ListSessions(),
    \ 'sink': 'Prosession', 'window': {'width': 0.9, 'height': 0.6}})<cr>

" coc
let g:coc_global_extensions = [
      \'@yaegassy/coc-intelephense',
      \'coc-jedi',
      \'coc-git',
      \'coc-tsserver',
      \'coc-go',
      \'coc-vetur',
      \'coc-clangd',
      \'coc-html',
      \'coc-css']

" show documentation hotkey
function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nn <silent> K :call <sid>show_documentation()<cr>

ino <silent><expr> <c-space> coc#refresh()

" errors
nmap <silent> [e <plug>(coc-diagnostic-prev)
nmap <silent> ]e <plug>(coc-diagnostic-next)

" scroll thru completions using tab / shift-tab
ino <silent><expr> <tab> coc#pum#visible() ? coc#pum#next(0) : "\<tab>"
ino <silent><expr> <s-tab> coc#pum#visible() ? coc#pum#prev(0) : "\<s-tab>"

" pressing enter selections the completion
ino <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm()
        \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<cr>"

" use ctrl+d/u for scrolling inside the coc.nvim popups
nno <nowait><expr> <c-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nno <nowait><expr> <c-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
ino <nowait><expr> <c-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
ino <nowait><expr> <c-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

let g:user_emmet_leader_key='<c-e>'

function! s:GoToDefinition()
  if CocAction('jumpDefinition')
    return v:true
  endif

  let ret = execute("silent! normal \<C-]>")
  if ret =~ "Error"
    call searchdecl(expand('<cword>'))
  endif
endfunction

nmap <silent> gd :call <sid>GoToDefinition()<cr>
aug qs_colors
  au!
  au colorscheme onedarkpro highlight quickscopeprimary guifg='#ffffff' gui=underline ctermfg=1 cterm=underline
  au colorscheme onedarkpro highlight quickscopesecondary guifg='#f0fff0' ctermfg=2
aug END

let g:airline_theme="onedark"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_left_sep = "\uE0BC"
let g:airline_right_sep = "\uE0BE"
let g:airline_left_alt_sep = "\uE0BB"
let g:airline_right_alt_sep = "\uE0B9"

let g:qs_highlight_on_keys = ['f', 'F']

map <space> <leader>
let g:suda_smart_edit = 1

" show prosession name in status bar
function! SessionName()
  if ObsessionStatus() == ''
    retu 'no session'
  endif
  return fnamemodify(getcwd(), ':t')
endfunction

let g:airline_section_b = '%-0.30{SessionName()}'
let g:airline_section_c = '%t'

" prosession
let g:prosession_on_startup = 0
let session_dir = $XDG_DATA_HOME . '/nvim/session'
let g:prosession_dir = session_dir
let g:prosession_last_session_dir = session_dir

" use :Tb to upload current buffer (or selection) to termbin.com and place url in clipboard
command! -range=% Tb <line1>,<line2>w !nc termbin.com 9999 | tr -d '\n' | wl-copy

" plugin-specific settings
set conceallevel=0
let g:vim_json_conceal=0

au filetype php let b:delimitMate_matchpairs = "(:),[:],{:}"
au filetype html let b:delimitMate_matchpairs = "(:),[:],{:}"

" wiki
let g:vimwiki_list = [{'path': '~/wiki/', 'syntax': 'markdown', 'ext': '.wiki.md'}]
au filetype vimwiki set syntax=markdown
au bufreadpre,filereadpre *.wiki.md setl noswapfile noundofile nobackup viminfo=

aug encrypted
  au!
  au bufreadpre,filereadpre *.gpg,*.gpg.md setl noswapfile noundofile nobackup viminfo=
  au bufreadpost *.gpg,*.gpg.md :sil %!gpg_tty=/dev/tty gpg2 --decrypt 2> /dev/null
  au bufwritepre *.gpg,*.gpg.md :sil %!gpg_tty=/dev/tty gpg2 -se -a --default-recipient-self
  au bufwritepost *.gpg,*.gpg.md :sil undo
aug end

" hugo plugin doesn't like this not being set
let g:markdown_fenced_languages = [
      \'css',
      \'javascript',
      \'js=javascript',
      \'json=javascript',
      \'sh',
      \'sass',
      \'html',
      \'php']

" tmux specific settings
if exists('$TMUX')
  nmap <f10> :VimuxTogglePane<cr>
  let g:VimuxHeight = "32"
  " rename tmux window when loading/switching session
  au sessionloadpost * call system("tmux rename-window " . SessionName())
  au sessionloadpost * silent! call serverstart('/tmp/nvim-' . SessionName())
  " hotkeys to run/compile programs
  au filetype c map <buffer> <f9> :w<cr>:VimuxRunCommand 'gcc ' . shellescape(@%, 1) . ' && ./a.out; rm -rf a.out'<cr>
  au filetype go map <buffer> <f9> :w<cr>:VimuxRunCommand 'go run ' . shellescape(@%, 1)<cr>
  au filetype sh map <buffer> <f9> :w<cr>:VimuxRunCommand 'bash ' . shellescape(@%, 1)<cr>
  au filetype php map <buffer> <f9> :w<cr>:VimuxRunCommand 'php ' . shellescape(@%, 1)<cr>
  au filetype ruby map <buffer> <f9> :w<cr>:VimuxRunCommand 'ruby ' . shellescape(@%, 1)<cr>
  au filetype python map <buffer> <f9> :w<cr>:VimuxRunCommand 'python3 ' . shellescape(@%, 1)<cr>
else
  au filetype c map <buffer> <f9> :w<cr>:exec '!gcc ' . shellescape(@%, 1) . ' && ./a.out'<cr>
  au filetype go map <buffer> <f9> :w<cr>:exec '!go run' shellescape(@%, 1)<cr>
  au filetype sh map <buffer> <f9> :w<cr>:exec 'bash ' . shellescape(@%, 1)<cr>
  au filetype php map <buffer> <f9> :w<cr>:exec '!php ' shellescape(@%, 1)<cr>
  au filetype ruby map <buffer> <f9> :w<cr>:exec '!ruby ' . shellescape(@%, 1)<cr>
  au filetype python map <buffer> <f9> :w<cr>:exec '!python3 ' shellescape(@%, 1)<cr>
endif

au filetype markdown map <buffer> <f9> :MarkdownPreview<cr>

" popup a window showing registers when pasting
function! FloatingWindow()
  let width = float2nr(&columns * 0.8)
  let height = float2nr(&lines * 0.6)
  let top = ((&lines - height) / 2) - 1
  let left = (&columns - width) / 2
  let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}
  let top = "╭" . repeat("─", width - 2) . "╮"
  let mid = "│" . repeat(" ", width - 2) . "│"
  let bot = "╰" . repeat("─", width - 2) . "╯"
  let lines = [top] + repeat([mid], height - 2) + [bot]
  let s:buf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
  call nvim_open_win(s:buf, v:true, opts)
  set winhl=Normal:Floating
  let opts.row += 1
  let opts.height -= 2
  let opts.col += 2
  let opts.width -= 4
  call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  au BufWipeout <buffer> exe 'bw ' . s:buf
endfunction
let g:peekaboo_window="call FloatingWindow()"

aug switchsplit
  au!
  au bufenter,focusgained,insertleave,winenter * if &nu && mode() != "i" | set rnu | endif
  au bufleave,focuslost,insertenter,winleave   * if &nu                  | set nornu | endif
aug end

au bufnewfile,bufread *waybar/config set ft=json
au bufnewfile,bufread /tmp/mitmproxy* set nofixendofline shortmess=a
au bufnewfile,bufread ~/.ssh/servers set ft=sshconfig

" unminify
:command! UnminifyHTML :%s/<[^>]*>/\r&\r/g
:command! RemoveBlankLines :g/^$/d

" Simple re-format for minified Javascript
command! UnminifyJS call UnminifyJS()
function! UnminifyJS()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction

