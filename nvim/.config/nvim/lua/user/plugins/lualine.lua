local installed, lualine = pcall(require, "lualine")

if installed then
    local function separator()
        local style = vim.g.lualine_separator_style
        if style == "slant" then
            return { left = "", right = "" }
        elseif style == "reverse_slant" then
            return { left = "", right = "" }
        elseif style == "powerline" then
            return nil
        elseif style == "round" then
            return { left = "", right = "" }
        end
    end

    local function spacer(opts)
        opts = opts == nil and {} or opts
        local char = opts.char == nil and " " or opts.char
        local length = opts.length == nil and 1 or opts.length
        local color = opts.color == nil and { bg = "#00000000" } or opts.color

        local function spacer_condition()
            return vim.g.lualine_separator_style ~= "powerline"
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
            "mode",
            fmt = function(_) return char:rep(length) end,
            color = color,
            cond = cond,
        }
    end


    lualine.setup({
        options = {
            theme = "catppuccin",
            icons_enabled = true,
            -- separators                         
            component_separators = { left = "", right = "" },
        },
        -- a b c                x y z
        sections = {
            lualine_a = {
                spacer(),
                {
                    "mode",
                    separator = separator(),
                },
            },
            lualine_b = {
                spacer(),
                {
                    "branch",
                    separator = separator(),
                },
                {
                    "diff",
                    separator = vim.g.lualine_separator_style == "powerline" and { left = "", right = "" } or separator(),
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
            lualine_c = {spacer()},
            lualine_x = {spacer()},
            lualine_y = {
                {
                    "encoding",
                    separator = separator(),
                },
                {
                    "fileformat",
                    symbols = {
                        unix = "UNIX",
                        dos = "DOS",
                        mac = "MAC",
                    },
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
                spacer(),
            },
        },
    })

    vim.cmd [[ highlight lualine_c_normal guibg=#00000000 ]]
end
