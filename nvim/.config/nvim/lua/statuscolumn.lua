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

M.get = function()
    local number = vim.api.nvim_win_get_option(vim.g.statusline_winid, "number")
    if not number then
        return ""
    end

    local num = ""
    if vim.wo.relativenumber and vim.v.virtnum == 0 then
        num = vim.v.relnum == 0 and vim.v.lnum or vim.v.relnum
    end

    local diagnostic_sign, git_sign, dap_sign
    for _, s in ipairs(M.get_signs()) do
        if s.name:find("GitSign") then
            git_sign = s
        elseif s.name:find("Diagnostic") then
            diagnostic_sign = s
        elseif s.name:find("Dap") then
            dap_sign = s
        end
    end

    local diagnostic
    for _, client in ipairs(vim.lsp.get_clients()) do
        local capabilities = client.config.capabilities
        if capabilities and capabilities.textDocument.publishDiagnostics then
            diagnostic = true
            break
        end
    end

    local dap = vim.g.dap_available_adapters and vim.tbl_contains(vim.g.dap_available_adapters, vim.bo.filetype)

    local components = {
        (
            vim.g.gitsigns_attached
                and (git_sign and ("%#" .. git_sign.texthl .. "#" .. trim(git_sign.text) .. "%*") or " ")
            or ""
        ),
        (
            diagnostic
                and (diagnostic_sign and (" %#" .. diagnostic_sign.texthl .. "#" .. trim(diagnostic_sign.text) .. "%* ") or "  ")
            or ""
        ),
        "%=",
        (dap and (dap_sign and (" %#" .. dap_sign.texthl .. "#" .. trim(dap_sign.text) .. "%*  ") or "  ") or ""),
        num,
        " ",
        "%C",
        " ",
    }

    return table.concat(components, "")
end

return M
