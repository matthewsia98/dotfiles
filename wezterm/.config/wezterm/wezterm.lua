local wezterm = require("wezterm")

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.tab_bar.background = "#11111B"
custom.tab_bar.active_tab.bg_color = "#CBA6F7"
custom.tab_bar.active_tab.fg_color = "#11111B"
custom.tab_bar.inactive_tab.bg_color = "#181825"
custom.tab_bar.inactive_tab.fg_color = "#CDD6F4"
custom.tab_bar.new_tab.bg_color = "#11111B"

return {
    font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", italic = true }),
    font_size = 12.0,

    color_schemes = {
        ["custom"] = custom,
    },
    color_scheme = "custom",

    use_fancy_tab_bar = false,
}
