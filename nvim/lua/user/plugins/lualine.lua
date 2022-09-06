require('lualine').setup {
    options = {
        theme = 'catppuccin',
        icons_enabled = true,
        -- powerline    
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' }
    },
    -- a b c                x y z
    sections = {
        -- 'mode', 'branch', 'diff', 'diagnostics', 'filename', 'encoding', 'fileformat', 'filetype', 'progress', 'location'
        lualine_a = { 'mode', },
        lualine_b = { 'branch' },
        lualine_c = {
            { 'diagnostics',
                sources = { 'nvim_lsp' },
                sections = { 'error', 'warn', 'info', 'hint' },
                diagnostics_color = {
                    error = 'DiagnosticError',
                    warn  = 'DiagnosticWarn',
                    info  = 'DiagnosticInfo',
                    hint  = 'DiagnosticHint',
                },
                -- symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
                colored = true,
                update_in_insert = true,
                always_visible = false,
            },
        },
        lualine_x = {},
        lualine_y = { 'encoding', 'fileformat', },
        lualine_z = { 'progress', 'location' },
    },
    tabline = {},
    winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'filename' }
    },
    inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'filename' }
    },
}
