local rust_tools = require("rust-tools")

rust_tools.setup({
    server = {
        on_attach = function(client, bufnr)
            require("plugins.lsp.nvim_lspconfig").on_attach(client, bufnr)
        end,
    },
    inlay_hints = {
        auto = false,
    },
})
