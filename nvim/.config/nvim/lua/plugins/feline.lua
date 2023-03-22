return {
    "freddiehaddad/feline.nvim",
    event = "VeryLazy",
    enabled = require("config").statusline == "feline",
    config = function()
        local catppuccin_feline = require("catppuccin.groups.integrations.feline")
        local catppuccin_components = catppuccin_feline.get()

        local feline = require("feline")

        feline.setup({
            components = catppuccin_components,
        })

        feline.winbar.setup({
            components = {
                active = {
                    {
                        {
                            provider = function()
                                return " " .. table.concat(vim.split(vim.fn.getcwd(), "/", { trimempty = true }), " > ")
                            end,
                            hl = catppuccin_components.active[1][2].hl,
                        },
                        {
                            provider = catppuccin_components.active[1][3].provider,
                            hl = catppuccin_components.active[1][3].hl,
                        },
                        {
                            provider = function()
                                local navic = require("nvim-navic").get_location()
                                if navic ~= "" then
                                    navic = " > " .. require("nvim-navic").get_location()
                                end
                                return navic
                            end,
                            hl = "Normal",
                        },
                    },
                    {},
                    {},
                },
                inactive = { {} },
            },
        })
    end,
}
