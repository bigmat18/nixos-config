require('nvim-treesitter.configs').setup {
    ensure_installed = {},
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    context_commentstring = { enable = true },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",        -- inizia selezione
            node_incremental = "grn",      -- espandi al nodo successivo
            scope_incremental = "grc",     -- espandi allo scope
            node_decremental = "grm",      -- riduci
        },
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                -- Funzioni / classi (già presenti)
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",

                -- Parametri/argomenti
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",

                -- Condizionali (if/else, switch...)
                ["ai"] = "@conditional.outer",
                ["ii"] = "@conditional.inner",

                -- Cicli (for/while)
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",

                -- Commenti
                ["a/"] = "@comment.outer",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
                ["]i"] = "@conditional.outer",
                ["]l"] = "@loop.outer",
                ["]a"] = "@parameter.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
                ["]I"] = "@conditional.outer",
                ["]L"] = "@loop.outer",
                ["]A"] = "@parameter.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
                ["[i"] = "@conditional.outer",
                ["[l"] = "@loop.outer",
                ["[a"] = "@parameter.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
                ["[I"] = "@conditional.outer",
                ["[L"] = "@loop.outer",
                ["[A"] = "@parameter.outer",
            },
        },
  },
}