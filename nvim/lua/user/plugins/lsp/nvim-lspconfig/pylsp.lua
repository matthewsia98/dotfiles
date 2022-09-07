local lspconfig = require('lspconfig')

local M = {}

M.setup = function(on_attach, lsp_flags, capabilities, handlers)
    lspconfig['pylsp'].setup {
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        handlers = handlers,
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = { enabled = false, },
                    pyflakes = { enabled = false, },
                    mccabe = { enabled = false, },
                    jedi = {
                        environment = vim.env.VIRTUAL_ENV or '/usr',
                    },
                    jedi_completion = {
                        enabled = true,
                        fuzzy = true,
                        eager = true,
                        resolve_at_most = 25,
                        cache_for = {'numpy', 'pandas', 'torch', 'matplotlib'}
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
                    flake8 = {
                        enabled = false,
                        ignore = {
                            'E501', -- Line too long
                            'E266', -- Too many leading # for block comment
                        }
                    },
                    pylint = {
                        enabled = false,
                        executable = 'pylint',
                    },
                    pylsp_black = {
                        enabled = false,
                        preview = true,
                        max_line_length = 88,
                    },
                    pylsp_mypy = {
                        enabled = false,
                        live_mode = true,
                        strict = false,
                    },
                    pylsp_rope = {
                        enabled = false,
                    },
                    pyls_isort = {
                        enabled = false,
                    }
                }
            }
        }
    }
end

return M
