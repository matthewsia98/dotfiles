local installed, ufo = pcall(require, "ufo")

if installed then
    local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
                table.insert(newVirtText, chunk)
            else
                chunkText = truncate(chunkText, targetWidth - curWidth)
                local hlGroup = chunk[2]
                table.insert(newVirtText, { chunkText, hlGroup })
                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                -- str width returned from truncate() may less than 2nd argument, need padding
                if curWidth + chunkWidth < targetWidth then
                    suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                end
                break
            end
            curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
    end

    ufo.setup({
        provider_selector = function(bufnr, filetype, buftype)
            return { "treesitter", "indent" }
        end,
        fold_virt_text_handler = handler,
    })

    local keys = require("user.keymaps")

    keys.map("n", "zR", function()
        ufo.openAllFolds()
    end, { desc = "Open all folds" })
    keys.map("n", "zM", function()
        ufo.closeAllFolds()
    end, { desc = "Close all folds" })

    keys.map("n", "zr", function()
        ufo.openFoldsExceptKinds()
    end, { desc = "" })
    keys.map("n", "zm", function()
        ufo.closeFoldsWith()
    end, { desc = "" })
end
