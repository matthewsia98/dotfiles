local config = require("config")
local cwd_hl = vim.api.nvim_get_hl(0, { name = "lualine_a_normal" })
vim.api.nvim_set_hl(0, "WinbarCwdSeparator", { fg = cwd_hl.bg })

local separator = config.lualine.styles[config.lualine.style]

local function get_trouble_mode()
    local opts = require("trouble.config").options

    local words = vim.split(opts.mode, "%W")
    for i, word in ipairs(words) do
        words[i] = word:sub(1, 1):upper() .. word:sub(2)
    end

    local mode = table.concat(words, " ")
    return ("%#WinbarCwdSeparator#" .. separator.left)
        .. ("%#" .. config.lualine.winbar.trouble.highlight .. "# " .. mode .. " ")
        .. ("%#WinbarCwdSeparator#" .. separator.right)
end

local M = {}

M.get = function(opts)
    if config.lualine.winbar.trouble.enabled and vim.bo.filetype == "Trouble" then
        return get_trouble_mode()
    end

    opts = opts or { navic = true }

    local sep = config.lualine.winbar.separator or " > "

    local cwd
    if config.lualine.winbar.cwd.enabled then
        cwd = vim.fn.getcwd()
        if config.lualine.winbar.cwd.home_symbol then
            local home = os.getenv("HOME")
            cwd = home and cwd:gsub(home, config.lualine.winbar.cwd.home_symbol) or cwd
        end
        cwd = table.concat(vim.fn.split(cwd, "/"), sep)

        cwd = ("%#WinbarCwdSeparator#" .. separator.left .. "%#")
            .. (config.lualine.winbar.cwd.highlight .. "# " .. cwd .. " ")
            .. ("%#WinbarCwdSeparator#" .. separator.right)
    end

    local head = vim.fn.expand("%:.:h")
    head = table.concat(vim.fn.split(head, "/"), sep)
    if head == "" then
        return ""
    end

    local tail = vim.fn.expand("%:t")
    local filetype_icon, filetype_hl = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype)

    local readonly = vim.bo.readonly and "%#Error# []" or ""
    local modified = vim.bo.modified and "%#WarningMsg# [+]" or ""

    local file_breadcrumb = (cwd and cwd .. "%#Normal#" .. sep or "")
        .. (head == "." and "" or "%#Normal#" .. head .. sep)
        .. (filetype_icon and "%#" .. filetype_hl .. "#" .. filetype_icon .. " " or "")
        .. ("%#Normal#" .. tail .. readonly .. modified .. "%#Normal#")

    local navic
    if config.lualine.winbar.navic.enabled and opts.navic then
        navic = require("nvim-navic").get_location()
        navic = (#navic > 0) and (sep .. navic) or navic
    end

    return file_breadcrumb .. (navic and navic or "")
end

return M
