local M = {}


local function get_max_line_width(lines)
    if #lines == 0 then
        return -1
    end

    local max_width
    for _, line in ipairs(lines) do
        if not max_width or #line > max_width then
            max_width = #line
        end
    end

    return max_width
end


M.init = function()
    vim.api.nvim_set_hl(0, 'MyFloatBorder', { bg = '#000000', fg = '#FF00FF' })
    vim.api.nvim_set_hl(0, 'MyNormalFloat', { bg = '#FF0000', fg = '#00FF00' })
    vim.api.nvim_set_hl(0, 'MyFloatTitle', { bg = '#FFFF00', fg = '#00FFFF' })
end


M.open = function(lines)
    local win_opts = {
        relative = "editor", -- REQUIRED    'editor' | 'win' | 'cursor'
        -- win = 0,  -- window handle for relative = 'win'
        anchor = "NW", -- DEFAULT: 'NW'    'NW' | 'NE' | 'SW' | 'SE'    (0, 0) coordinate will be based on corner chosen
        -- width = max_width, -- window width in character cells
        -- height = #lines, -- window height in character cells
        -- bufpos = { 20, 20 },  -- DEFAULT: { 1, 0 } if anchor = 'NW' | 'NE', { 0, 0 } if anchor = 'SW' | 'SE'  place float relative to buffer text when relative = 'win'
        -- row = 1, -- row position in units of screen cell height
        -- col = 4, -- column position in units of screen cell width
        -- focusable = true,  -- DEFAULT: true    true | false    enable focus by user actions (wincmds, mouse). Non-focusable windows can be entered by nvim_set_current_win
        zindex = 50, -- DEFAULT: 50
        style = "minimal", -- Disables 'number', 'relativenumber', 'cursorline', 'cursorcolumn', 'foldcolumn', 'spell' and 'list' options
        border = "rounded", -- DEFAULT: 'none'    'none' | 'single' | 'double' | 'rounded' | 'solid' | 'shadow' | { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }
        title = "My Title", -- string | list { { text, highlight }, }
        title_pos = "center", -- DEFAULT: 'left'    'left' | 'center' | 'right'
        noautocmd = true, -- don't fire buffer autocommands (BufEnter, BufLeave, BufWinEnter)
    }

    if not M.buf then
        if lines == nil then
            lines = {
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                'Sed non risus. Suspendisse lectus tortor, dignissim sit amet,',
                'adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam.',
                'Maecenas ligula massa, varius a, semper congue, euismod non, mi.',
                'Proin porttitor, orci nec nonummy molestie, enim est eleifend mi,',
            }
                -- return
        end

        M.max_width = get_max_line_width(lines)
        M.height = #lines

        M.buf = vim.api.nvim_create_buf(
            false, -- sets buflisted
            true -- create throwaway scratch-buffer (sets nomodified and nomodeline) on buffer
        )
        vim.api.nvim_buf_set_lines(
            M.buf, -- buffer handle
            0, -- start row (0-based, end exclusive)
            -1, -- end row (0-based, end exclusive)
            true, -- out of bounds indices are clamped to nearest valid value if false
            lines and lines or {} -- replacement lines    set to {} to delete lines
        )

        vim.keymap.set("n", "q", function()
            M.close()
        end, { buffer = M.buf })
    end

    win_opts.width = M.max_width
    win_opts.height = M.height
    win_opts.row = math.floor(vim.api.nvim_win_get_height(0) / 2) - math.floor(M.height / 2)
    win_opts.col = math.floor(vim.api.nvim_win_get_width(0) / 2) - math.floor(M.max_width / 2)
    M.win = vim.api.nvim_open_win(M.buf, true, win_opts)
    M.is_open = true
    vim.api.nvim_win_set_option(M.win, "cursorline", true)
    vim.api.nvim_win_set_option(M.win, "winhl", "NormalFloat:MyNormalFloat,FloatBorder:MyFloatBorder,FloatTitle:MyFloatTitle")
    -- vim.api.nvim_win_set_option(M.win, "winhl", "FloatBorder:MyFloatBorder")

    return M.win, M.buf
end


M.close = function()
    if M.is_open then
        vim.api.nvim_win_hide(M.win)
        M.is_open = false
    end
end


M.update_buffer = function(lines)
    if not lines or #lines < 1 then
        return
    end
    vim.api.nvim_buf_set_lines(
        M.buf, -- buffer handle
        0, -- start row (0-based, end exclusive)
        -1, -- end row (0-based, end exclusive)
        true, -- strict indexing (out of bounds indices are clamped to nearest valid value if false)
        lines and lines or {} -- replacement lines    set to {} to delete lines
    )
    M.max_width = get_max_line_width(lines)
    M.height = #lines

    if not M.is_open then
        M.open()
    else
        M.close()
        M.open()
    end
end


M.init()


return M
