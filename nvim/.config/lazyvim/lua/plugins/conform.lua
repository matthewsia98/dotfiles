return {
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
            opts.winbar = opts.winbar or {}
            opts.winbar.lualine_a = opts.winbar.lualine_a or {}

            table.insert(opts.winbar.lualine_a, {
                function()
                    return "Formatters: " .. table.concat(require("conform").list_formatters_for_buffer(), ", ")
                end,
                cond = function()
                    return package.loaded["conform"] and #require("conform").list_formatters_for_buffer() > 0
                end,
            })
        end,
    },
}
