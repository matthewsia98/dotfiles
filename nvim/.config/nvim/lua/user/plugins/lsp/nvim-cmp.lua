local installed, cmp = pcall(require, "cmp")

if installed then
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- insert ( after choosing function from completion menu
    cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

    cmp.setup({
        -- preselect = cmp.PreselectMode.None, -- breaks cmp signature help
        completion = {
            completeopt = "menu,menuone,noselect",
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                local kind = lspkind.cmp_format({
                    mode = "symbol_text",
                    preset = "default", -- "default" | "codicons"
                    maxwidth = 60,
                    menu = {
                        buffer = "[BUFFER]",
                        path = "[PATH]",
                        nvim_lsp = "[LSP]",
                        nvim_lsp_signature_help = "[SIGN]",
                        luasnip = "[SNIP]",
                        nvim_lua = "[NVIM]",
                        cmdline_history = "[HIST]",
                        cmdline = "[CMD]",
                    },
                })(entry, vim_item)
                local strings = vim.split(vim_item.kind, "%s+", { trimempty = true })
                kind.kind = " " .. string.format("[%s] %s", strings[1], strings[2]) .. " "
                return kind
            end,
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        experimental = {
            ghost_text = false,
        },
        window = {
            completion = {
                border = "rounded",
                winhighlight = "NormalFloat:Normal,CursorLine:PmenuSel",
                col_offset = 0,
                side_padding = 0,
            },
            documentation = {
                border = "rounded",
                winhighlight = "NormalFloat:Normal",
                zindex = 1001,
            },
        },
        view = {
            entries = {
                name = "custom",
                selection_order = "near_cursor",
            },
        },
        mapping = {
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { "i", "c" }),
            ["<C-n>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { "i", "c" }),
            ["<C-p>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "i", "c" }),
            ["<C-Space>"] = cmp.mapping(function(fallback)
                if require("copilot.suggestion").is_visible() then
                    require("copilot.suggestion").accept()
                elseif cmp.visible() then
                    local entry = cmp.get_selected_entry()
                    if not entry then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        cmp.confirm()
                        cmp.close()
                    end
                else
                    fallback()
                end
            end, { "i", "c" }),
            ["<C-c>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.abort()
                else
                    fallback()
                end
            end, { "i", "c" }),
            ["<CR>"] = cmp.mapping(function(fallback)
                if cmp.visible() and cmp.get_selected_entry() then
                    cmp.confirm({ select = false })
                else
                    fallback()
                end
            end),
        },
        sources = {
            -- Order Matters! OR explicitly set priority
            { name = "luasnip", max_item_count = 10 },
            { name = "nvim_lsp", max_item_count = 20 },
            { name = "nvim_lsp_signature_help" },
            { name = "path", max_item_count = 10 },
            { name = "buffer", max_item_count = 10 },
            { name = "nvim_lua", max_item_count = 10 },
        },
    })
    -- Use buffer source for `/`
    cmp.setup.cmdline("/", {
        sources = {
            { name = "buffer", max_item_count = 10 },
            { name = "cmdline_history", max_item_count = 10 },
        },
    })

    -- Use cmdline & path source for ':'
    cmp.setup.cmdline(":", {
        sources = {
            { name = "cmdline", max_item_count = 10 },
            { name = "cmdline_history", max_item_count = 10 },
            { name = "path", max_item_count = 10 },
            { name = "nvim_lua", max_item_count = 10 },
        },
    })

    -- -- Scrollbar
    -- vim.cmd [[highlight PmenuThumb guibg=#C5CDD9 guifg=NONE]]

    -- -- Prompt Menu
    -- vim.cmd [[highlight default link CmpPmenu NormalFloat]]
    -- vim.cmd [[highlight CmpPmenu guibg=#1E1E2E guifg=#89B4FA]] -- completion menu background (guibg) and border (guifg)
    -- vim.cmd [[highlight PmenuSel guibg=#6E738D guifg=NONE]]

    -- -- Completion Items
    -- vim.cmd [[highlight CmpItemMenu guibg=NONE guifg=#C6A0F6]]
    -- vim.cmd [[highlight CmpItemAbbrDeprecated guibg=NONE guifg=#808080 gui=strikethrough]]
    -- vim.cmd [[highlight CmpItemAbbrMatch guibg=NONE guifg=#569CD6]]
    -- vim.cmd [[highlight CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6]]
    -- vim.cmd [[highlight CmpItemKindVariable guibg=NONE guifg=#9CDCFE]]
    -- vim.cmd [[highlight CmpItemKindInterface guibg=NONE guifg=#9CDCFE]]
    -- vim.cmd [[highlight CmpItemKindText guibg=NONE guifg=#9CDCFE]]
    -- vim.cmd [[highlight CmpItemKindFunction guibg=NONE guifg=#C586C0]]
    -- vim.cmd [[highlight CmpItemKindMethod guibg=NONE guifg=#C586C0]]
    -- vim.cmd [[highlight CmpItemKindKeyword guibg=NONE guifg=#D4D4D4]]
    -- vim.cmd [[highlight CmpItemKindProperty guibg=NONE guifg=#D4D4D4]]
    -- vim.cmd [[highlight CmpItemKindUnit guibg=NONE guifg=#D4D4D4]]
    -- vim.cmd [[highlight CmpItemKindSnippet guibg=NONE guifg=#D4AF37]]
end
