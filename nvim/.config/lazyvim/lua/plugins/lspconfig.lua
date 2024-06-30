return {
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
            opts.winbar = opts.winbar or {}
            opts.winbar.lualine_a = opts.winbar.lualine_a or {}

            table.insert(opts.winbar.lualine_a, 1, {
                function()
                    local clients = vim.lsp.get_clients()
                    local client_names = {}
                    for _, client in pairs(clients) do
                        table.insert(client_names, client.name)
                    end
                    return "Language Servers: " .. table.concat(client_names, ", ")
                end,
                cond = function()
                    return package.loaded["lspconfig"] and #vim.lsp.get_clients() > 0
                end,
            })
        end,
    },
}
