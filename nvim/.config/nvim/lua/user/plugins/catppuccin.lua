local catppuccin_installed, catppuccin = pcall(require, "catppuccin")
local config = require("user.config")

if catppuccin_installed and config.colorscheme.name == "catppuccin" then
    catppuccin.setup({
        flavour = "mocha",
        background = {
            light = "frappe",
            dark = "mocha",
        },
        transparent_background = false,
        term_colors = false,
        styles = {
            comments = {},
            conditionals = {},
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
        },
        integrations = {
            cmp = true,
            dashboard = true,
            gitsigns = true,
            leap = true,
            mason = true,
            mini = true,
            noice = true,
            notify = true,
            nvimtree = true,
            -- semantic_tokens = true,
            treesitter_context = true,
            treesitter = true,
            ts_rainbow = true,
            telescope = true,
            lsp_trouble = true,
            which_key = true,

            -- Special Integrations
            indent_blankline = {
                enabled = true,
                colored_indent_levels = true,
            },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "bold", "italic" },
                    hints = { "bold", "italic" },
                    warnings = { "bold", "italic" },
                    information = { "bold", "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
            },
        },
        color_overrides = {
            -- If overriding Normal, need to manually change background value in ~/.config/kitty/themes/<flavour>.conf also
            mocha = {
                base = "#181825",
            },
        },
        custom_highlights = function(colors)
            return {
                -- If overriding Normal, need to manually change background value in ~/.config/kitty/themes/<flavour>.conf also
                -- Normal = { bg = colors.mantle },
                -- NormalFloat = { bg = colors.mantle },

                LineNr = { fg = colors.lavender },
                CursorLineNr = { fg = colors.lavender },

                WinSeparator = { fg = colors.text },

                Comment = { fg = colors.overlay1 },

                TreesitterContext = { bg = colors.surface0 },
                TreesitterContextLineNumber = { bg = colors.surface0, fg = colors.lavender },

                IndentBlanklineContextChar = { fg = colors.green },
                IndentBlanklineContextStart = { sp = colors.green },

                NvimTreeNormal = { bg = colors.crust },
                NvimTreeWinSeparator = { fg = colors.text },

                NoiceCursor = { bg = colors.text, fg = colors.base },
            }
        end,
    })

    local term = os.getenv("TERM") or ""
    if config.colorscheme.override_kitty and term:match("kitty") then
        local flavour = catppuccin.flavour
        flavour = flavour:sub(1, 1):upper() .. flavour:sub(2)
        local kitty_cmd =
            string.format([[kitty +kitten themes --reload-in=all "Catppuccin Kitty %s" 2> /dev/null]], flavour)
        os.execute(kitty_cmd)
    end

    vim.cmd([[colorscheme catppuccin]])
end
