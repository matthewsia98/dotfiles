return {
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
            opts.winbar = opts.winbar or {}
            opts.winbar.lualine_a = opts.winbar.lualine_a or {}

            table.insert(opts.winbar.lualine_a, 1, {
                function()
                    local linters = require("lint").linters_by_ft[vim.bo.filetype]
                    return "Linters: " .. table.concat(linters, ", ")
                end,
                cond = function()
                    return package.loaded["lint"]
                        and require("lint").linters_by_ft[vim.bo.filetype]
                        and #require("lint").linters_by_ft[vim.bo.filetype] > 0
                end,
            })
        end,
    },
}
