local keys = {
    { "<leader>wd", "<CMD>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics" },
    { "<leader>dd", "<CMD>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics" },
}

local config = require("config")
if config.lsp.goto_provider == "trouble" then
    local lsp_keys = {
        { "gr", "<CMD>TroubleToggle lsp_references<CR>", desc = "Go to References" },
        { "gd", "<CMD>TroubleToggle lsp_definitions<CR>", desc = "Go to Definition" },
        { "gi", "<CMD>TroubleToggle lsp_implementations<CR>", desc = "Go to Implementation" },
    }
    for _, key in ipairs(lsp_keys) do
        table.insert(keys, key)
    end
end

return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup({
            auto_open = false,
            auto_preview = true,
            auto_jump = { "loclist", "quickfix", "lsp_definitions", "lsp_references" },
        })
    end,
    keys = keys,
}
