local config = require("user.config")

local M = {}

local function get_diagnostics_symbols()
    local diagnostics_symbols = {
        error = " ",
        warn = " ",
        info = " ",
        hint = " ",
    }

    local defined_signs = {
        error = vim.fn.sign_getdefined("DiagnosticSignError")[1],
        warn = vim.fn.sign_getdefined("DiagnosticSignWarn")[1],
        info = vim.fn.sign_getdefined("DiagnosticSignInfo")[1],
        hint = vim.fn.sign_getdefined("DiagnosticSignHint")[1],
    }

    for severity, sign in pairs(defined_signs) do
        if sign ~= nil then
            diagnostics_symbols[severity] = sign.text
        end
    end

    return diagnostics_symbols
end

M.diagnostics_symbols = get_diagnostics_symbols()

M.separator = function()
    local style = config.lualine.separator_style or "box"
    if style == "slant" then
        return { left = "", right = "" }
    elseif style == "reverse_slant" then
        return { left = "", right = "" }
    elseif style == "powerline" then
        return nil
    elseif style == "round" then
        return { left = "", right = "" }
    elseif style == "box" then
        return { left = "▐", right = "▌" }
    end
end

M.spacer = function(opts)
    opts = opts or {}
    local char = " "
    local default_cond = function()
        return config.lualine.gap_between_sections
    end

    local cond
    if opts.cond and opts.force then
        cond = function()
            return opts.cond()
        end
    elseif opts.cond then
        cond = function()
            return opts.cond() and default_cond()
        end
    else
        cond = default_cond
    end

    return {
        function()
            return "%#Normal#" .. char:rep(opts.length or 1)
        end,
        cond = cond,
    }
end

M.cursor_diagnostic = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_row = vim.fn.line(".") - 1
    local cursor_col = vim.fn.col(".") - 1

    local diagnostics = vim.diagnostic.get(bufnr, { lnum = cursor_row })

    if #diagnostics == 0 then
        return ""
    end

    local cursor_diagnostic
    -- Check if cursor on diagnostic
    for _, diagnostic in ipairs(diagnostics) do
        if cursor_col >= diagnostic.col and cursor_col <= diagnostic.end_col then
            cursor_diagnostic = diagnostic
            break
        end
    end

    -- If cursor not on diagnostic, show max severity
    local max_severity_diagnostic
    if cursor_diagnostic == nil then
        for _, diagnostic in ipairs(diagnostics) do
            if max_severity_diagnostic == nil or diagnostic.severity < max_severity_diagnostic.severity then
                max_severity_diagnostic = diagnostic
            end
        end
        cursor_diagnostic = max_severity_diagnostic
    end

    local severities = { "Error", "Warn", "Info", "Hint" }
    local severity = severities[cursor_diagnostic.severity]
    local sign = vim.fn.sign_getdefined("DiagnosticSign" .. severity)[1]
    local icon = sign and sign.text or ""
    local source = cursor_diagnostic.source
    local msg = cursor_diagnostic.message:gsub("\n", " ")

    local max_diagnostic_msg_length = 100
    local include_icon = false
    local include_source = false
    local cursor_diagnostic_msg =
        string.format("%s%s %s", include_icon and icon or "", include_source and "[" .. source .. "]" or "", msg)

    if #cursor_diagnostic_msg > max_diagnostic_msg_length then
        cursor_diagnostic_msg = cursor_diagnostic_msg:sub(1, max_diagnostic_msg_length) .. "..."
    end

    return "%#" .. (sign and sign.texthl or "Diagnostic" .. severity) .. "#" .. cursor_diagnostic_msg
end

M.diagnostics = function(mode)
    local prefix = mode == "workspace" and "W" or "D"
    local source = mode == "workspace" and "nvim_workspace_diagnostic" or "nvim_diagnostic"
    local component = {
        "diagnostics",
        sources = { source },
        sections = { "error", "warn", "info", "hint" },
        symbols = M.diagnostics_symbols,
        colored = true,
        update_in_insert = false,
        always_visible = false,
        fmt = function(s)
            if #s > 0 then
                return string.format("%s %s", prefix, s)
            end
            return s
        end,
        color = function()
            local bufnr = mode == "workspace" and nil or vim.api.nvim_get_current_buf()
            local diagnostics = vim.diagnostic.get(bufnr)
            local max_severity = 4
            for _, diagnostic in ipairs(diagnostics) do
                if max_severity == nil or diagnostic.severity < max_severity then
                    max_severity = diagnostic.severity
                    if max_severity == 1 then
                        break
                    end
                end
            end

            local severity = string.lower(vim.diagnostic.severity[max_severity])
            return string.format("lualine_c_diagnostics_%s_normal", severity)
        end,
        separator = M.separator(),
    }

    return component
end

return M
