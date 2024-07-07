return {
    "nvim-cmp",
    opts = function(_, opts)
        opts.completion = {
            completeopt = "menu,menuone,noinsert,noselect",
        }

        opts.window = {
            completion = {
                border = "rounded",
                winhighlight = "CursorLine:PmenuSel",
            },
            documentation = {
                border = "rounded",
                winhighlight = "",
            },
        }

        opts.view = {
            entries = {
                selection_order = "near_cursor",
            },
        }

        local cmp = require("cmp")
        opts.preselect = cmp.PreselectMode.None
        opts.mapping["<C-c>"] = cmp.mapping.abort()
        opts.mapping["<C-y>"] = cmp.mapping.complete()
        opts.mapping["<CR>"] = cmp.mapping.confirm()
        opts.mapping["<C-Space>"] = cmp.mapping.confirm({ select = true })
    end,
}
