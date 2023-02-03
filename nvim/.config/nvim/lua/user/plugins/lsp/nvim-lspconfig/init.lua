local installed, _ = pcall(require, "lspconfig")

if installed then
    require("lspconfig.ui.windows").default_options.border = "rounded"

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
    }

    local cmp_installed, cmp = pcall(require, "cmp_nvim_lsp")
    if cmp_installed then
        capabilities = cmp.default_capabilities()
    end

    local handlers = {
        -- Hover and Signature Help overridden by Noice
        -- ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        --     border = "rounded",
        -- }),
        --
        -- ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        --     border = "rounded",
        -- }),
        --
        -- ["textDocument/definition"] = vim.lsp.with(vim.lsp.handlers["textDocument/definition"], {
        --     on_list = on_list,
        -- }),
        --
        -- ["textDocument/references"] = vim.lsp.with(vim.lsp.handlers["textDocument/references"], {
        --     on_list = on_list,
        -- }),
    }

    local on_attach = function(client, bufnr)
        -- Set up keymaps defined in ~/.config/nvim/lua/user/plugins/lsp/keymaps.lua
        require("user.plugins.lsp.keymaps").set_keymaps(bufnr)

        -- Disable semantic highlighting by server (sumneko lua highlights comments when toggling)
        local servers_disable_semantic_highlighting = { "sumneko_lua" }
        if vim.tbl_contains(servers_disable_semantic_highlighting, client.name) then
            client.server_capabilities.semanticTokensProvider = nil
        end

        -- Disable formatting capabilities for some servers
        local servers_disable_formatting = { "pylsp", "sumneko_lua", "jdtls", "rust_analyzer", "gopls", "clangd" }
        if vim.tbl_contains(servers_disable_formatting, client.name) then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end
    end

    local config = require("user.config")
    for _, lsp_name in ipairs(config.lsp.lsps_to_configure) do
        local config_file = vim.fn.expand("~/.config/nvim/lua/user/plugins/lsp/nvim-lspconfig/" .. lsp_name .. ".lua")
        local file_exists = vim.fn.filereadable(config_file) ~= 0

        if file_exists then
            require("user.plugins.lsp.nvim-lspconfig." .. lsp_name).setup({
                capabilities = capabilities,
                flags = flags,
                handlers = handlers,
                on_attach = on_attach,
            })
        else
            -- Automatically create ~/.config/nvim/lua/user/plugins/lsp/nvim-lspconfig/<server-name>.lua
            local file = io.open(config_file, "w")

            local content = string.format(
                [[
    local M = {}

    M.setup = function(opts)
        local lspconfig = require("lspconfig")
        lspconfig["%s"].setup({
            capabilities = opts.capabilities,
            flags = opts.flags,
            handlers = opts.handlers,
            on_attach = opts.on_attach,

            settings = {},
        })
    end

    return M]],
                lsp_name
            )

            if file then
                file:write(content)
                file:close()
            end
        end
    end
end
