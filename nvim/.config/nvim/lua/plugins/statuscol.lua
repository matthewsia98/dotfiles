return {
    "luukvbaal/statuscol.nvim",
    enabled = true,
    event = "VeryLazy",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            segments = {
                { sign = { name = { "GitSign" } }, click = "v:lua.ScSa" },
                { sign = { name = { "Diagnostic" } }, click = "v:lua.ScSa" },
                { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
                { text = { " ", builtin.foldfunc, " " }, click = "v:lua.ScFa" },
            },
        })
    end,
}
