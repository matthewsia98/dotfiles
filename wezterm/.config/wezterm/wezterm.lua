local wezterm = require("wezterm")

local catppuccin = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
catppuccin.tab_bar.background = "#1E1E2E"
catppuccin.tab_bar.active_tab.bg_color = "#11111B"
catppuccin.tab_bar.inactive_tab.bg_color = "#1E1E2E"

return {
    font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" }),
    font_size = 12.0,

    color_schemes = { ["catppuccin"] = catppuccin },
    color_scheme = "catppuccin",
    colors = {
        tab_bar = {
            active_tab = {
                bg_color = catppuccin.tab_bar.active_tab.bg_color,
                fg_color = catppuccin.tab_bar.active_tab.fg_color,
            },
            inactive_tab = {
                bg_color = catppuccin.tab_bar.inactive_tab.bg_color,
                fg_color = catppuccin.tab_bar.inactive_tab.fg_color,
            },
            new_tab = {
                bg_color = catppuccin.tab_bar.new_tab.bg_color,
                fg_color = catppuccin.tab_bar.new_tab.fg_color,
            },
        },
    },

    use_fancy_tab_bar = true,
    window_frame = {
        active_titlebar_bg = catppuccin.tab_bar.background,
        inactive_titlebar_bg = catppuccin.tab_bar.background,
    },

    keys = {
        {
            key = "w",
            mods = "CMD",
            action = wezterm.action.CloseCurrentTab({ confirm = true }),
        },
    },
}
