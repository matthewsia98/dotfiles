local default_group = vim.api.nvim_create_augroup("MyAutocmds", { clear = true })
local function group(name)
    return name and vim.api.nvim_create_augroup(name, { clear = true }) or default_group
end

-- Clear hlsearch automatically
-- vim.on_key(function(char)
--     if vim.fn.mode() == "n" then
--         local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
--         if not vim.tbl_contains(keys, vim.fn.keytrans(char)) then
--             vim.cmd([[noh]])
--         end
--     end
-- end, vim.api.nvim_create_namespace("auto_hlsearch"))

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = group("checktime"),
    command = "checktime",
    desc = "Check if file has been changed outside of Neovim",
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group("highlight_on_yank"),
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 2000 })
    end,
    desc = "Highlight yanked region",
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = group("resize_splits"),
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
    desc = "resize splits if window got resized",
})

vim.api.nvim_create_autocmd("FileType", {
    group = group("close_with_q"),
    pattern = { "", "qf", "help", "checkhealth", "toggleterm", "tsplayground" },
    callback = function()
        vim.keymap.set("n", "q", "<CMD>q<CR>", { buffer = vim.api.nvim_get_current_buf(), desc = "" })
    end,
    desc = "Close window with q",
})

vim.api.nvim_create_autocmd("FileType", {
    group = group("formatoptions"),
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
    desc = "Remove bad formatoptions",
})

vim.api.nvim_create_autocmd("FileType", {
    group = group("lazy_check_updates"),
    pattern = "lazy",
    callback = function()
        require("lazy.manage").check()
    end,
    desc = "Check for plugin updates on opening Lazy UI",
})

vim.api.nvim_create_autocmd("FileType", {
    group = group("neorg_conceal"),
    pattern = { "norg" },
    callback = function()
        vim.opt_local.concealcursor = "n"
        vim.opt_local.conceallevel = 3
    end,
    desc = "Set conceal level for norg files",
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group("auto_create_dir"),
    callback = function()
        local head = vim.fn.expand("%:p:h")
        local dir_exists = vim.fn.isdirectory(head) ~= 0
        if not dir_exists then
            local success = vim.fn.mkdir(head, "p")
            if success == 1 then
                vim.notify("Created directory " .. head, "info", { title = "Autocmd" })
            end
        end
    end,
    desc = "Create dir if it doesn't exist",
})
