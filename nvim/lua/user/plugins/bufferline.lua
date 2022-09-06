local installed, bufferline = pcall(require, 'bufferline')

if installed then
    bufferline.setup {
        options = {
            mode = "buffers", -- set to "tabs" to only show tabpages instead
            numbers = function(tbl)
                -- ordinal, id
                return tbl['id'] .. '.'
            end,
            close_command = "bdelete! %d",
            right_mouse_command = "bdelete! %d",
            left_mouse_command = "buffer %d",
            middle_mouse_command = nil,
            indicator = {
                -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
                -- style = 'icon', -- 'icon' | 'underline' | 'none',
                style = 'underline',
            },
            buffer_close_icon = '',
            modified_icon = '● ',
            close_icon = ' ',
            left_trunc_marker = ' ',
            right_trunc_marker = ' ',
            name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
                return buf.name
            end,
            max_name_length = 18,
            max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
            tab_size = 18,
            diagnostics = 'nvim_lsp', -- false | "nvim_lsp" | "coc",
            diagnostics_update_in_insert = true,
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                return "("..count..")"
            end,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = 'File Explorer', -- "File Explorer" | function ,
                    text_align = 'left',
                    separator = true,
                }
            },
            color_icons = true, -- whether or not to add the filetype icon highlights
            show_buffer_icons = true, -- disable filetype icons for buffers
            show_buffer_close_icons = true,
            show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
            show_close_icon = false,
            show_tab_indicators = true,
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            separator_style = { '', '' }, -- "slant" | "thick" | "thin" | { 'any', 'any' },
            enforce_regular_tabs = true,
            always_show_bufferline = true,
            -- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' |
            -- 'tabs' | function(buffer_a, buffer_b)
            sort_by = 'insert_at_end',
        },
        highlights = {
            fill = {
                bg = catppuccin_palette.mantle,
            },
        },
    }

    -- Buffers
    -- These commands will navigate through buffers in order regardless of which mode you are using
    -- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
    map('n', '<C-b>l', '<cmd>BufferLineCycleNext<CR>')
    map('n', '<C-b>h', '<cmd>BufferLineCyclePrev<CR>')

    -- These commands will move the current buffer backwards or forwards in the bufferline
    map('n', '<C-b>L', '<cmd>BufferLineMoveNext<CR>')
    map('n', '<C-b>H', '<cmd>BufferLineMovePrev<CR>')
    map('n', '<C-b>b', '<cmd>ls<CR><cmd>buffer<Space>')
    map('n', '<C-b>c', '<cmd>bdelete<CR>')

    -- Tabs
    map('n', '<C-t>v', '<cmd>tabnew<CR>')
    map('n', '<C-t>l', '<cmd>tabnext<CR>')
    map('n', '<C-t>h', '<cmd>tabprev<CR>')
    map('n', '<C-t>c', '<cmd>tabclose<CR>')
end
