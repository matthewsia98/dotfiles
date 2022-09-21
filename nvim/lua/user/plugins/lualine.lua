local installed, lualine = pcall(require, 'lualine')

if installed then
    lualine.setup {
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
                {
                    'diagnostics',
                    separator = '',
                    sources = { 'nvim_workspace_diagnostic' },
                    sections = { 'error', 'warn', 'info', 'hint' },
                    diagnostics_color = {
                        error = 'DiagnosticSignError',
                        warn  = 'DiagnosticSignWarn',
                        info  = 'DiagnosticSignInfo',
                        hint  = 'DiagnosticSignHint',
                    },
                    symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                    colored = true,
                    update_in_insert = true,
                    always_visible = false,
                },
                {
                    'diagnostics',
                    sources = { 'nvim_diagnostic' },
                    sections = { 'error', 'warn', 'info', 'hint' },
                    diagnostics_color = {
                        error = 'DiagnosticSignError',
                        warn  = 'DiagnosticSignWarn',
                        info  = 'DiagnosticSignInfo',
                        hint  = 'DiagnosticSignHint',
                    },
                    symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                    colored = true,
                    update_in_insert = true,
                    always_visible = false,
                },
            },
            lualine_x = {},
            lualine_y = { 'encoding', 'fileformat', },
            lualine_z = { 'location', 'progress' },
        },
        -- tabline = {
        --   lualine_a = {'buffers'},
        --   lualine_b = {},
        --   lualine_c = {},
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = {'tabs'}
        -- },
        -- winbar = {
        --     lualine_a = {},
        --     lualine_b = {},
        --     lualine_c = {},
        --     lualine_x = {},
        --     lualine_y = {},
        --     lualine_z = { 'filename' }
        -- },
        -- inactive_winbar = {
        --     lualine_a = {},
        --     lualine_b = {},
        --     lualine_c = {},
        --     lualine_x = {},
        --     lualine_y = {},
        --     lualine_z = { 'filename' }
        -- },
    }

    local cp_installed, cp = pcall(require, 'catppuccin.palettes')
    if cp_installed then
        cp = cp.get_palette()
        vim.defer_fn(function()
            vim.cmd('highlight lualine_c_normal guibg=' .. cp.base)
            vim.cmd('highlight lualine_transitional_lualine_b_normal_to_lualine_c_normal guibg=' .. cp.base)
        end, 300)
    end
end

