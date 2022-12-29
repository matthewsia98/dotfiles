local group = vim.api.nvim_create_augroup("MyAutocmds", { clear = true })

-- Format before save
-- A.nvim_create_autocmd('BufWritePre', {
--         group = group,
--         callback = function()
--             local bufnr = A.nvim_get_current_buf()
--             local lsp_client = vim.lsp.get_active_clients({ bufnr = bufnr })[1]
--
--             if lsp_client ~= nil and lsp_client['server_capabilities']['documentFormattingProvider'] then
--                 vim.lsp.buf.format()
--             end
--         end
--     }
-- )

-- Format Options
-- vim.api.nvim_create_autocmd('FileType', {
--     group = group,
--     callback = function()
--         -- t: Auto-wrap using textwidth
--         -- c: Auto-wrap comments using textwidth and insert comment leader automatically
--         -- r: BAD!!! Automatically insert comment leader when hitting <Enter> in Insert mode
--         -- o: BAD!!! Automatically insert comment leader when hitting o/O in Normal mode
--         -- n: Recognize numbered lists
--         -- l: Long lines are not broken in insert mode
--         -- j: Remove comment leader when joining lines
--         -- p: Don't break lines at single spaces that follow periods e.g. Mr. John
--         vim.cmd [[set formatoptions=tcnjp]]
--     end
-- })

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "help", "vim" },
    callback = function()
        vim.keymap.set("n", "q", function()
            vim.api.nvim_win_close(0, false)
        end)
    end,
})

-- Java
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

vim.api.nvim_create_autocmd("RecordingLeave", {
    group = group,
    callback = function()
        local reg = vim.fn.reg_recording()
        vim.notify("Recording stopped: " .. reg, vim.log.levels.INFO, {
            title = "Macro",
        })
    end,
})
