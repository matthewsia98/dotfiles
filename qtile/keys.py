from functions import (
    grow_window,
    move_window,
    normalize,
    toggle_floating,
    toggle_widgetbox,
    toggle_minmax,
    flip_layout,
    kill_all,
)
from groups import groups
from libqtile.config import Drag, Key
from libqtile.lazy import lazy

# 1: alt    4: super
mod = "mod1"

keys = [
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "w", kill_all(), desc="Kill all windows"),
    # Control Window Size
    Key([mod], "m", toggle_minmax("min"), desc="Toggle minimize"),
    Key([mod, "shift"], "m", toggle_minmax("max"), desc="Toggle maximize"),
    # Move Windows
    Key([mod, "control"], "k", move_window("k"), desc="Move floating window up"),
    Key([mod, "control"], "j", move_window("j"), desc="Move floating window down"),
    Key([mod, "control"], "h", move_window("h"), desc="Move floating window left"),
    Key([mod, "control"], "l", move_window("l"), desc="Move floating window right"),
    # Key(
    #     [mod, "control"],
    #     "c",
    #     toggle_floating(center=True),
    #     desc="Toggle floating and center",
    # ),
    Key([mod, "control"], "f", toggle_floating(center=True), desc="Toggle floating and center"),
    Key([mod], "space", flip_layout(), desc="Flip layout"),
    # Resize Windows
    Key([mod, "shift"], "h", grow_window("h"), desc="Grow window to the left"),
    Key([mod, "shift"], "l", grow_window("l"), desc="Grow window to the right"),
    Key([mod, "shift"], "j", grow_window("j"), desc="Grow window down"),
    Key([mod, "shift"], "k", grow_window("k"), desc="Grow window up"),
    Key([mod, "shift"], "n", normalize(), desc="Reset all window sizes"),
    # Focus Windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "n", lazy.layout.group.next_window(), desc="Move focus to next window"),
    Key(
        [mod],
        "p",
        lazy.layout.group.prev_window(),
        desc="Move focus to previous window",
    ),
    # Toggle WidgetBoxes
    Key([mod, "shift"], "1", toggle_widgetbox(1), desc="Toggle widgetbox 1"),
    Key([mod, "shift"], "2", toggle_widgetbox(2), desc="Toggle widgetbox 2"),
    # Launch Programs
    Key([mod], "Return", lazy.spawn("kitty"), desc="Launch terminal"),
    Key(
        [mod],
        "r",
        lazy.spawn("rofi -show drun"),
        desc="Spawn a command using a prompt widget",
    ),
    Key([mod], "f", lazy.spawn("pcmanfm"), desc="Launch file manager"),
    # Misc
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle through layouts"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
]


mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button2", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
]


for group in groups:
    keys.extend(
        [
            Key(
                [mod],
                group.name,
                lazy.group[group.name].toscreen(),
                desc=f"Switch to group {group.name}",
            ),
            Key(
                [mod, "control"],
                group.name,
                lazy.window.togroup(group.name, switch_group=True),
                desc=f"Switch to & move focused window to group {group.name}",
            ),
        ]
    )
