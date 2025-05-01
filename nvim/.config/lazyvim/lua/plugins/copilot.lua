return {
    {

        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = { accept = "<C-y>", dismiss = "<C-c>" },
            },
        },
    },

    {
        "saghen/blink.cmp",
        optional = true,
        opts = function(_, opts)
            local copilot_idx = nil
            for i, v in ipairs(opts.sources.default) do
                if v == "copilot" then
                    copilot_idx = i
                    break
                end
            end
            table.remove(opts.sources.default, copilot_idx)
            opts.sources.providers.copilot = nil
        end,
    },
}
