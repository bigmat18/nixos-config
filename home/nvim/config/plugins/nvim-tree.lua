require('nvim-tree').setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = true,
    update_cwd = true,
    respect_buf_cwd = true,
    view = {
        width = 30,
        side = 'left',
    },
    renderer = {
        highlight_git = true,
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = '',
                symlink = '',
                git = {
                    unstaged = '✗',
                    staged = '✓',
                    unmerged = '',
                    renamed = '➜',
                    untracked = '★',
                    deleted = '',
                    ignored = '◌',
                },
            },
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    git = {
        enable = true,
        ignore = false,
    },
})