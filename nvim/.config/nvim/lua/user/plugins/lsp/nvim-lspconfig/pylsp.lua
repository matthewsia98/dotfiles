local M = {}

M.setup = function(opts)
    local lspconfig = require("lspconfig")
    lspconfig["pylsp"].setup({
        capabilities = opts.capabilities,
        flags = opts.lsp_flags,
        handlers = opts.handlers,
        on_attach = opts.on_attach,

        settings = {
            -- https://github.com/python-lsp/python-lsp-server
            pylsp = {
                plugins = {
                    autopep8 = { enabled = false },
                    flake8 = {
                        enabled = true,
                        -- ignore = {
                        --     "E501", -- Line too long
                        --     "E266", -- Too many leading # for block comment
                        -- },
                    },
                    mccabe = { enabled = false },
                    pycodestyle = { enabled = false },
                    pydocstyle = {
                        enabled = false,
                        convention = "numpy",
                    },
                    pyflakes = { enabled = false },
                    pylint = {
                        enabled = false,
                        executable = "pylint",
                    },
                    rope_autoimport = {
                        enabled = true,
                        memory = false,
                    },
                    rope_completion = {
                        enabled = true,
                        eager = true,
                    },
                    yapf = { enabled = false },

                    jedi = {
                        environment = vim.env.VIRTUAL_ENV or "/usr",
                    },
                    jedi_completion = {
                        enabled = true,
                        fuzzy = true,
                        eager = true,
                        resolve_at_most = 25,
                        cache_for = { "numpy", "pandas", "torch", "matplotlib" },
                    },
                    jedi_definition = {
                        enabled = true,
                        follow_builtin_imports = true,
                        follow_imports = true,
                    },
                    jedi_hover = {
                        enabled = true,
                    },
                    jedi_references = {
                        enabled = true,
                    },
                    jedi_signature_help = {
                        enabled = true,
                    },
                    jedi_symbols = {
                        enabled = true,
                        all_scopes = true,
                        include_import_symbols = true,
                    },

                    -- Third Party Plugins
                    -- Need to install in Mason pylsp venv
                    -- source ~/.local/share/nvim/mason/packages/python-lsp-server/venv/bin/activate
                    -- pip install pylsp-mypy pyls-isort python-lsp-black pylsp-rope python-lsp-ruff
                    pylsp_mypy = {
                        enabled = true,
                        live_mode = true,
                        strict = false,
                    },
                    pyls_isort = {
                        enabled = false,
                    },
                    black = {
                        enabled = false,
                        preview = true,
                        line_length = 88,
                    },
                    pylsp_rope = {
                        enabled = true,
                    },
                    ruff = {
                        enabled = false,
                        -- ignore = {
                        --     "E741", -- ambiguous variable name
                        -- },
                    },
                },
            },
        },
    })
end

return M
