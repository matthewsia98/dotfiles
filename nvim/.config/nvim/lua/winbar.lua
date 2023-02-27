local config = require("config")
local cwd_hl = vim.api.nvim_get_hl_by_name(config.winbar.cwd.highlight, true)
vim.api.nvim_set_hl(0, "WinbarCwdSeparator", { fg = cwd_hl.background })

local separators = {
    powerline = { left = "", right = "" },
    slant = { left = "", right = "" },
    reverse_slant = { left = "", right = "" },
    round = { left = "", right = "" },
    box = { left = "▐", right = "▌" },
}

local function get_trouble_mode()
    local opts = require("trouble.config").options

    local words = vim.split(opts.mode, "%W")
    for i, word in ipairs(words) do
        words[i] = word:sub(1, 1):upper() .. word:sub(2)
    end

    local separator = separators[config.winbar.trouble.style]
    local mode = table.concat(words, " ")
    return ("%#WinbarCwdSeparator#" .. separator.left)
        .. ("%#" .. config.winbar.trouble.highlight .. "# " .. mode .. " ")
        .. ("%#WinbarCwdSeparator#" .. separator.right)
end

local M = {}

M.get = function(opts)
    if config.winbar.trouble.enabled and vim.bo.filetype == "Trouble" then
        return get_trouble_mode()
    end

    opts = opts or { navic = true }

    local sep = config.winbar.separator or " > "

    local cwd
    if config.winbar.cwd.enabled then
        cwd = vim.fn.getcwd()
        if config.winbar.cwd.home_symbol then
            local home = os.getenv("HOME")
            cwd = home and cwd:gsub(home, config.winbar.cwd.home_symbol) or cwd
        end
        cwd = table.concat(vim.fn.split(cwd, "/"), sep)

        local separator = separators[config.winbar.cwd.style]
        cwd = ("%#WinbarCwdSeparator#" .. separator.left .. "%#")
            .. (config.winbar.cwd.highlight .. "# " .. cwd .. " ")
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
    if config.winbar.navic.enabled and opts.navic then
        navic = require("nvim-navic").get_location()
        navic = (#navic > 0) and (sep .. navic) or navic
    end

    return file_breadcrumb .. (navic and navic or "")
end

return M
