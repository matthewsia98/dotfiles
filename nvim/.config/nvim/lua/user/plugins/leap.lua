local installed, leap = pcall(require, "leap")

if installed then
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

    local keys = require("user.keymaps")
    local forward_key = ";"
    local backward_key = "-"

    -- Leap Forward
    keys.map("n", forward_key, function()
        leap.leap({})
    end, { desc = "Leap Forward To" })
    keys.map({ "x", "o" }, forward_key, function()
        leap.leap({ offset = 1, inclusive_op = true, match_last_overlapping = true })
    end, { desc = "Leap Forward To" })

    -- Leap Backward
    keys.map("n", backward_key, function()
        leap.leap({ backward = true })
    end, { desc = "Leap Backward To" })
    keys.map({ "x", "o" }, backward_key, function()
        leap.leap({ backward = true, match_last_overlapping = true })
    end, { desc = "Leap Backward To" })

    -- Leap Cross Window
    keys.map("n", "g" .. forward_key, function()
        leap.leap({ target_windows = require("leap.util").get_enterable_windows() })
    end, { desc = "Leap Cross Window" })
end
