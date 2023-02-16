return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = {
        "nvim-neorg/neorg-telescope",
    },
    cmd = "Neorg",
    ft = "norg",
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.presenter"] = {
                    config = {
                        zen_mode = "zen-mode",
                    },
                },
                ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.norg.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                    },
                },
                ["core.integrations.telescope"] = {},
            },
        })
        local neorg_callbacks = require("neorg.callbacks")

        ---@diagnostic disable-next-line: missing-parameter
        neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
            -- Map all the below keybinds only when the "norg" mode is active
            keybinds.map_event_to_mode("norg", {
                n = { -- Bind keys in normal mode
                    { "<C-s>", "core.integrations.telescope.find_linkable" },
                },

                i = { -- Bind in insert mode
                    { "<C-l>", "core.integrations.telescope.insert_link" },
                },
            }, {
                silent = true,
                noremap = true,
            })
        end)
    end,
}
