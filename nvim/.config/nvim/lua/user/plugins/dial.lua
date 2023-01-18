local installed, augend = pcall(require, "dial.augend")

if installed then
    require("dial.config").augends:register_group({
        default = {
            augend.integer.alias.decimal,
            augend.integer.alias.hex,
            augend.date.alias["%Y/%m/%d"],
            augend.constant.alias.alpha,
            augend.constant.alias.Alpha,
            augend.constant.alias.bool,
        },
    })

    local keys = require("user.keymaps")

    keys.map("n", "<leader>z", function()
        return require("dial.map").dec_normal()
    end, { expr = true, desc = "" })

    keys.map("n", "<leader>a", function()
        return require("dial.map").inc_normal()
    end, { expr = true, desc = "" })
end
