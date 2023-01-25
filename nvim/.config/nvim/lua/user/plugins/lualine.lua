local installed, lualine = pcall(require, "lualine")

if installed then
    local config = require("user.config")

    local function separator()
        local style = config.lualine_separator_style
        if style == "slant" then
            return { left = "", right = "" }
        elseif style == "reverse_slant" then
            return { left = "", right = "" }
        elseif style == "powerline" then
            return nil
        elseif style == "round" then
            return { left = "", right = "" }
        elseif style == "box" then
            return { left = "▐", right = "▌" }
        end
    end

    local function spacer(opts)
        opts = opts == nil and {} or opts
        local char = opts.char == nil and " " or opts.char
        local length = opts.length == nil and 1 or opts.length
        local color = opts.color == nil and { bg = "#00000000" } or opts.color

        local function spacer_condition()
            return config.lualine_separator_style ~= "powerline" and config.lualine_gap_between_sections
        end

        local cond
        if opts.cond == nil then
            cond = spacer_condition
        else
            cond = function()
                return spacer_condition() and opts.cond()
            end
        end

        return {
            function()
                return char:rep(length)
            end,
            color = color,
            cond = cond,
        }
    end

    local function cursor_diagnostic()
        vim.g.lualine_current_diagnostic = nil

        local bufnr = vim.api.nvim_get_current_buf()
        local cursor_row = vim.fn.line(".") - 1
        local cursor_col = vim.fn.col(".") - 1

        local diagnostics = vim.diagnostic.get(bufnr, { lnum = cursor_row })

        if #diagnostics == 0 then
            return ""
        end

        -- Check if cursor on diagnostic
        for _, diagnostic in ipairs(diagnostics) do
            if cursor_col >= diagnostic.col and cursor_col <= diagnostic.end_col then
                vim.g.lualine_current_diagnostic = diagnostic
                break
            end
        end

        -- If cursor not on diagnostic, show max severity
        local max_severity_diagnostic
        if vim.g.lualine_current_diagnostic == nil then
            for _, diagnostic in ipairs(diagnostics) do
                if max_severity_diagnostic == nil or diagnostic.severity < max_severity_diagnostic.severity then
                    max_severity_diagnostic = diagnostic
                end
            end
            vim.g.lualine_current_diagnostic = max_severity_diagnostic
        end

        local severities = { "Error", "Warn", "Info", "Hint" }
        local severity = severities[vim.g.lualine_current_diagnostic.severity]
        local icon = vim.fn.sign_getdefined("DiagnosticSign" .. severity)[1].text
        local source = vim.g.lualine_current_diagnostic.source
        local msg = vim.g.lualine_current_diagnostic.message

        local max_diagnostic_msg_length = config.lualine_max_diagnostic_msg_length
        local lualine_diagnostic_msg = string.format("%s [%s] %s", icon, source, msg)

        if #lualine_diagnostic_msg > max_diagnostic_msg_length then
            lualine_diagnostic_msg = lualine_diagnostic_msg:sub(1, max_diagnostic_msg_length) .. "..."
        end

        return lualine_diagnostic_msg
    end

    local function cursor_diagnostic_color()
        local severities = { "Error", "Warn", "Info", "Hint" }
        if vim.g.lualine_current_diagnostic then
            local severity = severities[vim.g.lualine_current_diagnostic.severity]
            local sign = vim.fn.sign_getdefined("DiagnosticSign" .. severity)[1]
            return sign.texthl
        end
    end

    local catppuccin_installed, _ = pcall(require, "catppuccin")
    local lualine_theme = catppuccin_installed and "catppuccin" or "dracula"
    lualine.setup({
        options = {
            theme = lualine_theme,
            icons_enabled = true,
            component_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = { "", "dashboard" },
            },
        },
        -- a b c                x y z
        sections = {
            lualine_a = {
                {
                    "mode",
                    separator = separator(),
                },
            },
            lualine_b = {
                spacer({
                    cond = function()
                        return require("lualine.components.branch.git_branch").find_git_dir() ~= nil
                    end,
                }),
                {
                    "branch",
                    separator = separator(),
                },
                {
                    "diff",
                    separator = config.lualine_separator_style == "powerline" and { left = "", right = "" }
                        or separator(),
                },
            },
            lualine_c = {
                spacer({
                    cond = function()
                        return #vim.diagnostic.get(nil) > 0
                    end,
                }),
                {
                    "diagnostics",
                    sources = { "nvim_workspace_diagnostic" },
                    sections = { "error", "warn", "info", "hint" },
                    symbols = { error = " ", warn = " ", info = " ", hint = " " },
                    colored = true,
                    update_in_insert = false,
                    always_visible = false,
                    fmt = function(s)
                        if #s > 0 then
                            return "W " .. s
                        else
                            return s
                        end
                    end,
                    color = function()
                        local severities = { "error", "warn", "info", "hint" }
                        local diagnostics = vim.diagnostic.get(nil)
                        local max_severity = 4
                        for _, diagnostic in ipairs(diagnostics) do
                            if max_severity == nil then
                                max_severity = diagnostic.severity
                            else
                                if diagnostic.severity < max_severity then
                                    max_severity = diagnostic.severity
                                end
                            end
                        end
                        return "lualine_c_diagnostics_" .. severities[max_severity] .. "_0_normal"
                    end,
                    separator = separator(),
                },
                spacer({
                    cond = function()
                        return #vim.diagnostic.get(0) > 0
                    end,
                }),
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    sections = { "error", "warn", "info", "hint" },
                    symbols = { error = " ", warn = " ", info = " ", hint = " " },
                    colored = true,
                    update_in_insert = false,
                    always_visible = false,
                    fmt = function(s)
                        if #s > 0 then
                            return "D " .. s
                        else
                            return s
                        end
                    end,
                    color = function()
                        local severities = { "error", "warn", "info", "hint" }
                        local diagnostics = vim.diagnostic.get(0)
                        local max_severity = 4
                        for _, diagnostic in ipairs(diagnostics) do
                            if max_severity == nil then
                                max_severity = diagnostic.severity
                            else
                                if diagnostic.severity < max_severity then
                                    max_severity = diagnostic.severity
                                end
                            end
                        end
                        return "lualine_c_diagnostics_" .. severities[max_severity] .. "_0_normal"
                    end,
                    separator = separator(),
                },
                spacer(),
                {
                    cursor_diagnostic,
                    color = cursor_diagnostic_color,
                },
            },
            lualine_x = {
                -- spacer(),
            },
            lualine_y = {
                -- {
                --     "fileformat",
                --     symbols = {
                --         unix = "UNIX",
                --         dos = "DOS",
                --         mac = "MAC",
                --     },
                --     separator = separator(),
                -- },
                -- {
                --     "encoding",
                --     separator = separator(),
                -- },
            },
            lualine_z = {
                -- spacer(),
                {
                    "filetype",
                    separator = separator(),
                },
                {
                    "filesize",
                    separator = separator(),
                },
                -- {
                --     "progress",
                --     separator = separator(),
                -- },
                -- {
                --     "location",
                --     separator = separator(),
                -- },
            },
        },
        extensions = {
            "quickfix",
            "nvim-tree",
            "toggleterm",
            "trouble",
        },
    })

    if config.lualine_transparent_bg then
        vim.cmd([[highlight lualine_c_normal guibg=#00000000]])
        vim.cmd([[highlight lualine_c_insert guibg=#00000000]])
        vim.cmd([[highlight lualine_c_visual guibg=#00000000]])
        vim.cmd([[highlight lualine_c_command guibg=#00000000]])
    end
end
