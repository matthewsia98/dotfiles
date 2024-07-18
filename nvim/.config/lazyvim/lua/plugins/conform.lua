return {
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
            opts.winbar = opts.winbar or {}
            opts.winbar.lualine_z = opts.winbar.lualine_z or {}

            table.insert(opts.winbar.lualine_z, {
                function()
                    return table.concat(require("conform").list_formatters_for_buffer(), ", ")
                end,
                cond = function()
                    return package.loaded["conform"] and #require("conform").list_formatters_for_buffer() > 0
                end,
            })
        end,
    },
}
