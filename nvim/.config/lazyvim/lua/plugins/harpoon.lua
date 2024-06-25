return {
    "ThePrimeagen/harpoon",
    keys = {
        { "<leader>h", false },
        { "<leader>H", false },
        {
            "<leader>hm",
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list(), {
                    border = "rounded",
                    title_pos = "center",
                })
            end,
            desc = "Harpoon Quick Menu",
        },
        {
            "<leader>ha",
            function()
                require("harpoon"):list():add()
            end,
            desc = "Harpoon File",
        },
    },
}
