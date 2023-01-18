local lspconfig = require("lspconfig")

local M = {}

M.setup = function(opts)
    lspconfig["jdtls"].setup({
        capabilities = opts.capabilities,
        flags = opts.lsp_flags,
        handlers = opts.handlers,
        on_attach = opts.on_attach,
    })
end

return M
