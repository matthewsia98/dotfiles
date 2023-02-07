return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "dmitmel/cmp-cmdline-history",
        "onsails/lspkind.nvim",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local copilot_suggestion = require("copilot.suggestion")

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
                        preset = "default", -- "default" | "codicons"
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
                        },
                        symbol_map = {
                            Copilot = "",
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
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                    else
                        fallback()
                    end
                end, { "i", "c" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                    else
                        fallback()
                    end
                end, { "i", "c" }),
                ["<C-n>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                    elseif vim.fn.mode() == "i" and not luasnip.choice_active() then
                        copilot_suggestion.next()
                    else
                        fallback()
                    end
                end, { "i", "c" }),
                ["<C-p>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                    elseif vim.fn.mode() == "i" and not luasnip.choice_active() then
                        copilot_suggestion.prev()
                    else
                        fallback()
                    end
                end, { "i", "c" }),
                ["<C-Space>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
                    elseif copilot_suggestion.is_visible() then
                        copilot_suggestion.accept()
                    else
                        fallback()
                    end
                end, { "i", "c" }),
                ["<C-c>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.abort()
                    elseif copilot_suggestion.is_visible() then
                        copilot_suggestion.dismiss()
                    else
                        fallback()
                    end
                end, { "i", "c" }),
                ["<C-f>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.scroll_docs(4)
                    else
                        fallback()
                    end
                end, { "i" }),
                ["<C-b>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.scroll_docs(-4)
                    else
                        fallback()
                    end
                end, { "i" }),
                ["<CR>"] = cmp.mapping(function(fallback)
                    if cmp.visible() and cmp.get_selected_entry() then
                        cmp.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })
                    else
                        fallback()
                    end
                end, { "i" }),
            },
            sources = {
                -- Order Matters! OR explicitly set priority
                { name = "luasnip", max_item_count = 5 },
                { name = "nvim_lsp", max_item_count = 10 },
                -- { name = "nvim_lsp_signature_help" }, -- handled by noice
                { name = "path", max_item_count = 5 },
                { name = "buffer", max_item_count = 5 },
            },
        })

        cmp.setup.cmdline("/", {
            sources = {
                { name = "buffer", max_item_count = 10 },
            },
        })

        cmp.setup.cmdline(":", {
            sources = {
                { name = "cmdline_history", max_item_count = 5 },
                { name = "cmdline", max_item_count = 10 },
                { name = "nvim_lsp", max_item_count = 10 },
                { name = "path", max_item_count = 5 },
            },
        })
    end,
}
