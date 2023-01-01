local installed, _ = pcall(require, "lspconfig")

if installed then
    require("lspconfig.ui.windows").default_options.border = "rounded"

    local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
    }

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        }),

        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
        }),

        ["textDocument/definition"] = function(err, result, ctx, config)
            if err ~= nil then
                P(err)
                return
            end

            local util = require("vim.lsp.util")
            if result == nil or vim.tbl_isempty(result) then
                vim.notify("No definitions found", "info", {
                    title = " LSP",
                    timeout = 1000,
                })
            else
                -- textDocument/definition can return Location or Location[]
                -- https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_definition
                config = config or {}
                local client = vim.lsp.get_client_by_id(ctx.client_id)

                if vim.tbl_islist(result) then
                    local title = " LSP"
                    local items = util.locations_to_items(result, client.offset_encoding)

                    if #result == 1 then
                        util.jump_to_location(result[1], client.offset_encoding, config.reuse_win)
                        return
                    else
                        vim.fn.setloclist(0, {}, " ", { title = title, items = items })
                        vim.cmd([[Trouble loclist]])
                    end
                else
                    util.jump_to_location(result, client.offset_encoding, config.reuse_win)
                end
            end
        end,
        ["textDocument/references"] = function(err, result, ctx, _)
            if err ~= nil then
                P(err)
                return
            end

            local util = require("vim.lsp.util")
            if not result or vim.tbl_isempty(result) then
                vim.notify("No references found", "info", {
                    title = " LSP",
                    timeout = 1000,
                })
            else
                local client = vim.lsp.get_client_by_id(ctx.client_id)

                local title = " LSP"
                local items = util.locations_to_items(result, client.offset_encoding)

                if #result == 1 then
                    vim.notify("No other references", "info", {
                        title = title,
                        timeout = 1000,
                    })
                else
                    vim.fn.setloclist(0, {}, " ", { title = title, items = items, context = ctx })
                    vim.cmd([[Trouble loclist]])
                end
            end
        end,
    }

    local on_attach = function(client, bufnr)
        local name = client["name"]
        if name == "pylsp" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end

        local keys = require("user.keymaps")

        keys.map("n", "dg", function()
            vim.diagnostic.open_float()
        end, { buffer = bufnr, desc = "Open Diagnostic Float" })
        keys.map("n", "[d", function()
            vim.diagnostic.goto_prev()
        end, { buffer = bufnr, desc = "Previous Diagnostic" })
        keys.map("n", "]d", function()
            vim.diagnostic.goto_next()
        end, { buffer = bufnr, desc = "Next Diagnostic" })

        keys.map("n", "<leader>dll", function()
            vim.diagnostic.setloclist({ open = false })
            vim.cmd([[Trouble loclist]])
        end, { buffer = bufnr, desc = "Send diagnostics to loclist" })
        keys.map("n", "<leader>dqf", function()
            vim.diagnostic.setqflist({ open = false })
            vim.cmd([[Trouble quickfix]])
        end, { buffer = bufnr, desc = "Send diagnostics to qflist" })

        keys.map("n", "gD", function()
            vim.lsp.buf.declaration()
        end, { buffer = bufnr, desc = "Go to Declaration" })
        keys.map("n", "gd", function()
            vim.lsp.buf.definition()
        end, { buffer = bufnr, desc = "Go to Definition" })
        keys.map("n", "gr", function()
            vim.lsp.buf.references()
        end, { buffer = bufnr, desc = "Go to References" })
        keys.map("n", "gt", function()
            vim.lsp.buf.type_definition()
        end, { buffer = bufnr, desc = "Go to Type Definition" })
        keys.map("n", "gi", function()
            vim.lsp.buf.implementation()
        end, { buffer = bufnr, desc = "Go to Implementation" })

        keys.map("n", "K", function()
            vim.lsp.buf.hover()
        end, { buffer = bufnr, desc = "Hover" })

        keys.map("i", "<C-k>", function()
            vim.lsp.buf.signature_help()
        end, { buffer = bufnr, desc = "Signature Help" })

        keys.map("n", "<leader>rn", function()
            vim.lsp.buf.rename()
        end, { buffer = bufnr, desc = "Rename" })

        keys.map({ "n", "v" }, "<leader>ca", function()
            vim.lsp.buf.code_action()
        end, { buffer = bufnr, desc = "Code Action" })

        keys.map("n", "<leader>fm", function()
            vim.lsp.buf.format()
        end, { buffer = bufnr, desc = "Format" })
        keys.map("v", "<leader>fm", function()
            vim.lsp.buf.range_formatting()
        end, { buffer = bufnr, desc = "Range Format" })

        keys.map("n", "<leader>wa", function()
            vim.lsp.buf.add_workspace_folder()
        end, { buffer = bufnr, desc = "Add workspace folder" })
        keys.map("n", "<leader>wr", function()
            vim.lsp.buf.remove_workspace_folder()
        end, { buffer = bufnr, desc = "Remove workspace folder" })
        keys.map("n", "<leader>wls", function()
            vim.notify(vim.lsp.buf.list_workspace_folders(), "info", {
                title = "Workspace Folders",
            })
        end, { buffer = bufnr, desc = "List workspace folders" })
    end

    require("user.plugins.lsp.nvim-lspconfig.pylsp").setup(on_attach, lsp_flags, capabilities, handlers)
    require("user.plugins.lsp.nvim-lspconfig.sumneko-lua").setup(on_attach, lsp_flags, capabilities, handlers)
    require("user.plugins.lsp.nvim-lspconfig.jdtls").setup(on_attach, lsp_flags, capabilities, handlers)
end
