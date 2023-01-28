local group = vim.api.nvim_create_augroup("MyAutocmds", { clear = true })

-- Format file before save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local lsp_clients = vim.lsp.get_active_clients({ bufnr = bufnr })

        for _, lsp_client in ipairs(lsp_clients) do
            if lsp_client.server_capabilities.documentFormattingProvider then
                vim.lsp.buf.format()
                vim.notify("Formatted with " .. lsp_client.name, "info", {
                    title = "LSP",
                    timeout = 500,
                })
                break
            end
        end
    end,
})

-- Close window with q
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "help", "vim", "qf" },
    callback = function()
        vim.keymap.set("n", "q", function()
            vim.api.nvim_win_close(0, false)
        end)
    end,
})

-- Java Boilerplate
vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    pattern = "*.java",
    callback = function()
        local filepath = vim.fn.expand("%")
        local classname = filepath:match("/?(%w+)%.java")
        local num_lines = vim.api.nvim_buf_line_count(0)
        local first_line = vim.api.nvim_buf_get_text(0, 0, 0, 0, -1, {})[1]
        if num_lines == 1 and first_line == "" then
            vim.api.nvim_buf_set_lines(0, 0, 4, false, {
                "public class " .. classname .. " {",
                "",
                "}",
            })
            vim.api.nvim_win_set_cursor(0, { 2, 0 })
        end
    end,
})

-- Highlight yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 2000 })
    end,
})

-- Show recorded macro (Using open and close because replace doesn't work well)
vim.api.nvim_create_autocmd("RecordingEnter", {
    group = group,
    callback = function()
        local win_id = vim.g.macro_recording_notification
        if win_id and vim.api.nvim_win_is_valid(win_id) then
            vim.api.nvim_win_close(win_id, true)
        end

        vim.notify(vim.fn.reg_recording(), "info", {
            title = "Recording Started",
            timeout = false,
            on_open = function(win)
                vim.g.macro_recording_notification = win
            end,
        })
    end,
})
vim.api.nvim_create_autocmd("RecordingLeave", {
    group = group,
    callback = function()
        local win_id = vim.g.macro_recording_notification
        if win_id and vim.api.nvim_win_is_valid(win_id) then
            vim.api.nvim_win_close(win_id, true)
        end

        vim.notify(vim.v.event.regname .. ": " .. vim.v.event.regcontents, "info", {
            title = "Recording Stopped",
            timeout = 2000,
            on_open = function(win)
                vim.g.macro_recording_notification = win
            end,
        })
    end,
})

-- Clear hlsearch automatically
vim.on_key(function(char)
    if vim.fn.mode() == "n" then
        local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
        if not vim.tbl_contains(keys, vim.fn.keytrans(char)) then
            vim.cmd([[noh]])
        end
    end
end, vim.api.nvim_create_namespace("auto_hlsearch"))
