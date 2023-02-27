return {
    "stevearc/dressing.nvim",
    init = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
            require("lazy").load({ plugins = { "dressing.nvim" } })
            return vim.ui.input(...)
        end

        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
            require("lazy").load({ plugins = { "dressing.nvim" } })
            return vim.ui.select(...)
        end
    end,
    config = function()
        require("dressing").setup({
            input = {
                enabled = true,
                relative = "editor",
                prompt_align = "center",
            },
            select = {
                enabled = true,
            },
        })
    end,
}
