vim.diagnostic.config({
    virtual_text = {
        prefix = '●',
        source = "if_many",
        spacing = 4,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local bufnr = event.buf
        local bufmap = function(keys, func)
            vim.keymap.set('n', keys, func, { buffer = bufnr })
        end

        bufmap('<leader>r', vim.lsp.buf.rename)
        bufmap('<leader>a', vim.lsp.buf.code_action)

        bufmap('gd', vim.lsp.buf.definition)
        bufmap('gD', vim.lsp.buf.declaration)
        bufmap('gI', vim.lsp.buf.implementation)
        bufmap('<leader>D', vim.lsp.buf.type_definition)

        bufmap('gr', require('telescope.builtin').lsp_references)
        bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
        bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

        bufmap('K', vim.lsp.buf.hover)

        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
        end, {})
    end
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('neodev').setup()

local servers = {
    lua_ls = {
        root_dir = function()
            return vim.uv.cwd()
        end,
        cmd = { "lua-lsp" },
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        }
    },
    cmake = {
        init_options = {
            buildDirectory = "./build",
        },
    },
    clangd = {},
    glsl_analyzer = {},
    nil_ls = {},
    pyright = {},
    html = {},
    cssls = {},
    emmet_ls = {},
    ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = {
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
            "typescript.tsx"
        },
        root_dir = function(filename, _)
            return vim.fs.root(filename, {
                "package.json",
                "tsconfig.json",
                "jsconfig.json",
                ".git"
            })
        end,
        single_file_support = true,
    },
    rust_analyzer = {
        settings = {
            ['rust-analyzer'] = {
                diagnostics = {
                    enable = true,
                },
                cargo = {
                    allFeatures = true,
                },
            },
        },
    },
}

for server_name, config in pairs(servers) do
    config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
    
    vim.lsp.config(server_name, config)
    vim.lsp.enable(server_name)
end
