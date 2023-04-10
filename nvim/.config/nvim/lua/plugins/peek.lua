return {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    ft = "markdown",
    config = function()
        local peek = require("peek")
        peek.setup({
            theme = "dark",
            syntax = true,
            update_on_change = true,
        })

        local map = require("keymaps").map
        map("n", "<leader>md", function()
            if peek.is_open() then
                if vim.fn.executable("hyprctl") == 1 then
                    vim.fn.system("hyprctl keyword misc:enable_swallow 1")
                end
                peek.close()
            else
                if vim.fn.executable("hyprctl") then
                    vim.fn.system("hyprctl keyword misc:enable_swallow 0")
                end
                peek.open()
            end
        end, { desc = "Toggle Markdown Preview" })
    end,
}
