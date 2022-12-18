local keys = require("user.keymaps")

-- Next and Prev mappings in ~/.config/nvim/lua/user/plugins/lsp/luasnip.lua
keys.map("i", "<C-Space>", 'copilot#Accept("")', { expr = true, replace_keycodes = false })
keys.map("i", "<C-c>", "copilot#Dismiss()", { expr = true })
keys.map("n", "<leader>cs", function()
    local status = vim.api.nvim_command_output("Copilot status")
    vim.notify(status, "info", {
        title = "Copilot",
    })
end)
keys.map("n", "<leader>ct", function()
    local status = vim.api.nvim_command_output("Copilot status")
    if status:match("Enabled") or status:match("<Tab>") then
        vim.cmd([[ Copilot disable ]])
        vim.notify("Copilot disabled", "info", {
            title = "Copilot",
        })
    else
        vim.cmd([[ Copilot enable ]])
        vim.notify("Copilot enabled", "info", {
            title = "Copilot",
        })
    end
end)
