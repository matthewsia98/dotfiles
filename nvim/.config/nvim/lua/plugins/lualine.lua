return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dev = true,
    config = function()
        local config = require("config")
        local style = config.lualine.style
        local gaps = style ~= "powerline" and config.lualine.gap_between_sections
        local spacer = "%#Normal# "
        local separators = {
            slant = { left = "", right = "" },
            reverse_slant = { left = "", right = "" },
            round = { left = "", right = "" },
            box = { left = "▐", right = "▌" },
        }
        local separator = separators[style]

        require("lualine").setup({
            options = {
                theme = "catppuccin",
                -- Needed for powerline option
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = { "dashboard" },
                    winbar = { "dashboard", "help", "neo-tree", "noice", "toggleterm", "Trouble", "tsplayground" },
                },
            },
            extensions = { "trouble" },
            winbar = {
                lualine_a = {
                    {
                        [[require("winbar").get()]],
                        separator = { left = "", right = "" },
                        padding = 0,
                    },
                },
            },
            -- a b c                x y z
            sections = {
                lualine_a = {
                    { "mode", separator = separator },
                },
                lualine_b = {
                    {
                        spacer,
                        cond = function()
                            local is_git = require("lualine.components.branch.git_branch").find_git_dir() ~= nil
                            return gaps and is_git
                        end,
                    },
                    { "branch", separator = separator },
                    { "diff", separator = separator },
                },
                lualine_c = {
                    {
                        spacer,
                        cond = function()
                            return gaps
                        end,
                    },
                    {
                        "diagnostics",
                        sources = { "nvim_workspace_diagnostic" },
                        separator = style == "powerline" and { left = "", right = "" } or separator,
                    },
                    spacer,
                    -- {
                    --     -- Cursor diagnostic | Most severe diagnostic
                    --     function()
                    --         local bufnr = vim.api.nvim_get_current_buf()
                    --         local cursor_row = vim.fn.line(".") - 1
                    --         local cursor_col = vim.fn.col(".") - 1
                    --
                    --         local diagnostics = vim.diagnostic.get(bufnr, { lnum = cursor_row })
                    --
                    --         if #diagnostics == 0 then
                    --             return ""
                    --         end
                    --
                    --         local cursor_diagnostic
                    --         -- Check if cursor on diagnostic
                    --         for _, diagnostic in ipairs(diagnostics) do
                    --             if cursor_col >= diagnostic.col and cursor_col <= diagnostic.end_col then
                    --                 cursor_diagnostic = diagnostic
                    --                 break
                    --             end
                    --         end
                    --
                    --         -- If cursor not on diagnostic, show max severity
                    --         local max_severity_diagnostic
                    --         if cursor_diagnostic == nil then
                    --             for _, diagnostic in ipairs(diagnostics) do
                    --                 if
                    --                     max_severity_diagnostic == nil
                    --                     or diagnostic.severity < max_severity_diagnostic.severity
                    --                 then
                    --                     max_severity_diagnostic = diagnostic
                    --                 end
                    --             end
                    --             cursor_diagnostic = max_severity_diagnostic
                    --         end
                    --
                    --         local severities = { "Error", "Warn", "Info", "Hint" }
                    --         local severity = severities[cursor_diagnostic.severity]
                    --         local sign = vim.fn.sign_getdefined("DiagnosticSign" .. severity)[1]
                    --         local icon = sign and sign.text or ""
                    --         local source = cursor_diagnostic.source
                    --         local msg = cursor_diagnostic.message:gsub("\n", " ")
                    --
                    --         local max_diagnostic_msg_length = config.lualine.diagnostics.max_length
                    --         local include_icon = config.lualine.diagnostics.icon
                    --         local include_source = config.lualine.diagnostics.source
                    --         local cursor_diagnostic_msg = (include_icon and icon:gsub("%s*$", "") .. " " or "")
                    --             .. (include_source and "[" .. source .. "] " or "")
                    --             .. msg
                    --
                    --         if #cursor_diagnostic_msg > max_diagnostic_msg_length then
                    --             cursor_diagnostic_msg = cursor_diagnostic_msg:sub(1, max_diagnostic_msg_length) .. "..."
                    --         end
                    --
                    --         return "%#"
                    --             .. (sign and sign.texthl or "Diagnostic" .. severity)
                    --             .. "#"
                    --             .. cursor_diagnostic_msg
                    --     end,
                    -- },
                },
                lualine_x = { spacer },
                lualine_y = {
                    {
                        spacer,
                        cond = function()
                            return gaps
                        end,
                    },
                    { "fileformat", separator = separator },
                    { "encoding", separator = separator },
                },
                lualine_z = {
                    {
                        spacer,
                        cond = function()
                            return gaps
                        end,
                    },
                    { "filetype", separator = separator },
                    { "filesize", separator = separator },
                },
            },
        })

        vim.cmd([[highlight! link lualine_c_normal Normal]])
    end,
}
