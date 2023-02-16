local config = require("config").winbar

local M = {}

M.get = function()
    local sep = " > "

    local cwd
    if config.cwd.enabled then
        cwd = vim.fn.getcwd()
        cwd = table.concat(vim.fn.split(cwd, "/"), sep)
        cwd = "%#" .. config.cwd.highlight .. "# " .. cwd .. " "
    end

    local head = vim.fn.expand("%:h")
    head = table.concat(vim.fn.split(head, "/"), sep)

    local tail = vim.fn.expand("%:t")
    local filetype_icon, filetype_hl = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype)

    local modified = vim.bo.modified and "%#diffOldFile# [+]" or ""

    local file_breadcrumb = (cwd and cwd .. "%#Normal#" .. sep or "")
        .. (head == "." and "" or "%#Normal#" .. head .. sep)
        .. (filetype_icon and "%#" .. filetype_hl .. "#" .. filetype_icon .. " " or "")
        .. ("%#Normal#" .. tail .. modified .. "%#Normal#")

    local navic
    if config.navic then
        navic = require("nvim-navic").get_location()
        navic = (#navic > 0) and (sep .. navic) or navic
    end

    return file_breadcrumb .. (navic and navic or "")
end

return M
