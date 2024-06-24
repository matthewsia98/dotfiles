return {
    "ThePrimeagen/harpoon",
    keys = {
        {
            "<leader>h",
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list(), {
                    border = "rounded",
                    title_pos = "center",
                })
            end,
        },
    },
}
