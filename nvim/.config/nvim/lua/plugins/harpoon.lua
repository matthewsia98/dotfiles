return {
    "ThePrimeagen/harpoon",
    config = function()
        require("harpoon").setup({
            menu = {
                width = math.floor(vim.o.columns * 0.5),
                height = math.floor(vim.o.lines * 0.5),
            },
        })
    end,
    keys = {
        {
            "<leader>ht",
            function()
                require("harpoon.ui").toggle_quick_menu()
            end,
            desc = "Harpoon Toggle Menu",
        },
        {
            "<leader>ha",
            function()
                require("harpoon.mark").add_file()
            end,
            desc = "Harpoon Add File",
        },
    },
}
