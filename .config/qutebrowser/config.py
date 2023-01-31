config.load_autoconfig()
config.source('redirect.py')

c.tabs.position = 'top'
c.tabs.width = '15%'
c.fonts.default_family = "Hack Nerd Font Mono"
c.fonts.web.family.standard = "Hack Nerd Font Mono"
c.fonts.default_size = '12px'
c.hints.uppercase = True
c.completion.height = '20%'
c.downloads.location.directory = '~/dl'
c.downloads.prevent_mixed_content = False
c.editor.command = ['foot', 'nvim', '{file}']
c.colors.webpage.darkmode.enabled = True
c.content.javascript.enabled = False
c.content.blocking.method = 'both'
c.auto_save.session = True
c.zoom.default = '100%'

c.url.start_pages = 'https://paulgo.io'
c.url.default_page = 'https://paulgo.io'
c.url.searchengines = {
    'DEFAULT': 'https://paulgo.io/?q={}',
    'qw'     : 'https://lite.qwant.com/?q={}',
    'g'      : 'https://google.com/search?q={}',
    'gi'     : 'https://www.google.com/search?q={}&source=lnms&tbm=isch',
    'gh'     : 'https://github.com/search?q={}',
    'w'      : 'https://en.wikipedia.org/?search={}',
    'yt'     : 'https://www.youtube.com/results?search_query={}'
}

c.aliases = {
    'g'      : 'open -t g',
    'qw'     : 'open -t qw',
    'gi'     : 'open -t gi',
    'yt'     : 'open -t yt',
    'gh'     : 'open -t gh',
    'w'      : 'open -t w',
    'private': 'open -p'
}

c.bindings.commands['normal'] = {
    '<shift-k>'    : 'tab-next',
    '<shift-j>'    : 'tab-prev',
    '<alt-shift-j>': 'zoom-out',
    '<alt-shift-k>': 'zoom-in',
    '<alt-shift-h>': 'zoom 100%',
    'd'            : 'scroll-page 0 0.5',
    'u'            : 'scroll-page 0 -0.5',
    '<alt-v>'      : 'spawn mpv {url}',
    '<shift-u>'    : 'hint links yank',
    ',v'           : 'spawn mpv {url}',
    '<shift-i>'    : 'hint links spawn mpv {hint-url}',
    '<ctrl-b>'     : 'config-cycle tabs.show always switching',
}

# dracula theme - https://github.com/dracula/qutebrowser
palette = {
    'background': '#282a36',
    'background-alt': '#282a36',
    'background-attention': '#181920',
    'border': '#282a36',
    'current-line': '#44475a',
    'selection': '#44475a',
    'foreground': '#f8f8f2',
    'foreground-alt': '#e0e0e0',
    'foreground-attention': '#ffffff',
    'comment': '#6272a4',
    'cyan': '#8be9fd',
    'green': '#50fa7b',
    'orange': '#ffb86c',
    'pink': '#ff79c6',
    'purple': '#bd93f9',
    'red': '#ff5555',
    'yellow': '#f1fa8c'
}

spacing = {
    'vertical': 5,
    'horizontal': 5
}

padding = {
    'top': spacing['vertical'],
    'right': spacing['horizontal'],
    'bottom': spacing['vertical'],
    'left': spacing['horizontal']
}

c.colors.completion.category.bg = palette['background']
c.colors.completion.category.border.bottom = palette['border']
c.colors.completion.category.border.top = palette['border']
c.colors.completion.category.fg = palette['foreground']
c.colors.completion.even.bg = palette['background']
c.colors.completion.odd.bg = palette['background-alt']
c.colors.completion.fg = palette['foreground']
c.colors.completion.item.selected.bg = palette['selection']
c.colors.completion.item.selected.border.bottom = palette['selection']
c.colors.completion.item.selected.border.top = palette['selection']
c.colors.completion.item.selected.fg = palette['foreground']
c.colors.completion.match.fg = palette['orange']
c.colors.completion.scrollbar.bg = palette['background']
c.colors.completion.scrollbar.fg = palette['foreground']
c.colors.downloads.bar.bg = palette['background']
c.colors.downloads.error.bg = palette['background']
c.colors.downloads.error.fg = palette['red']
c.colors.downloads.stop.bg = palette['background']
c.colors.downloads.system.bg = 'none'
c.colors.hints.match.fg = '#808080'
c.colors.messages.error.bg = palette['background']
c.colors.messages.error.border = palette['background-alt']
c.colors.messages.error.fg = palette['red']
c.colors.messages.info.bg = palette['background']
c.colors.messages.info.border = palette['background-alt']
c.colors.messages.info.fg = palette['comment']
c.colors.messages.warning.bg = palette['background']
c.colors.messages.warning.border = palette['background-alt']
c.colors.messages.warning.fg = palette['red']
c.colors.prompts.bg = palette['background']
c.colors.prompts.border = '1px solid ' + palette['background-alt']
c.colors.prompts.fg = palette['cyan']
c.colors.prompts.selected.bg = palette['selection']
c.colors.statusbar.caret.bg = palette['background']
c.colors.statusbar.caret.fg = palette['orange']
c.colors.statusbar.caret.selection.bg = palette['background']
c.colors.statusbar.caret.selection.fg = palette['orange']
c.colors.statusbar.command.bg = palette['background']
c.colors.statusbar.command.fg = palette['pink']
c.colors.statusbar.command.private.bg = palette['background']
c.colors.statusbar.command.private.fg = palette['foreground-alt']
c.colors.statusbar.insert.bg = palette['background-attention']
c.colors.statusbar.insert.fg = palette['foreground-attention']
c.colors.statusbar.normal.bg = palette['background']
c.colors.statusbar.normal.fg = palette['foreground']
c.colors.statusbar.passthrough.bg = palette['background']
c.colors.statusbar.passthrough.fg = palette['orange']
c.colors.statusbar.private.bg = palette['background-alt']
c.colors.statusbar.private.fg = palette['foreground-alt']
c.colors.statusbar.progress.bg = palette['background']
c.colors.statusbar.url.error.fg = palette['red']
c.colors.statusbar.url.fg = palette['foreground']
c.colors.statusbar.url.hover.fg = palette['cyan']
c.colors.statusbar.url.success.http.fg = palette['green']
c.colors.statusbar.url.success.https.fg = palette['green']
c.colors.statusbar.url.warn.fg = palette['yellow']
c.statusbar.padding = padding
c.colors.tabs.bar.bg = palette['selection']
c.colors.tabs.even.bg = palette['selection']
c.colors.tabs.even.fg = palette['foreground']
c.colors.tabs.indicator.error = palette['red']
c.colors.tabs.indicator.start = palette['orange']
c.colors.tabs.indicator.stop = palette['green']
c.colors.tabs.indicator.system = 'none'
c.colors.tabs.odd.bg = palette['selection']
c.colors.tabs.odd.fg = palette['foreground']
c.colors.tabs.selected.even.bg = palette['background']
c.colors.tabs.selected.even.fg = palette['foreground']
c.colors.tabs.selected.odd.bg = palette['background']
c.colors.tabs.selected.odd.fg = palette['foreground']
c.tabs.favicons.scale = 1

