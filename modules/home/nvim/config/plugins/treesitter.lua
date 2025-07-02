require('nvim-treesitter.configs').setup {
    ensure_installed = {},

    auto_install = false,

    highlight = { enable = true },

    indent = { enable = true },

    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
    },

    context_commentstring = {
        enable = true,
    },
}