local default_group = vim.api.nvim_create_augroup("MyAutocmds", { clear = true })
local group = function(name)
    return name and vim.api.nvim_create_augroup(name, { clear = true }) or default_group
end

-- Clear hlsearch automatically
vim.on_key(function(char)
    if vim.fn.mode() == "n" then
        local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
        if not vim.tbl_contains(keys, vim.fn.keytrans(char)) then
            vim.cmd([[noh]])
        end
    end
end, vim.api.nvim_create_namespace("auto_hlsearch"))

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group(),
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 2000 })
    end,
    desc = "Highlight yanked region",
})

vim.api.nvim_create_autocmd("FileType", {
    group = group(),
    pattern = { "", "help", "toggleterm", "tsplayground" },
    callback = function()
        vim.keymap.set("n", "q", "<CMD>q<CR>", { buffer = vim.api.nvim_get_current_buf(), desc = "" })
    end,
    desc = "Close window with q",
})

vim.api.nvim_create_autocmd("FileType", {
    group = group(),
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
    desc = "Remove bad formatoptions",
})

vim.api.nvim_create_autocmd("FileType", {
    group = group(),
    pattern = { "norg" },
    callback = function()
        vim.opt.conceallevel = 3
    end,
    desc = "Set conceal level for norg files",
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group(),
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

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group(),
    callback = function()
        if #vim.lsp.get_active_clients({ bufnr = 0, name = "null-ls" }) > 0 then
            vim.lsp.buf.format({ name = "null-ls" })
        end
    end,
    desc = "Format file before save",
})
