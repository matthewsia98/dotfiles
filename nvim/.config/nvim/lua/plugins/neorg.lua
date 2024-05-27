return {
    "nvim-neorg/neorg",
    -- build = ":Neorg sync-parsers",
    dependencies = {
        "nvim-neorg/neorg-telescope",
        "vhyrro/luarocks.nvim",
    },
    cmd = "Neorg",
    event = { "BufReadPre *.norg", "BufNewFile *.norg" },
    -- ft = "norg",
    config = function()
        require("neorg").setup({
            load = {
                -- Loads default behaviour
                ["core.defaults"] = {
                    config = {
                        disable = {},
                    },
                },

                ["core.presenter"] = {
                    config = {
                        zen_mode = "zen-mode",
                    },
                },

                -- Adds pretty icons to your documents
                ["core.concealer"] = {
                    config = {
                        icon_preset = "diamond", -- basic | diamond | varied
                    },
                },

                -- Manages Neorg workspaces
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            uOttawa = "~/uOttawa",
                            ["2023-Winter"] = "~/uOttawa/2023-Winter",
                        },
                        default_workspace = "2023-Winter",
                    },
                },

                -- Export norg files to other formats
                ["core.export"] = {},

                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },

                -- ["core.itero"] = {},
                -- ["core.promo"] = {},

                ["core.integrations.telescope"] = {},
            },
        })
        -- local neorg_callbacks = require("neorg.callbacks")
        --
        -- ---@diagnostic disable-next-line: missing-parameter
        -- neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
        --     -- Map all the below keybinds only when the "norg" mode is active
        --     keybinds.map_event_to_mode("norg", {
        --         n = { -- Bind keys in normal mode
        --             { "<C-s>", "core.integrations.telescope.find_linkable" },
        --         },
        --
        --         i = { -- Bind in insert mode
        --             { "<C-l>", "core.integrations.telescope.insert_link" },
        --         },
        --     }, {
        --         silent = true,
        --         noremap = true,
        --     })
        -- end)
    end,
    keys = {
        { "<leader>nw", "<CMD>Telescope neorg switch_workspace<CR>", desc = "Set Neorg Workspace" },
        { "<leader>ni", "<CMD>Neorg index<CR>", desc = "Go to workspace index.norg" },
        { "<leader>nr", "<CMD>Neorg return<CR>", desc = "Close all norg buffers" },
        { "<leader>ntc", "<CMD>Neorg toggle-concealer<CR>", desc = "Toggle Concealer" },
        { "<leader>nef", ":Neorg export to-file ", desc = "Export File" },
        { "<leader>ned", ":Neorg export directory ", desc = "Export Directory" },
        -- {
        --     "<leader>nef",
        --     function()
        --         local neorg = require("neorg.modules.core.norg.dirman.module").public
        --         local workspace_name, workspace_path = unpack(neorg.get_current_workspace())
        --         vim.api.nvim_feedkeys(":Neorg export to-file " .. workspace_path .. "/", "n", false)
        --     end,
        --     desc = "Export File",
        -- },
        -- {
        --     "<leader>ned",
        --     function()
        --         local neorg = require("neorg.modules.core.norg.dirman.module").public
        --         local workspace_name, workspace_path = unpack(neorg.get_current_workspace())
        --         vim.api.nvim_feedkeys(":Neorg export directory " .. workspace_path .. "/", "n", false)
        --     end,
        --     desc = "Export Directory",
        -- },
        -- {
        --     "<leader>nef",
        --     function()
        --         vim.ui.input({
        --             prompt = "Destination path",
        --         }, function(destination_path)
        --             if destination_path == nil or destination_path:match("^%s*$") then
        --                 return
        --             end
        --
        --             vim.ui.input({
        --                 prompt = "Filetype",
        --             }, function(filetype)
        --                 filetype = (filetype:match("^%s*$")) and nil or filetype
        --                 vim.cmd("Neorg export to-file " .. destination_path .. " " .. filetype)
        --             end)
        --         end)
        --     end,
        --     desc = "",
        -- },
    },
}
