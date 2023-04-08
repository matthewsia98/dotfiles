local navbuddy = require("nvim-navbuddy")
-- local actions = require("nvim-navbuddy.actions")

navbuddy.setup({
    use_default_mappings = true,

    window = {
        border = "rounded",
        size = "90%",
    },

    -- VSCode icons
    icons = {
        File = " ",
        Module = " ",
        Namespace = " ",
        Package = " ",
        Class = " ",
        Method = " ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = " ",
        Interface = " ",
        Function = " ",
        Variable = " ",
        Constant = " ",
        String = " ",
        Number = " ",
        Boolean = " ",
        Array = " ",
        Object = " ",
        Key = " ",
        Null = " ",
        EnumMember = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
    },
})
