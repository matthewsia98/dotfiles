return {
    "akinsho/bufferline.nvim",
    enabled = true,
    event = "VeryLazy",
    config = function()
        local bufferline = require("bufferline")
        local catppuccin = require("catppuccin.palettes").get_palette()
        local background = catppuccin.base
        local active_bg = catppuccin.crust
        local inactive_bg = catppuccin.mantle

        bufferline.setup({
            options = {
                numbers = "ordinal",
                separator_style = "slant", -- "slant" | "padded_slant" | "slope" | "thick" | "thin" | { "|", "|" }
                -- Only show if more than 2 buffers (needed for dashboard)
                always_show_bufferline = true,
                show_buffer_close_icons = false,
                show_close_icon = false,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer", -- "File Explorer" | function ,
                        text_align = "center",
                        separator = false,
                    },
                    {
                        filetype = "toggleterm",
                        text = "Terminal",
                        text_align = "center",
                        separator = false,
                    },
                },
            },
            ---@diagnostic disable-next-line: assign-type-mismatch
            highlights = require("catppuccin.groups.integrations.bufferline").get({
                styles = { "bold", "italic" },
                custom = {
                    all = {
                        fill = { bg = background },

                        -- Inactive
                        background = { bg = inactive_bg },
                        -- Active
                        buffer_selected = { bg = active_bg },
                        -- Inactive but displayed in window
                        buffer_visible = { bg = inactive_bg },

                        tab = { bg = inactive_bg },
                        tab_selected = { bg = active_bg },

                        numbers = { bg = inactive_bg },
                        numbers_visible = { bg = inactive_bg },
                        numbers_selected = { bg = active_bg },

                        separator = { bg = inactive_bg, fg = background },
                        separator_selected = { bg = active_bg, fg = background },
                        separator_visible = { bg = inactive_bg, fg = background },

                        tab_separator = { bg = inactive_bg, fg = inactive_bg },
                        tab_separator_selected = { bg = active_bg, fg = active_bg },

                        modified_selected = { bg = active_bg },
                        modified_visible = { bg = inactive_bg },
                    },
                },
            }),
        })

        local map = require("keymaps").map
        for n = 1, 9 do
            map(
                "n",
                "<leader>" .. n,
                string.format([[<CMD>lua require("bufferline").go_to_buffer(%d, true)<CR>]], n),
                { desc = "Go to Buffer " .. n }
            )
        end
    end,
}
