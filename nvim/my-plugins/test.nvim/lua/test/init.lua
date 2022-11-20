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


M.open = function(lines)
    local win_opts = {
        relative = "editor", -- REQUIRED    'editor' | 'win' | 'cursor'
        -- win = 0,  -- window handle for relative = 'win'
        anchor = "NW", -- DEFAULT: 'NW'    'NW' | 'NE' | 'SW' | 'SE'    (0, 0) coordinate will be based on corner chosen
        -- width = max_width, -- window width in character cells
        -- height = #lines, -- window height in character cells
        -- bufpos = { 50, 50 },  -- DEFAULT: { 1, 0 } if anchor = 'NW' | 'NE', { 0, 0 } if anchor = 'SW' | 'SE'  place float relative to buffer text when relative = 'win'
        row = 1, -- row position in units of screen cell height
        col = 4, -- column position in units of screen cell width
        -- focusable = true,  -- DEFAULT: true    true | false    enable focus by user actions (wincmds, mouse). Non-focusable windows can be entered by nvim_set_current_win
        zindex = 50, -- DEFAULT: 50
        style = "minimal",
        border = "rounded", -- DEFAULT: 'none'    'none' | 'single' | 'double' | 'rounded' | 'solid' | 'shadow' | { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }
        noautocmd = true, -- don't fire buffer autocommands (BufEnter, BufLeave, BufWinEnter)
    }

    if M.buf then
        win_opts.width = M.max_width
        win_opts.height = M.height
        M.win = vim.api.nvim_open_win(M.buf, true, win_opts)
    else
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
        if M.max_width == -1 then
            return
        end
        win_opts.width = M.max_width
        win_opts.height = M.height

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

        M.win = vim.api.nvim_open_win(
            M.buf, -- buffer handle
            true, -- enter window
            win_opts
        )
        -- optional: change highlight, otherwise Pmenu is used
        vim.api.nvim_win_set_option(M.win, "winhl", "Normal:NormalFloat")

        vim.keymap.set("n", "q", function()
            vim.api.nvim_win_hide(M.win)
        end, { buffer = M.buf })
    end
    return M.win, M.buf
end


return M
