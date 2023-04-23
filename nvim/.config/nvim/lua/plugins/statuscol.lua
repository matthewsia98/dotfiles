return {
    "luukvbaal/statuscol.nvim",
    enabled = true,
    event = "VeryLazy",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            -- thousands = ",",
            segments = {
                {
                    sign = { name = { "GitSign" }, auto = true },
                    click = "v:lua.ScSa",
                },
                {
                    sign = { name = { "Diagnostic" }, auto = true },
                    click = "v:lua.ScSa",
                },
                {
                    sign = { name = { "Dap" }, colwidth = 1, auto = true },
                    click = "v:lua.ScSa",
                },
                {
                    text = { " ", builtin.lnumfunc },
                    click = "v:lua.ScLa",
                },
                {
                    text = { " ", builtin.foldfunc, " " },
                    click = "v:lua.ScFa",
                },
            },
        })
    end,
}
