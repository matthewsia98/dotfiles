local map = require("keymaps").map

local function feedkeys(lhs, mode, dont_replace_termcodes)
    mode = mode or "im"

    local keys = lhs
    local replace_termcodes = not dont_replace_termcodes
    if replace_termcodes then
        keys = vim.api.nvim_replace_termcodes(lhs, true, false, true)
    end

    vim.api.nvim_feedkeys(keys, mode, false)
end

local M = {}

M.set_keymaps = function()
    -- map("i", "<C-y>", function()
    --     require("cmp").complete()
    -- end, { desc = "Trigger completion" })

    map("c", "<C-n>", function()
        local cmp = require("cmp")
        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
            -- for cmp-cmdline-history
            feedkeys("<C-n>", "n")
        end
    end, { desc = "Cmp Next" })
    map("i", "<C-n>", function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local copilot = require("copilot.suggestion")
        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif luasnip.choice_active() then
            luasnip.change_choice(1)
        elseif #vim.lsp.get_active_clients({ bufnr = 0, name = "copilot" }) > 0 then
            copilot.next()
        end
    end, { desc = "Cmp / Luasnip / Copilot Next" })

    map("c", "<C-p>", function()
        local cmp = require("cmp")
        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
            feedkeys("<C-p>", "n")
        end
    end, { desc = "Cmp Previous" })
    map("i", "<C-p>", function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local copilot = require("copilot.suggestion")
        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        elseif luasnip.choice_active() then
            luasnip.change_choice(-1)
        elseif #vim.lsp.get_active_clients({ bufnr = 0, name = "copilot" }) then
            copilot.prev()
        else
            -- for cmp-cmdline-history
            feedkeys("<C-p>")
        end
    end, { desc = "Cmp / Luasnip / Copilot Previous" })

    map("i", "<CR>", function()
        local cmp = require("cmp")
        if cmp.visible() and cmp.get_selected_entry() then
            cmp.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })
        elseif pcall(require, "nvim-autopairs") then
            feedkeys(require("nvim-autopairs").autopairs_cr(), "n", true)
        else
            feedkeys("<CR>", "n")
        end
    end, { desc = "Cmp confirm selected" })
    map("c", "<CR>", function()
        local cmp = require("cmp")
        if cmp.visible() and cmp.get_selected_entry() then
            cmp.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })
        else
            feedkeys("<CR>", "n")
        end
    end, { desc = "Cmp confirm selected" })

    map({ "i", "c" }, "<C-c>", function()
        local cmp = require("cmp")
        local copilot = require("copilot.suggestion")
        if cmp.visible() then
            cmp.abort()
        elseif copilot.is_visible() then
            copilot.dismiss()
        else
            feedkeys("<C-c>", "n")
        end
    end, { desc = "Cmp / Copilot cancel" })

    map({ "i", "c" }, "<C-Space>", function()
        local cmp = require("cmp")
        local copilot = require("copilot.suggestion")
        if cmp.visible() then
            if cmp.get_selected_entry() then
                cmp.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })
            else
                cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
            end
        elseif copilot.is_visible() then
            copilot.accept_line()
        end
    end, { desc = "Cmp accept / Copilot accept line" })
    map("i", "<C-CR>", function()
        local copilot = require("copilot.suggestion")
        if copilot.is_visible() then
            copilot.accept()
        end
    end, { desc = "Copilot accept" })

    map({ "n", "i" }, "<C-f>", function()
        if not require("noice.lsp").scroll(4) then
            local cmp = require("cmp")
            if cmp.visible() then
                cmp.scroll_docs(4)
            end
        end
    end, { desc = "Cmp scroll down" })

    map({ "n", "i" }, "<C-b>", function()
        if not require("noice.lsp").scroll(4) then
            local cmp = require("cmp")
            if cmp.visible() then
                cmp.scroll_docs(-4)
            end
        end
    end, { desc = "Cmp scroll up" })

    map({ "i", "s" }, "<C-l>", function()
        local luasnip = require("luasnip")
        if luasnip.jumpable(1) then
            luasnip.jump(1)
        end
    end, { desc = "Luasnip jump to next" })
    map({ "i", "s" }, "<C-h>", function()
        local luasnip = require("luasnip")
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        end
    end, { desc = "Luasnip jump to previous" })

    map("s", "<C-n>", function()
        local luasnip = require("luasnip")
        if luasnip.choice_active() then
            luasnip.change_choice(1)
        end
    end, { desc = "Luasnip Next Choice" })
    map("s", "<C-p>", function()
        local luasnip = require("luasnip")
        if luasnip.choice_active() then
            luasnip.change_choice(-1)
        end
    end, { desc = "Luasnip Previous Choice" })

    map({ "i", "s" }, "<C-u>", function()
        require("luasnip.extras.select_choice")()
    end, { desc = "Luasnip Select Choice" })
end

return M
