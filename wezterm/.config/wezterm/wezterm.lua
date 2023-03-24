local wezterm = require("wezterm")

local catppuccin = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
catppuccin.tab_bar.background = catppuccin.background
catppuccin.tab_bar.active_tab.bg_color = "#89B4FA"

return {
    term = "wezterm",

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
    hide_tab_bar_if_only_one_tab = true,
    window_frame = {
        active_titlebar_bg = catppuccin.tab_bar.background,
        inactive_titlebar_bg = catppuccin.tab_bar.background,
    },

    keys = {
        {
            mods = "SUPER",
            key = "w",
            action = wezterm.action.CloseCurrentTab({ confirm = true }),
        },
        {
            mods = "SUPER",
            key = "v",
            action = wezterm.action.SplitPane({ direction = "Right" }),
        },
        {
            mods = "SUPER",
            key = "s",
            action = wezterm.action.SplitPane({ direction = "Down" }),
        },
        {
            mods = "SUPER",
            key = "c",
            action = wezterm.action.CloseCurrentPane({ confirm = true }),
        },
        {
            mods = "SUPER",
            key = "k",
            action = wezterm.action.ActivatePaneDirection("Up"),
        },
        {
            mods = "SUPER",
            key = "j",
            action = wezterm.action.ActivatePaneDirection("Down"),
        },
        {
            mods = "SUPER",
            key = "h",
            action = wezterm.action.ActivatePaneDirection("Left"),
        },
        {
            mods = "SUPER",
            key = "l",
            action = wezterm.action.ActivatePaneDirection("Right"),
        },
        {
            mods = "SUPER|CTRL",
            key = " ",
            action = wezterm.action.PaneSelect({
                mode = "SwapWithActive",
            }),
        },
    },
}
