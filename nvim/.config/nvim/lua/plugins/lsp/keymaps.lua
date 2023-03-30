local map = require("keymaps").map
local config = require("config")
local goto_provider = config.lsp.goto_provider or "builtin"
local actions_provider = config.lsp.actions_provider or "builtin"

local M = {}

M.set_keymaps = function(client, bufnr)
    if goto_provider == "trouble" then
        map("n", "gd", "<CMD>Trouble lsp_definitions<CR>", { buffer = bufnr, desc = "Go to Definition" })
        map("n", "gr", "<CMD>Trouble lsp_references<CR>", { buffer = bufnr, desc = "Go to References" })
        map("n", "gt", "<CMD>Trouble lsp_type_definitions<CR>", { buffer = bufnr, desc = "Go to Type Definition" })
        map("n", "gi", "<CMD>Trouble lsp_implementations", { buffer = bufnr, desc = "Go to Implementation" })
    elseif goto_provider == "telescope" then
        map("n", "gd", "<CMD>Telescope lsp_definitions<CR>", { buffer = bufnr, desc = "Go to Definition" })
        map("n", "gr", "<CMD>Telescope lsp_references<CR>", { buffer = bufnr, desc = "Go to References" })
        map("n", "gt", "<CMD>Telescope lsp_type_definitions<CR>", { buffer = bufnr, desc = "Go to Type Definition" })
        map("n", "gi", "<CMD>Telescope lsp_implementations", { buffer = bufnr, desc = "Go to Implementation" })
    elseif goto_provider == "lspsaga" then
        map("n", "gd", "<CMD>Lspsaga peek_definition<CR>", { buffer = bufnr, desc = "Go to Definition" })
        map("n", "gr", "<CMD>Lspsaga lsp_finder<CR>", { buffer = bufnr, desc = "Go to References" })
        map("n", "gt", "<CMD>Lspsaga peek_type_definition<CR>", { buffer = bufnr, desc = "Go to Type Definition" })
        map("n", "gi", "<CMD>Lspsaga lsp_finder<CR>", { buffer = bufnr, desc = "Go to Implementation" })
    else
        map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
        map("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Go to References" })
        map("n", "gt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to Type Definition" })
        map("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to Implementation" })
    end

    if actions_provider == "lspsaga" then
        map(
            "n",
            "<leader>d",
            "<CMD>Lspsaga show_line_diagnostics<CR>",
            { buffer = bufnr, desc = "Open Diagnostic Float" }
        )
        map("n", "[d", "<CMD>Lspsaga diagnostic_jump_prev<CR>", { buffer = bufnr, desc = "Previous Diagnostic" })
        map("n", "]d", "<CMD>Lspsaga diagnostic_jump_next<CR>", { buffer = bufnr, desc = "Next Diagnostic" })
        map("n", "K", "<CMD>Lspsaga hover_doc<CR>", { buffer = bufnr, desc = "Hover" })
        map("n", "<leader>rn", "<CMD>Lspsaga rename<CR>", { buffer = bufnr, desc = "Rename" })
        map({ "n", "v" }, "<leader>ca", "<CMD>Lspsaga code_action<CR>", { buffer = bufnr, desc = "Code Action" })
    else
        map("n", "<leader>d", vim.diagnostic.open_float, { buffer = bufnr, desc = "Open Diagnostic Float" })
        map("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Previous Diagnostic" })
        map("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next Diagnostic" })
        map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
        map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
    end

    map("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Help" })

    -- map("n", "<leader>fm", function()
    --     vim.lsp.buf.format({ name = "null-ls" })
    -- end, { buffer = bufnr, desc = "Format" })

    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = "Add workspace folder" })
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = "Remove workspace folder" })
    map("n", "<leader>wls", function()
        vim.notify(table.concat(vim.lsp.buf.list_workspace_folders(), "\n"), "info", {
            title = "Workspace Folders",
        })
    end, { buffer = bufnr, desc = "List workspace folders" })
end

return M
