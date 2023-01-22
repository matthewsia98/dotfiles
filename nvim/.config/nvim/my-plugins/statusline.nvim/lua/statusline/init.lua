local M = {}

M.get_mode = function()
    --[[ n        Normal
    no       Operator-pending
    nov      Operator-pending (forced charwise |o_v|)
    noV      Operator-pending (forced linewise |o_V|)
    noCTRL-V Operator-pending (forced blockwise |o_CTRL-V|) CTRL-V is one character
    niI      Normal using |i_CTRL-O| in |Insert-mode|
    niR      Normal using |i_CTRL-O| in |Replace-mode|
    niV      Normal using |i_CTRL-O| in |Virtual-Replace-mode|
    nt       Normal in |terminal-emulator| (insert goes to Terminal mode)
    ntT      Normal using |t_CTRL-\_CTRL-O| in |Terminal-mode|
    v        Visual by character
    vs       Visual by character using |v_CTRL-O| in Select mode
    V        Visual by line
    Vs       Visual by line using |v_CTRL-O| in Select mode
    CTRL-V   Visual blockwise
    CTRL-Vs  Visual blockwise using |v_CTRL-O| in Select mode
    s        Select by character
    S        Select by line
    CTRL-S   Select blockwise
    i        Insert
    ic       Insert mode completion |compl-generic|
    ix       Insert mode |i_CTRL-X| completion
    R        Replace |R|
    Rc       Replace mode completion |compl-generic|
    Rx       Replace mode |i_CTRL-X| completion
    Rv       Virtual Replace |gR|
    Rvc      Virtual Replace mode completion |compl-generic|
    Rvx      Virtual Replace mode |i_CTRL-X| completion
    c        Command-line editing
    cv       Vim Ex mode |gQ|
    r        Hit-enter prompt
    rm       The -- more -- prompt
    r?       A |:confirm| query of some sort
    !        Shell or external command is executing
    t        Terminal mode: keys go to the job
    ]]

    local fullnames = {
        ["n"] = "NORMAL",
        ["no"] = "O-PENDING",
        ["nov"] = "O-PENDING",
        ["noV"] = "O-PENDING",
        ["no\22"] = "O-PENDING",
        ["niI"] = "NORMAL",
        ["niR"] = "NORMAL",
        ["niV"] = "NORMAL",
        ["nt"] = "NORMAL",
        ["ntT"] = "NORMAL",

        ["v"] = "VISUAL",
        ["V"] = "VISUAL",
        ["\22"] = "VISUAL",

        ["s"] = "SELECT",
        ["S"] = "SELECT",

        ["i"] = "INSERT",

        ["R"] = "REPLACE",

        ["c"] = "COMMAND",

        ["t"] = "TERMINAL",
    }

    local mode = vim.fn.mode()

    return "%#StatusLineMode#" .. string.format(" %s ", fullnames[mode] or mode) .. "%#Normal#"
end

M.get_filename = function(type)
    local filename
    if type == nil or type == "relative" then
        filename = vim.fn.expand("%:.")
    elseif type == "absolute" then
        filename = vim.fn.expand("%:p")
    elseif type == "tail" then
        filename = vim.fn.expand("%:t")
    end

    local readonly = vim.bo.readonly and " " or ""
    local modified = vim.bo.modified and " " or ""

    return "%#StatusLineFilename#" .. string.format(" %s%s%s ", filename, readonly, modified) .. "%#Normal#"
end

M.get_filetype = function()
    local filetype = vim.bo.filetype
    local icon = require("nvim-web-devicons").get_icon_by_filetype(filetype)

    return "%#StatusLineFiletype#" .. string.format(" %s %s ", icon, filetype) .. "%#Normal#"
end

M.get_filesize = function()
    local filepath = vim.fn.expand("%:p")
    local filesize = vim.fn.getfsize(filepath)

    local units = { "b", "kb", "mb", "gb" }
    local i = 1
    while filesize >= 1024 and i <= #units do
        filesize = filesize / 1024
        i = i + 1
    end

    return "%#StatusLineFilesize#" .. string.format(" %.2f%s ", filesize, units[i]) .. "%#Normal#"
end

M.get_diagnostic_counts = function(mode)
    local bufnr, mode_prefix
    if mode == nil or mode == "buffer" then
        bufnr = vim.api.nvim_get_current_buf()
        mode_prefix = "D"
    elseif mode == "workspace" then
        bufnr = nil
        mode_prefix = "W"
    end

    local error_count = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
    local warn_count = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN })
    local info_count = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.INFO })
    local hint_count = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.HINT })

    local error_sign = vim.fn.sign_getdefined("DiagnosticSignError")[1]
    local warn_sign = vim.fn.sign_getdefined("DiagnosticSignWarn")[1]
    local info_sign = vim.fn.sign_getdefined("DiagnosticSignInfo")[1]
    local hint_sign = vim.fn.sign_getdefined("DiagnosticSignHint")[1]

    local bg = vim.api.nvim_get_hl_by_name("StatusLineBufferDiagnostics", true).background
    local severities = { "Error", "Warn", "Info", "Hint" }
    for _, severity in ipairs(severities) do
        if vim.fn.hlexists("StatusLineDiagnostic" .. severity) == 0 then
            local fg = vim.api.nvim_get_hl_by_name("DiagnosticSign" .. severity, true).foreground
            vim.api.nvim_set_hl(0, "StatusLineDiagnostic" .. severity, {
                bg = bg,
                fg = fg,
            })
        end
    end

    local msg = ""
    if error_count > 0 then
        msg = msg .. "%#StatusLineDiagnosticError#" .. string.format("%s%d ", error_sign.text, error_count)
    end
    if warn_count > 0 then
        msg = msg .. "%#StatusLineDiagnosticWarn" .. string.format("%s%d ", warn_sign.text, warn_count)
    end
    if info_count > 0 then
        msg = msg .. "%#StatusLineDiagnosticInfo#" .. string.format("%s%d ", info_sign.text, info_count)
    end
    if hint_count > 0 then
        msg = msg .. "%#StatusLineDiagnosticHint#" .. string.format("%s%d ", hint_sign.text, hint_count)
    end

    local mode_prefix_hl
    if error_count > 0 then
        mode_prefix_hl = "StatusLineDiagnosticError"
    elseif warn_count > 0 then
        mode_prefix_hl = "StatusLineDiagnosticWarn"
    elseif info_count > 0 then
        mode_prefix_hl = "StatusLineDiagnosticInfo"
    elseif hint_count > 0 then
        mode_prefix_hl = "StatusLineDiagnosticHint"
    end

    if #msg > 0 then
        msg = string.format(" %s %s", "%#" .. mode_prefix_hl .. "#" .. mode_prefix, msg)
    end

    return "%#StatusLineBufferDiagnostics#" .. msg .. "%#Normal#"
end

M.get_line_diagnostic = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_row = vim.fn.line(".") - 1
    local cursor_col = vim.fn.col(".") - 1
    local diagnostics = vim.diagnostic.get(bufnr, {
        lnum = cursor_row,
    })

    if #diagnostics == 0 then
        return ""
    end

    local cursor_diagnostic
    for _, diagnostic in ipairs(diagnostics) do
        if cursor_col >= diagnostic.col and cursor_col <= diagnostic.end_col then
            cursor_diagnostic = diagnostic
            break
        end
    end

    -- If cursor not on diagnostic show most severe
    local most_severe_diagnostic
    if cursor_diagnostic == nil then
        for _, diagnostic in ipairs(diagnostics) do
            if most_severe_diagnostic == nil or diagnostic.severity < most_severe_diagnostic.severity then
                most_severe_diagnostic = diagnostic
            end
        end
    end

    local diagnostic = cursor_diagnostic or most_severe_diagnostic
    local severities = { "Error", "Warn", "Info", "Hint" }
    local sign_name = "DiagnosticSign" .. severities[diagnostic.severity]
    local sign = vim.fn.sign_getdefined(sign_name)[1]
    local icon = sign.text
    local hl = sign.texthl

    local MAX_MSG_LENGTH = 50
    local msg = string.format("%s [%s] %s", icon, diagnostic.source, diagnostic.message)
    if #msg > MAX_MSG_LENGTH then
        msg = string.sub(msg, 1, MAX_MSG_LENGTH) .. "..."
    end

    return "%#" .. hl .. "#" .. msg .. "%#Normal#"
end

M.setup_highlight_groups = function()
    local highlights = {
        StatusLineMode = { bg = "#0000FF", fg = "#FFFFFF" },
        StatusLineFilename = { bg = "#00FF00", fg = "#000000" },
        StatusLineFiletype = { bg = "#FFFF00", fg = "#000000" },
        StatusLineFilesize = { bg = "#FF0000", fg = "#FFFFFF" },
        StatusLineBufferDiagnostics = { bg = "#555555" },
    }

    for highlight_name, opts in pairs(highlights) do
        if vim.fn.hlexists(highlight_name) == 0 then
            vim.api.nvim_set_hl(0, highlight_name, opts)
        end
    end
end

M.update_statusline = function()
    local statusline = ""

    statusline = statusline .. M.get_mode()
    statusline = statusline .. M.get_diagnostic_counts("workspace")
    statusline = statusline .. M.get_diagnostic_counts("buffer")
    statusline = statusline .. "%="
    statusline = statusline .. M.get_line_diagnostic()
    statusline = statusline .. "%="
    statusline = statusline .. M.get_filename("relative")
    statusline = statusline .. M.get_filetype()
    statusline = statusline .. M.get_filesize()

    return statusline
end

return M
