return {
    "akinsho/bufferline.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function()
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                numbers = "ordinal",
                separator_style = "thin",
                -- Only show if more than 2 buffers (needed for dashboard)
                always_show_bufferline = false,
                show_buffer_close_icons = false,
                show_close_icon = false,
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
