local M = {}

M.setup = function(opts)
    opts.capabilities.textDocument.completion.completionItem.snippetSupport = false

    local lspconfig = require("lspconfig")
    lspconfig.html.setup({
        capabilities = opts.capabilities,
        flags = opts.flags,
        handlers = opts.handlers,
        on_attach = opts.on_attach,

        settings = {},
    })
end

return M
