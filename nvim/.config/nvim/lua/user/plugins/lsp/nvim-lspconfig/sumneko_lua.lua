local lspconfig = require("lspconfig")

local M = {}

M.setup = function(opts)
    lspconfig["sumneko_lua"].setup({
        capabilities = opts.capabilities,
        flags = opts.lsp_flags,
        handlers = opts.handlers,
        on_attach = opts.on_attach,
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                },
                diagnostics = {
                    enable = true,
                    globals = {},
                    workspaceDelay = -1,
                },
                format = {
                    enable = false,
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    -- library = vim.api.nvim_get_runtime_file("", true),
                    -- ignoreDir = {
                    --     "plugged",
                    -- },
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
