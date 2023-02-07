local forward_key = ";"
local backward_key = "-"

return {
    "ggandor/leap.nvim",
    config = function()
        local leap = require("leap")

        -- leap.add_default_mappings()

        leap.opts.max_phase_one_targets = nil
        leap.opts.highlight_unlabeled_phase_one_targets = false
        leap.opts.max_highlighted_traversal_targets = 10
        leap.opts.case_sensitive = false
        leap.opts.special_keys = {
            repeat_search = "<enter>",
            next_phase_one_target = "<enter>",
            next_target = { "<C-n>" },
            prev_target = { "<C-p>" },
            next_group = "<space>",
            prev_group = "<tab>",
            multi_accept = "<enter>",
            multi_revert = "<backspace>",
        }
    end,
    keys = {
        {
            forward_key,
            function()
                require("leap").leap({})
            end,
            desc = "Leap forward to",
        },
        {
            forward_key,
            function()
                require("leap").leap({ offset = 1, inclusive_op = true, match_last_overlapping = true })
            end,
            desc = "Leap forward to",
            mode = { "x", "o" },
        },
        {
            backward_key,
            function()
                require("leap").leap({ backward = true })
            end,
            desc = "Leap backward to",
        },
        {
            backward_key,
            function()
                require("leap").leap({ backward = true, match_last_overlapping = true })
            end,
            desc = "Leap backward to",
            mode = { "x", "o" },
        },
        {
            "g" .. forward_key,
            function()
                require("leap").leap({ target_windows = require("leap.util").get_enterable_windows() })
            end,
            desc = "Leap across window",
        },
    },
}
