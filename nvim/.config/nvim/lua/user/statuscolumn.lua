local M = {}

local function trim(s)
    return s:gsub("%s*$", "")
end

M.get_signs = function()
    local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local signs = vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs
    local function get_sign(sign)
        return vim.fn.sign_getdefined(sign.name)[1]
    end

    return vim.tbl_map(get_sign, signs)
end

M.column = function()
    local diagnostic_sign, git_sign
    for _, s in ipairs(M.get_signs()) do
        if s.name:find("GitSign") then
            git_sign = s
        elseif s.name:find("Diagnostic") then
            diagnostic_sign = s
        end
    end

    local num = ""
    local number = vim.api.nvim_win_get_option(vim.g.statusline_winid, "number")
    if number and vim.wo.relativenumber and vim.v.virtnum == 0 then
        num = vim.v.relnum == 0 and vim.v.lnum or vim.v.relnum
    end

    local components = {
        git_sign and ("%#" .. git_sign.texthl .. "#" .. trim(git_sign.text) .. "%*") or " ",
        diagnostic_sign and ("%#" .. diagnostic_sign.texthl .. "#" .. trim(diagnostic_sign.text) .. "%*") or " ",
        "%=",
        num .. " ",
    }

    return table.concat(components, " ")
end

return M