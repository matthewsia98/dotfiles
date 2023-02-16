local M = {}

M.get = function()
    local sep = " > "

    local cwd = vim.fn.getcwd()
    cwd = table.concat(vim.fn.split(cwd, "/"), sep)
    cwd = " " .. cwd .. " "

    local head = vim.fn.expand("%:h")
    head = table.concat(vim.fn.split(head, "/"), sep)

    local tail = vim.fn.expand("%:t")
    local filetype_icon, filetype_hl = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype)

    local modified = vim.bo.modified and "%#diffOldFile# [+]" or ""

    local cwd_hl = "lualine_a_normal"
    cwd_hl = "%#" .. cwd_hl .. "#"
    local file_breadcrumb = cwd_hl
        .. cwd
        .. "%#Normal#"
        .. sep
        .. (head == "." and "" or head .. sep)
        .. (filetype_icon and "%#" .. filetype_hl .. "#" .. filetype_icon .. " " or "")
        .. "%#Normal#"
        .. tail
        .. modified
        .. "%#Normal#"

    local navic = require("nvim-navic").get_location()
    navic = (#navic > 0) and (sep .. navic) or navic

    return file_breadcrumb .. navic
end

return M
