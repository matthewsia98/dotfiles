local tokyonight_installed, tokyonight = pcall(require, "tokyonight")
local config = require("user.config")

if tokyonight_installed and config.colorscheme.name == "tokyonight" then
    tokyonight.setup({
        style = "night",
        transparent = false,
        on_colors = function(colors)
            if config.lualine.transparent_bg then
                colors.bg_statusline = colors.none
            end
        end,
        on_highlights = function(hl, colors)
            hl.NormalFloat = hl.Normal
            hl.FloatBorder = hl.Normal
            hl.WinSeparator = { fg = colors.fg }
            hl.NvimTreeWinSeparator = { fg = colors.fg }

            hl.IndentBlanklineIndent6 = { fg = colors.yellow }
            hl.IndentBlanklineIndent5 = { fg = colors.red }
            hl.IndentBlanklineIndent4 = { fg = colors.teal }
            hl.IndentBlanklineIndent3 = { fg = colors.orange }
            hl.IndentBlanklineIndent2 = { fg = colors.blue }
            hl.IndentBlanklineIndent1 = { fg = colors.magenta }
            hl.IndentBlanklineContextChar = { fg = colors.green }
            vim.cmd([[highlight IndentBlanklineContextStart cterm=underline gui=underline guisp=]] .. colors.green)
        end,
    })

    local term = os.getenv("TERM") or ""
    if config.colorscheme.override_kitty and term:match("kitty") then
        local style = require("tokyonight.config").options.style
        style = style:sub(1, 1):upper() .. style:sub(2)
        if style == "Night" then
            style = ""
        else
            style = " " .. style
        end

        local kitty_cmd = string.format([[kitty +kitten themes --reload-in=all "Tokyo Night%s" 2> /dev/null]], style)
        os.execute(kitty_cmd)
    end

    vim.cmd([[colorscheme tokyonight]])
end
