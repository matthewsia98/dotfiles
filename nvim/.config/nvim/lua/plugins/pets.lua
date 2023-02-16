return {
    "giusgad/pets.nvim",
    dependencies = {
        "edluffy/hologram.nvim",
    },
    cmd = { "PetsNew", "PetsNewCustom" },
    config = function()
        require("pets").setup({
            default_pet = "cat",
            default_style = "red",
            popup = {
                avoid_statusline = true,
            },
        })
    end,
}
