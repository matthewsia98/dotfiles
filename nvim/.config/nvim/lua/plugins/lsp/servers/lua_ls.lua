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
                diagnostics = { enable = false }, -- use null-ls luacheck instead
                semantic = { enable = true },
                telemetry = { enable = false },
                workspace = {
                    checkThirdParty = false,
                },
            },
        },
    })
end

return M
