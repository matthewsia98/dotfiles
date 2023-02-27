local map = require("keymaps").map
local cmp = require("cmp")
local luasnip = require("luasnip")
local copilot_installed, copilot = pcall(require, "copilot.suggestion")

local function feedkeys(lhs, mode)
    mode = mode or "im"
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(lhs, true, false, true), mode, false)
end

local M = {}

M.set_keymaps = function()
    map("c", "<C-n>", function()
        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
            -- for cmp-cmdline-history
            feedkeys("<C-n>", "n")
        end
    end, { desc = "Cmp Next" })
    map("i", "<C-n>", function()
        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif luasnip.choice_active() then
            luasnip.change_choice(1)
        elseif
            copilot_installed
            and vim.fn.mode() == "i"
            and #vim.lsp.get_active_clients({ bufnr = 0, name = "copilot" }) > 0
        then
            copilot.next()
        end
    end, { desc = "Cmp / Luasnip / Copilot Next" })

    map("c", "<C-p>", function()
        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
            feedkeys("<C-p>", "n")
        end
    end, { desc = "Cmp Previous" })
    map("i", "<C-p>", function()
        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        elseif luasnip.choice_active() then
            luasnip.change_choice(-1)
        elseif
            copilot_installed
            and vim.fn.mode() == "i"
            and #vim.lsp.get_active_clients({ bufnr = 0, name = "copilot" })
        then
            copilot.prev()
        else
            -- for cmp-cmdline-history
            feedkeys("<C-p>")
        end
    end, { desc = "Cmp / Luasnip / Copilot Previous" })

    -- map({ "i", "c" }, "<CR>", function()
    --     if cmp.visible() and cmp.get_selected_entry() then
    --         cmp.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })
    --     else
    --         feedkeys("<CR>", "n")
    --     end
    -- end, { desc = "Cmp confirm selected" })

    map({ "i", "c" }, "<C-c>", function()
        if cmp.visible() then
            cmp.abort()
        elseif copilot.is_visible() then
            copilot.dismiss()
        end
    end, { desc = "Cmp / Copilot cancel" })

    map({ "i", "c" }, "<C-Space>", function()
        if cmp.visible() then
            cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
        elseif copilot.is_visible() then
            copilot.accept_line()
        end
    end, { desc = "Cmp accept / Copilot accept line" })
    map("i", "<C-CR>", function()
        if copilot.is_visible() then
            copilot.accept()
        end
    end, { desc = "Copilot accept" })

    map("i", "<C-f>", function()
        if cmp.visible() then
            cmp.scroll_docs(4)
        end
    end, { desc = "Cmp scroll down" })

    map("i", "<C-b>", function()
        if cmp.visible() then
            cmp.scroll_docs(-4)
        end
    end, { desc = "Cmp scroll up" })

    map({ "i", "s" }, "<C-l>", function()
        if luasnip.jumpable(1) then
            luasnip.jump(1)
        end
    end, { desc = "Luasnip jump to next" })
    map({ "i", "s" }, "<C-h>", function()
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        end
    end, { desc = "Luasnip jump to previous" })

    map("s", "<C-n>", function()
        if luasnip.choice_active() then
            luasnip.change_choice(1)
        end
    end, { desc = "Luasnip Next Choice" })
    map("s", "<C-p>", function()
        if luasnip.choice_active() then
            luasnip.change_choice(-1)
        end
    end, { desc = "Luasnip Previous Choice" })

    map({ "i", "s" }, "<C-u>", function()
        require("luasnip.extras.select_choice")()
    end, { desc = "" })
end

return M
