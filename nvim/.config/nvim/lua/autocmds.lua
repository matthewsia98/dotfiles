local group = vim.api.nvim_create_augroup("MyAutocmds", { clear = true })

-- Clear hlsearch automatically
vim.on_key(function(char)
    if vim.fn.mode() == "n" then
        local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
        if not vim.tbl_contains(keys, vim.fn.keytrans(char)) then
            vim.cmd([[noh]])
        end
    end
end, vim.api.nvim_create_namespace("auto_hlsearch"))

-- Highlight yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 2000 })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "", "help" },
    callback = function()
        vim.keymap.set("n", "q", "<CMD>q<CR>", { buffer = vim.api.nvim_get_current_buf(), desc = "" })
    end,
})

-- Remove bad formatoptions
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- Disable statuscolumn
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "Trouble", "toggleterm" },
    callback = function()
        vim.api.nvim_win_set_option(0, "statuscolumn", "")
    end,
})

-- Create dir if it doesn't exist
vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
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
})

-- Format file before save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    callback = function()
        vim.lsp.buf.format({ name = "null-ls" })
        vim.notify("Formatted with null-ls", "info", { title = "LSP" })
    end,
})
