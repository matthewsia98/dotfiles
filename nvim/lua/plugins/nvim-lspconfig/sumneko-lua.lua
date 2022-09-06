local lspconfig = require('lspconfig')

lspconfig['sumneko_lua'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    handlers = handlers,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
                workspaceDelay = -1,
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
                ignoreDir = {
                    'plugged',
                },
                useGitIgnore = true,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
