local installed, nvim_tree = pcall(require, "nvim-tree")

if installed then
    nvim_tree.setup({
        update_focused_file = {
            enable = true,
        },
        sort_by = "case_sensitive",
        view = {
            adaptive_size = false,
            width = math.floor(vim.o.columns / 4),
            float = {
                enable = false,
            },
            mappings = {
                list = {
                    { key = "u", action = "dir_up" },
                    { key = "<CR>", action = "edit_in_place" },
                },
            },
        },
        git = {
            enable = true,
            ignore = true,
            show_on_dirs = true,
            timeout = 400,
        },
        diagnostics = {
            enable = false,
        },
        renderer = {
            group_empty = true,
            indent_markers = {
                enable = true,
            },
        },
        filters = {
            dotfiles = false,
        },
    })

    local keys = require("user.keymaps")
    keys.map("n", "<leader>nt", function()
        nvim_tree.toggle()
    end, { desc = "Toggle NvimTree" })
end
