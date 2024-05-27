return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
        require("harpoon"):setup({
            settings = {
                save_on_toggle = true,
            },
        })

        require("telescope").load_extension("harpoon")
    end,
    keys = {
        {
            "<leader>hm",
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list(), {
                    border = "rounded",
                    title_pos = "center",
                    ui_width_ratio = 0.7,
                })
            end,
            desc = "Harpoon Toggle Menu",
        },
        {
            "<leader>ha",
            function()
                require("harpoon"):list():add()
            end,
            desc = "Harpoon Add File",
        },
        {
            "<leader>ht",
            "<CMD>Telescope harpoon marks<CR>",
            desc = "Harpoon Marks",
        },
    },
}
