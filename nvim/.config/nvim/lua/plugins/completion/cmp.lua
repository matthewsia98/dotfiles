local cmp = require("cmp")

cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
cmp.event:on("menu_opened", function()
    vim.b.copilot_suggestion_hidden = true
end)
cmp.event:on("menu_closed", function()
    vim.b.copilot_suggestion_hidden = false
end)

cmp.setup({
    completion = {
        completeopt = "menu,menuone,noselect",
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({
                mode = "symbol_text",
                preset = "codicons", -- "default" | "codicons"
                maxwidth = 60,
                menu = {
                    buffer = "[BUFFER]",
                    copilot = "[COPILOT]",
                    path = "[PATH]",
                    nvim_lsp = "[LSP]",
                    nvim_lsp_signature_help = "[SIGN]",
                    luasnip = "[SNIP]",
                    nvim_lua = "[NVIM]",
                    cmdline_history = "[HIST]",
                    cmdline = "[CMD]",
                    neorg = "[NEORG]",
                },
                symbol_map = {
                    Copilot = "",
                },
            })(entry, vim_item)

            -- vim_item.kind = " Text",
            local strings = vim.split(vim_item.kind, "%s+", { trimempty = true })
            kind.kind = string.format(" [%s] %s ", strings[1], strings[2])
            return kind
        end,
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        completion = {
            border = "rounded",
            -- Default: winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
            winhighlight = "CursorLine:PmenuSel,Search:None",
            col_offset = 0,
            side_padding = 0,
        },
        documentation = {
            border = "rounded",
            -- Default: winhighlight = "FloatBorder:NormalFloat",
            winhighlight = "FloatBorder:FloatBorder",
            zindex = 1001,
        },
    },
    view = {
        entries = {
            name = "custom",
            selection_order = "near_cursor",
        },
    },
    mapping = {},
    sources = {
        -- Order Matters! OR explicitly set priority
        { name = "luasnip", max_item_count = 5 },
        { name = "nvim_lsp", max_item_count = 10 },
        -- { name = "nvim_lsp_signature_help" }, -- handled by noice
        { name = "path", max_item_count = 5 },
        { name = "buffer", max_item_count = 5 },
        { name = "neorg" },
    },
})
