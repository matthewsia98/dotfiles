local M = {}

M.setup = function(opts)
    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup({
        capabilities = opts.capabilities,
        flags = opts.flags,
        handlers = opts.handlers,
        on_attach = opts.on_attach,

        settings = {
            Lua = {
                -- semantic = { enable = false },
                telemetry = { enable = false },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    checkThirdParty = false,
                },
            },
        },
    })
end

return M
