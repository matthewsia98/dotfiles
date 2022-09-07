local lspconfig = require('lspconfig')

local M = {}

M.setup = function(on_attach, lsp_flags, capabilities)
    lspconfig['jdtls'].setup {
        on_attach = on_attach,
        flags = lsp_flags,
        handlers = handlers,
        capabilities = capabilities,
    }
end

return M
