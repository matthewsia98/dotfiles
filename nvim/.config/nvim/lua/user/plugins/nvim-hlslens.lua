local installed, lens = pcall(require, "hlslens")

if installed then
    lens.setup({
        calm_down = false,
    })

    local keys = require("user.keymaps")
    keys.map({ "n", "x" }, "<leader>L", function()
        lens.exportLastSearchToQuickfix(true)
        vim.cmd([[Trouble loclist]])
        vim.cmd([[noh]])
    end)
end
