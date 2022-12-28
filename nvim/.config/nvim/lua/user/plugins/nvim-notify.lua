local installed, notify = pcall(require, "notify")

if installed then
    notify.setup({
        background_colour = require("catppuccin.palettes").get_palette().base,
        timeout = 3000,
    })
    vim.notify = notify
end
