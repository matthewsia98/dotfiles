local M = {}

M.set_keymaps = function(bufnr)
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

    local keys = require("user.keymaps")
    local config = require("user.config")
    local trouble_installed, trouble = pcall(require, "trouble")
    local lspsaga_installed, _ = pcall(require, "lspsaga")
    local use_lspsaga = lspsaga_installed and config.lsp.prefer_lspsaga
    local use_trouble = trouble_installed and not use_lspsaga

    keys.map("n", "<leader>d", function()
        if use_lspsaga then
            require("lspsaga.diagnostic"):show_diagnostics("", "line")
        else
            vim.diagnostic.open_float({ scope = "line" })
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

    keys.map("n", "gD", function()
        vim.lsp.buf.declaration()
    end, { buffer = bufnr, desc = "Go to Declaration" })
    keys.map("n", "gd", function()
        if use_lspsaga then
            require("lspsaga.definition"):peek_definition()
        elseif use_trouble then
            trouble.open("lsp_definitions")
        else
            vim.lsp.buf.definition()
        end
    end, { buffer = bufnr, desc = "Go to Definition" })
    keys.map("n", "gr", function()
        if use_lspsaga then
            require("lspsaga.finder"):lsp_finder()
        elseif use_trouble then
            trouble.open("lsp_references")
        else
            vim.lsp.buf.references()
        end
    end, { buffer = bufnr, desc = "Go to References" })
    keys.map("n", "gt", function()
        if use_trouble then
            trouble.open("lsp_type_definitions")
        else
            vim.lsp.buf.type_definition()
        end
    end, { buffer = bufnr, desc = "Go to Type Definition" })
    keys.map("n", "gi", function()
        if use_trouble then
            trouble.open("lsp_implementations")
        else
            vim.lsp.buf.implementation()
        end
    end, { buffer = bufnr, desc = "Go to Implementation" })

    keys.map("n", "K", function()
        local ufo_installed, ufo = pcall(require, "ufo")
        local win_id
        if ufo_installed then
            win_id = ufo.peekFoldedLinesUnderCursor()
        end
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

return M
