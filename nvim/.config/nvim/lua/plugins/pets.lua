return {
    "giusgad/pets.nvim",
    enabled = false,
    dependencies = {
        "giusgad/hologram.nvim",
        "MunifTanjim/nui.nvim",
    },
    cmd = { "PetsNew", "PetsNewCustom" },
    config = function()
        require("pets").setup({
            default_pet = "cat",
            default_style = "red",
            row = 5,
            popup = {
                avoid_statusline = true,
                hl = { Normal = "Normal" },
                -- If too big, will cover buffer text on the bottom left
                width = "30%",
            },
        })
    end,
}
