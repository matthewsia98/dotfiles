return {
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            require("lspconfig.ui.windows").default_options.border = "rounded"

            opts.inlay_hints.enabled = false
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
            opts.winbar = opts.winbar or {}
            opts.winbar.lualine_z = opts.winbar.lualine_z or {}

            table.insert(opts.winbar.lualine_z, 1, {
                function()
                    local clients = vim.lsp.get_clients()
                    local client_names = {}
                    for _, client in pairs(clients) do
                        table.insert(client_names, client.name)
                    end
                    return table.concat(client_names, ", ")
                end,
                cond = function()
                    return package.loaded["lspconfig"] and #vim.lsp.get_clients() > 0
                end,
            })
        end,
    },
}
