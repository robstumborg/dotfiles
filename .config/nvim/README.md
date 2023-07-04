# neovim configuration

## custom keybindings

| keybind     | description                               | plugin             |
| ----------- | ----------------------------------------- | ------------------ |
| <leader>    | spacebar                                  |                    |
| <leader>s   | switch session/project                    | possession.nvim    |
| ctrl+k      | next buffer                               | nvim-cokeline      |
| ctrl+j      | previous buffer                           | nvim-cokeline      |
| ctrl+w      | close buffer                              |                    |
| ctrl+n      | new buffer                                |                    |
| ctrl+s      | save buffer                               |                    |
| ctrl+b      | toggle file explorer                      | nvim-tree          |
| ctrl+p      | fuzzy find files                          | telescope.nvim     |
| ctrl+f      | grep in files                             | telescope.nvim     |
| ctrl+h      | fuzzy find buffers                        | telescope.nvim     |
| alt+h       | toggle search highlight                   |                    |
| alt+z       | toggle word wrap                          |                    |
| alt+c       | switch color column (none, 80, 120)       |                    |
| "           | display contents of registers             | registers.nvim     |
| ]e          | next error                                | lsp                |
| [e          | previous error                            | lsp                |
| ]t          | next todo                                 | todo-comments.nvim |
| [t          | previous todo                             | todo-comments.nvim |
| gd          | go to definition                          | lsp                |
| gr          | see references                            | lsp                |
| shift+k     | hover code signature                      | lsp                |
| <leader>ff  | format buffer                             | formatter.nvim     |
| <leader>gh  | preview changed hunk (git)                | gitsigns.nvim      |
| <leader>tt  | toggle tmux pane                          | vimux              |
| <leader>tr  | run current buffer as script in tmux pane | vimux              |
| <leader>tr  | run current selection in tmux pane (bash) | vimux              |
| <leader>cc  | open color picker dialog                  | ccc.nvim           |
| <leader>cp  | enable copilot                            | copilot.lua        |
| ss          | new split                                 |                    |
| sv          | new vertical split                        |                    |
| sc          | close split                               |                    |
| sh          | switch split left                         |                    |
| sj          | switch split down                         |                    |
| sk          | switch split up                           |                    |
| sl          | switch split right                        |                    |
| sl          | switch split right                        |                    |
| <leader>gs  | git: show status in telescope             | telescope.nvim     |
| <leader>gS  | git: open fugitive :Git split             | vim-fugitive       |
| <leader>gaf | git: stage current buffer                 | gitsigns.nvim      |
| <leader>grf | git: reset current buffer (undo changes)  | gitsigns.nvim      |
| <leader>gah | git: stage hunk                           | gitsigns.nvim      |
| <leader>guh | git: unstage current hunk                 | gitsigns.nvim      |
| <leader>grh | git: reset current hunk (undo changes)    | gitsigns.nvim      |
| <leader>gph | git: preview current hunk                 | gitsigns.nvim      |
