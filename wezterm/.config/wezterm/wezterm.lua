local wezterm = require("wezterm")

local catppuccin = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
catppuccin.tab_bar.background = catppuccin.background
catppuccin.tab_bar.active_tab.bg_color = "#89B4FA"

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function is_vim(pane)
    local process_name = basename(pane:get_foreground_process_name())
    return process_name == "nvim" or process_name == "vim"
end

local direction = {
    k = "Up",
    j = "Down",
    h = "Left",
    l = "Right",
}

local function focus(key)
    return {
        key = key,
        mods = "CTRL",
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
                -- pass the keys through to vim/nvim
                win:perform_action({
                    SendKey = { key = key, mods = "CTRL" },
                }, pane)
            else
                win:perform_action({ ActivatePaneDirection = direction[key] }, pane)
            end
        end),
    }
end

return {
    -- REFERENCE: https://wezfurlong.org/wezterm/config/lua/config/term.html
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

    window_decorations = "RESIZE",

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
            mods = "SUPER|SHIFT",
            key = "k",
            action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
        },
        {
            mods = "SUPER|SHIFT",
            key = "j",
            action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
        },
        {
            mods = "SUPER|SHIFT",
            key = "h",
            action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
        },
        {
            mods = "SUPER|SHIFT",
            key = "l",
            action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
        },
        {
            mods = "SUPER|CTRL",
            key = " ",
            action = wezterm.action.PaneSelect({
                mode = "SwapWithActive",
            }),
        },

        -- move focus between wezterm panes and vim windows
        focus("k"),
        focus("j"),
        focus("h"),
        focus("l"),
    },
}
