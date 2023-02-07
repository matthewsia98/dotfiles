local map = require("keymaps").map
local config = require("config")

local M = {}

M.set_keymaps = function(client, bufnr)
    map("n", "<leader>d", function()
        vim.diagnostic.open_float({ scope = "line" })
    end, { buffer = bufnr, desc = "Open Diagnostic Float" })

    map("n", "[d", function()
        vim.diagnostic.goto_prev()
    end, { buffer = bufnr, desc = "Previous Diagnostic" })
    map("n", "]d", function()
        vim.diagnostic.goto_next()
    end, { buffer = bufnr, desc = "Next Diagnostic" })

    if config.lsp.goto_provider == "buiitlin" then
        map("n", "gd", function()
            vim.lsp.buf.definition()
        end, { buffer = bufnr, desc = "Go to Definition" })
        map("n", "gr", function()
            vim.lsp.buf.references()
        end, { buffer = bufnr, desc = "Go to References" })
        map("n", "gi", function()
            vim.lsp.buf.implementation()
        end, { buffer = bufnr, desc = "Go to Implementation" })
    end

    map("n", "K", function()
        if not require("ufo").peekFoldedLinesUnderCursor() then
            vim.lsp.buf.hover()
        end
    end, { buffer = bufnr, desc = "Hover" })

    map("i", "<C-s>", function()
        vim.lsp.buf.signature_help()
    end, { buffer = bufnr, desc = "Signature Help" })

    map("n", "<leader>rn", function()
        vim.lsp.buf.rename()
    end, { buffer = bufnr, desc = "Rename" })

    map({ "n", "v" }, "<leader>ca", function()
        vim.lsp.buf.code_action()
    end, { buffer = bufnr, desc = "Code Action" })

    map("n", "<leader>fm", function()
        vim.lsp.buf.format({ name = "null-ls" })
    end, { buffer = bufnr, desc = "Format" })

    map("n", "<leader>wa", function()
        vim.lsp.buf.add_workspace_folder()
    end, { buffer = bufnr, desc = "Add workspace folder" })
    map("n", "<leader>wr", function()
        vim.lsp.buf.remove_workspace_folder()
    end, { buffer = bufnr, desc = "Remove workspace folder" })
    map("n", "<leader>wls", function()
        vim.notify(table.concat(vim.lsp.buf.list_workspace_folders(), "\n"), "info", {
            title = "Workspace Folders",
        })
    end, { buffer = bufnr, desc = "List workspace folders" })
end

return M
