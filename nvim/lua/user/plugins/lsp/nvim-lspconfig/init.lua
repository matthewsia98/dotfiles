local installed, _ = pcall(require, "lspconfig")

if installed then
    local notify_installed, notify = pcall(require, "notify")

    local on_attach = function(client, bufnr)
        local name = client["name"]
        if name == "pylsp" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end

        local keys = require("user.keymaps")
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        keys.map("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
        keys.map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", bufopts)
        keys.map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", bufopts)
        keys.map("n", "<leader>dll", "<cmd>lua vim.diagnostic.setloclist()<CR>", bufopts)
        keys.map("n", "<leader>dqf", "<cmd>lua vim.diagnostic.setqflist()<CR>", bufopts)
        keys.map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", bufopts)
        keys.map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
        keys.map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", bufopts)
        keys.map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", bufopts)
        keys.map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
        keys.map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", bufopts)
        keys.map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
        keys.map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
        keys.map({ "n", "v" }, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)
        keys.map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format()<CR>", bufopts)
        -- keys.map('v', '<leader>fm', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', bufopts)
        keys.map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", bufopts)
        keys.map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", bufopts)
        keys.map("n", "<leader>wls", function()
            P(vim.lsp.buf.list_workspace_folders())
        end, vim.tbl_extend("keep", bufopts, { desc = "vim.lsp.buf.list_workspace_folders()" }))
    end

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
                if notify_installed then
                    notify("No definitions found", "info", {
                        title = " LSP",
                        timeout = 1000,
                    })
                end
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
                if notify_installed then
                    notify("No references found", "info", {
                        title = " LSP",
                        timeout = 1000,
                    })
                end
            else
                local client = vim.lsp.get_client_by_id(ctx.client_id)

                local title = " LSP"
                local items = util.locations_to_items(result, client.offset_encoding)

                if #result == 1 then
                    if notify_installed then
                        notify("No other references", "info", {
                            title = title,
                            timeout = 1000,
                        })
                    end
                else
                    vim.fn.setloclist(0, {}, " ", { title = title, items = items, context = ctx })
                    vim.cmd([[Trouble loclist]])
                end
            end
        end,
    }

    require("user.plugins.lsp.nvim-lspconfig.pylsp").setup(on_attach, lsp_flags, capabilities, handlers)
    require("user.plugins.lsp.nvim-lspconfig.sumneko-lua").setup(on_attach, lsp_flags, capabilities, handlers)
    require("user.plugins.lsp.nvim-lspconfig.jdtls").setup(on_attach, lsp_flags, capabilities, handlers)
end
