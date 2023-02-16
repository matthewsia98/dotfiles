return {
    "giusgad/pets.nvim",
    cmd = { "PetsNew", "PetsNewCustom" },
    config = function()
        require("pets").setup({
            default_pet = "cat",
            default_style = "red",
        })
    end,
}
