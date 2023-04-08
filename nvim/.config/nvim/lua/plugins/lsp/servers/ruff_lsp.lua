local M = {}

M.setup = function(opts)
    local lspconfig = require("lspconfig")
    lspconfig.ruff_lsp.setup({
        capabilities = opts.capabilities,
        flags = opts.flags,
        handlers = opts.handlers,
        on_attach = opts.on_attach,

        init_options = {
            settings = {
                -- Any extra CLI arguments for ruff go here
                args = {},
            },
        },
    })
end

return M
