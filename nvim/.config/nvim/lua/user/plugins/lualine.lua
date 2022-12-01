local installed, lualine = pcall(require, "lualine")

if installed then
    local function spacer(opts)
        opts = opts == nil and {} or opts
        local char = opts.char == nil and " " or opts.char
        local length = opts.length == nil and 1 or opts.length
        local color = opts.color == nil and { bg = "#00000000" } or opts.color
        return {
            "mode",
            fmt = function(_) return char:rep(length) end,
            color = color,
            separator = opts.separator,
            cond = opts.cond,
        }
    end

    lualine.setup({
        options = {
            theme = "catppuccin",
            icons_enabled = true,
            -- powerline      
            -- section_separators = { left = "", right = "" },
            -- section_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            component_separators = { left = "❘", right = "❘" },
        },
        -- a b c                x y z
        sections = {
            lualine_a = {
                {
                    "mode",
                    separator = { left = "", right = "" },
                },
            },
            lualine_b = {
                spacer(),
                {
                    "branch",
                    separator = { left = "", right = "" },
                },
                {
                    "diff",
                    -- separator = "",
                    separator = { left = "", right = "" },
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
                    separator = { left = "", right = "" },
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
                    separator = { left = "", right = "" },
                },
            },
            lualine_c = {},
            lualine_x = {},
            lualine_y = {
                {
                    "encoding",
                    separator = { left = "", right = "" },
                },
                {
                    "fileformat",
                    symbols = {
                        unix = "UNIX",
                        dos = "DOS",
                        mac = "MAC",
                    },
                    separator = { left = "", right = "" },
                },
                {
                    "filetype",
                    separator = { left = "", right = "" },
                },
                {
                    "filesize",
                    separator = { left = "", right = "" },
                },
                spacer(),
            },
            lualine_z = {
                {
                    "progress",
                    separator = { left = "", right = "" },
                },
                {
                    "location",
                    separator = { left = "", right = "" },
                },
            },
        },
    })

    vim.cmd [[ highlight lualine_c_normal guibg=#00000000 ]]
end
