local installed, _ = pcall(require, "lspconfig")

if installed then
    require("lspconfig.ui.windows").default_options.border = "rounded"

    local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
    }

    local cmp_installed, cmp = pcall(require, "cmp_nvim_lsp")
    local capabilities = cmp_installed and cmp.default_capabilities() or nil

    local function on_list(options)
        vim.fn.setloclist(0, {}, " ", options)
        require("trouble").open("loclist")
    end

    local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        }),

        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
        }),

        ["textDocument/definition"] = vim.lsp.with(vim.lsp.handlers["textDocument/definition"], {
            on_list = on_list,
        }),

        ["textDocument/references"] = vim.lsp.with(vim.lsp.handlers["textDocument/references"], {
            on_list = on_list,
        }),
    }

    local on_attach = function(client, bufnr)
        -- Disable semantic highlighting by server
        -- sumneko lua highlights comments when toggling
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

        local keys = require("user.keymaps")

        local wk_installed, wk = pcall(require, "which-key")
        if wk_installed then
            wk.register({
                g = {
                    name = "Go To",
                },
                ["<leader>"] = {
                    d = {
                        name = "Diagnostic",
                    },
                    w = {
                        name = "Workspace",
                    },
                },
            })
        end

        local config = require("user.config")
        local lspsaga_installed, _ = pcall(require, "lspsaga")
        local use_lspsaga = lspsaga_installed and config.lsp.prefer_lspsaga

        keys.map("n", "<leader>d", function()
            if use_lspsaga then
                -- local line_diagnostics = require("user.functions").get_current_line_diagnostics()
                -- if #line_diagnostics > 1 then
                --     require("lspsaga.diagnostic"):show_diagnostics("", "line")
                -- else
                --     require("lspsaga.diagnostic"):show_diagnostics("", "cursor")
                -- end
                require("lspsaga.diagnostic"):show_diagnostics("", "line")
            else
                vim.diagnostic.open_float()
            end
        end, { buffer = bufnr, desc = "Open Diagnostic Float" })

        keys.map("n", "[d", function()
            if use_lspsaga then
                require("lspsaga.diagnostic"):goto_prev()
            else
                vim.diagnostic.goto_prev()
            end
        end, { buffer = bufnr, desc = "Previous Diagnostic" })
        keys.map("n", "]d", function()
            if use_lspsaga then
                require("lspsaga.diagnostic"):goto_next()
            else
                vim.diagnostic.goto_next()
            end
        end, { buffer = bufnr, desc = "Next Diagnostic" })

        keys.map("n", "<leader>dl", function()
            vim.diagnostic.setloclist({ open = false })
            vim.cmd([[Trouble loclist]])
        end, { buffer = bufnr, desc = "Send diagnostics to loclist" })
        keys.map("n", "<leader>dq", function()
            vim.diagnostic.setqflist({ open = false })
            vim.cmd([[Trouble quickfix]])
        end, { buffer = bufnr, desc = "Send diagnostics to qflist" })

        keys.map("n", "gD", function()
            vim.lsp.buf.declaration()
        end, { buffer = bufnr, desc = "Go to Declaration" })
        keys.map("n", "gd", function()
            if use_lspsaga then
                require("lspsaga.definition"):peek_definition()
            else
                vim.lsp.buf.definition()
            end
        end, { buffer = bufnr, desc = "Go to Definition" })
        keys.map("n", "gr", function()
            if use_lspsaga then
                require("lspsaga.finder"):lsp_finder()
            else
                vim.lsp.buf.references()
            end
        end, { buffer = bufnr, desc = "Go to References" })
        keys.map("n", "gt", function()
            vim.lsp.buf.type_definition()
        end, { buffer = bufnr, desc = "Go to Type Definition" })
        keys.map("n", "gi", function()
            vim.lsp.buf.implementation()
        end, { buffer = bufnr, desc = "Go to Implementation" })

        keys.map("n", "K", function()
            local win_id = require("ufo").peekFoldedLinesUnderCursor()
            if not win_id then
                if use_lspsaga then
                    require("lspsaga.hover"):render_hover_doc()
                else
                    vim.lsp.buf.hover()
                end
            end
        end, { buffer = bufnr, desc = "Hover" })

        keys.map("i", "<C-s>", function()
            vim.lsp.buf.signature_help()
        end, { buffer = bufnr, desc = "Signature Help" })

        keys.map("n", "<leader>rn", function()
            if use_lspsaga then
                require("lspsaga.rename"):lsp_rename()
            else
                vim.lsp.buf.rename()
            end
        end, { buffer = bufnr, desc = "Rename" })

        keys.map({ "n", "v" }, "<leader>ca", function()
            if use_lspsaga then
                require("lspsaga.codeaction"):code_action()
            else
                vim.lsp.buf.code_action()
            end
        end, { buffer = bufnr, desc = "Code Action" })

        keys.map("n", "<leader>fm", function()
            local lsp_clients = vim.lsp.get_active_clients({ bufnr = bufnr })

            for _, lsp_client in ipairs(lsp_clients) do
                if lsp_client.server_capabilities.documentFormattingProvider then
                    vim.lsp.buf.format()
                    vim.notify("Formatted with " .. lsp_client.name, "info", {
                        title = "LSP",
                        timeout = 500,
                    })
                    break
                end
            end
        end, { buffer = bufnr, desc = "Format" })
        keys.map("v", "<leader>fm", function()
            local lsp_clients = vim.lsp.get_active_clients({ bufnr = bufnr })

            for _, lsp_client in ipairs(lsp_clients) do
                if lsp_client.server_capabilities.documentRangeFormattingProvider then
                    local _, start_row, _, _ = unpack(vim.fn.getpos("'<"))
                    local _, end_row, _, _ = unpack(vim.fn.getpos("'>"))
                    vim.lsp.buf.format({
                        range = {
                            ["start"] = { start_row, 0 },
                            ["end"] = { end_row, 0 },
                        },
                    })
                    vim.notify("Formatted with " .. lsp_client.name, "info", {
                        title = "LSP",
                        timeout = 500,
                    })
                    break
                end
            end
        end, { buffer = bufnr, desc = "Range Format" })

        keys.map("n", "<leader>wa", function()
            vim.lsp.buf.add_workspace_folder()
        end, { buffer = bufnr, desc = "Add workspace folder" })
        keys.map("n", "<leader>wr", function()
            vim.lsp.buf.remove_workspace_folder()
        end, { buffer = bufnr, desc = "Remove workspace folder" })
        keys.map("n", "<leader>wls", function()
            vim.notify(table.concat(vim.lsp.buf.list_workspace_folders(), "\n"), "info", {
                title = "Workspace Folders",
            })
        end, { buffer = bufnr, desc = "List workspace folders" })
    end

    local config = require("user.config")
    for _, lsp_name in ipairs(config.lsp.lsps_to_configure) do
        local config_file = vim.fn.expand("~/.config/nvim/lua/user/plugins/lsp/nvim-lspconfig/" .. lsp_name .. ".lua")
        local file_exists = vim.fn.filereadable(config_file)

        if file_exists ~= 0 then
            require("user.plugins.lsp.nvim-lspconfig." .. lsp_name).setup({
                capabilities = capabilities,
                flags = lsp_flags,
                handlers = handlers,
                on_attach = on_attach,
            })
        else
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
