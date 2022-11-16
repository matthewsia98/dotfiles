local lspconfig = require("lspconfig")

local M = {}

M.setup = function(on_attach, lsp_flags, capabilities, handlers)
    lspconfig["jdtls"].setup({
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        handlers = handlers,
    })
end

return M
