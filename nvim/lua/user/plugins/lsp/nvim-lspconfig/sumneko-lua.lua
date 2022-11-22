local lspconfig = require("lspconfig")

local M = {}

M.setup = function(on_attach, lsp_flags, capabilities, handlers)
    lspconfig["sumneko_lua"].setup({
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        handlers = handlers,
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                },
                diagnostics = {
                    enable = false,
                    globals = { "vim" },
                    workspaceDelay = -1,
                },
                format = {
                    enable = false,
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    -- library = vim.api.nvim_get_runtime_file("", true),
                    ignoreDir = {
                        "plugged",
                    },
                    useGitIgnore = true,
                    checkThirdParty = false,
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    })
end

return M
