return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    config = function()
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                numbers = "ordinal",
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer", -- "File Explorer" | function ,
                        text_align = "center",
                        separator = true,
                    },
                    {
                        filetype = "toggleterm",
                        text = "Terminal",
                        text_align = "center",
                        separator = true,
                    },
                },
            },
            highlights = require("catppuccin.groups.integrations.bufferline").get({})(),
        })

        local map = require("keymaps").map
        for n = 1, 9 do
            map("n", "<leader>" .. n, "<CMD>BufferLineGoToBuffer" .. n .. "<CR>", { desc = "Go to Buffer " .. n })
        end
    end,
}
