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
            documentation = { border = "rounded", winhighlight = "" },
        }

        local cmp = require("cmp")
        opts.preselect = cmp.PreselectMode.None
        opts.mapping["<C-c>"] = cmp.mapping.abort()
        opts.mapping["<CR>"] = cmp.mapping.confirm()
        opts.mapping["<C-CR>"] = cmp.mapping.confirm({ select = true })
    end,
}
