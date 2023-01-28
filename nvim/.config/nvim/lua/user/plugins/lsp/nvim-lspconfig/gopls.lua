local M = {}

M.setup = function(opts)
    local lspconfig = require("lspconfig")
    lspconfig["gopls"].setup({
        capabilities = opts.capabilities,
        flags = opts.flags,
        handlers = opts.handlers,
        on_attach = opts.on_attach,

        settings = {},
    })
end

return M