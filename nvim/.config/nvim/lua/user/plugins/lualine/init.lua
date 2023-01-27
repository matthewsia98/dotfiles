local installed, lualine = pcall(require, "lualine")

if installed then
    local config = require("user.config")
    local utils = require("user.plugins.lualine.utils")

    local catppuccin_installed, _ = pcall(require, "catppuccin")
    local lualine_theme = catppuccin_installed and "catppuccin" or "dracula"

    lualine.setup({
        options = {
            theme = lualine_theme,
            icons_enabled = true,
            -- Needed for powerline option
            section_separators = { left = "", right = "" },
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
                    separator = utils.separator(),
                },
            },
            lualine_b = {
                utils.spacer({
                    cond = function()
                        local is_git = require("lualine.components.branch.git_branch").find_git_dir() ~= nil
                        return is_git and config.lualine.separator_style ~= "powerline"
                    end,
                }),
                {
                    "branch",
                    separator = utils.separator(),
                },
                {
                    "diff",
                    separator = utils.separator(),
                },
            },
            lualine_c = {
                utils.spacer({
                    cond = function()
                        return #vim.diagnostic.get(nil) > 0
                    end,
                    force = true,
                }),
                -- Workspace Diagnostics
                utils.diagnostics("workspace"),
                utils.spacer({
                    cond = function()
                        return #vim.diagnostic.get(vim.api.nvim_get_current_buf()) > 0
                    end,
                }),
                -- Document Diagnostics
                utils.diagnostics(),
                utils.spacer({
                    cond = function()
                        return true
                    end,
                    force = true,
                }),
                {
                    utils.cursor_diagnostic,
                    color = utils.cursor_diagnostic_color,
                },
            },
            lualine_x = {},
            lualine_y = {
                {
                    "fileformat",
                    symbols = {
                        -- unix = "UNIX",
                        -- dos = "DOS",
                        -- mac = "MAC",
                        unix = "",
                        dos = "",
                        mac = "",
                    },
                    separator = utils.separator(),
                },
                {
                    "encoding",
                    separator = utils.separator(),
                },
                utils.spacer({
                    cond = function()
                        return config.lualine.separator_style ~= "powerline"
                    end,
                }),
            },
            lualine_z = {
                {
                    "filetype",
                    separator = utils.separator(),
                },
                {
                    "filesize",
                    separator = utils.separator(),
                },
                -- utils.spacer(),
                -- {
                --     "progress",
                --     separator = utils.separator(),
                -- },
                -- {
                --     "location",
                --     separator = utils.separator(),
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

    if config.lualine.transparent_bg then
        vim.cmd([[highlight lualine_c_normal guibg=#00000000]])
        vim.cmd([[highlight lualine_c_insert guibg=#00000000]])
        vim.cmd([[highlight lualine_c_visual guibg=#00000000]])
        vim.cmd([[highlight lualine_c_command guibg=#00000000]])
    end
end
