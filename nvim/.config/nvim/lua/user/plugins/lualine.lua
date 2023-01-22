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
            return { left = "▐", right = "▌ " }
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
        -- 1-based
        local _, cursor_row, cursor_col, _ = unpack(vim.fn.getpos("."))

        -- 0-based
        local diagnostics = vim.diagnostic.get(vim.api.nvim_get_current_buf(), { lnum = cursor_row - 1 })

        if #diagnostics == 0 then
            return ""
        end

        -- Check if cursor on diagnostic
        vim.g.lualine_current_diagnostic = nil
        for _, diagnostic in ipairs(diagnostics) do
            if cursor_col - 1 >= diagnostic.col and cursor_col - 1 <= diagnostic.end_col then
                vim.g.lualine_current_diagnostic = diagnostic
                break
            end
        end

        -- If cursor not on diagnostic, show max severity
        if vim.g.lualine_current_diagnostic == nil then
            for _, diagnostic in ipairs(diagnostics) do
                if
                    vim.g.lualine_current_diagnostic == nil
                    or diagnostic.severity < vim.g.lualine_current_diagnostic.severity
                then
                    vim.g.lualine_current_diagnostic = diagnostic
                end
            end
        end

        return string.format(
            "[%s] %s",
            vim.g.lualine_current_diagnostic.source,
            vim.g.lualine_current_diagnostic.message
        )
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
            -- separators                         
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
                        return "lualine_b_diagnostics_" .. severities[max_severity] .. "_0_normal"
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
                        return "lualine_b_diagnostics_" .. severities[max_severity] .. "_0_normal"
                    end,
                    separator = separator(),
                },
            },
            lualine_c = {
                spacer(),
                {
                    cursor_diagnostic,
                    color = cursor_diagnostic_color,
                },
            },
            lualine_x = {
                spacer(),
            },
            lualine_y = {
                {
                    "fileformat",
                    symbols = {
                        unix = "UNIX",
                        dos = "DOS",
                        mac = "MAC",
                    },
                    separator = separator(),
                },
                {
                    "encoding",
                    separator = separator(),
                },
                spacer(),
                {
                    "filetype",
                    separator = separator(),
                },
                {
                    "filesize",
                    separator = separator(),
                },
                spacer(),
            },
            lualine_z = {
                {
                    "progress",
                    separator = separator(),
                },
                {
                    "location",
                    separator = separator(),
                },
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
