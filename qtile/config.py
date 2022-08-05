import os
import subprocess

# from libqtile.log_utils import logger
from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy


#### GLOBALS ####
picom_on = None
colors = [
    '#FFAAFF',  # lightpink
    '#FFB86C',  # orange
    '#F1FA8C',  # yellow
    '#50FA7B',  # green
    '#00AAFF',  # darkblue
    '#5F55FF',  # purple
    '#FF55FF',  # pink
    '#24273A',  # black
    '#F8F8F2',  # white
    '#8700FF',  # darkpurple
    '#00FFFF'   # cyan
]


#### FUNCTIONS ####
@hook.subscribe.startup
def autostart():
    global picom_on
    picom_on = True
    picom_textbox = qtile.widgets_map.get('picom_toggle')
    if picom_textbox is not None and picom_textbox.text in ['\uf205', '\uf204']:
        picom_textbox.update('\uf205' if picom_on else '\uf204')

    info_box = qtile.widgets_map.get('info_box')
    if not info_box.box_is_open:
        info_box.cmd_toggle()

    clock_left_powerline = qtile.widgets_map.get('clock_left_powerline')
    clock_left_powerline.background = colors[4] if info_box.box_is_open else colors[1]


def is_muted():
    output = str(subprocess.check_output(['pactl', 'get-sink-mute', '@DEFAULT_SINK@']))
    return 'yes' in output


def raise_volume(*args):
    if is_muted():
        subprocess.run(['pactl', 'set-sink-mute', '@DEFAULT_SINK@', '0'])
    else:
        subprocess.run(['pactl', 'set-sink-volume', '@DEFAULT_SINK@', '+5%'])


def toggle_picom():
    global picom_on
    output = int(subprocess.check_output(os.path.expanduser('~/.shell-scripts/qtile/toggle-picom.sh')))
    picom_on = (output == 1)
    picom_textbox = qtile.widgets_map.get('picom_toggle')
    if picom_textbox is not None and picom_textbox.text in ['\uf205', '\uf204']:
        picom_textbox.update('\uf205' if picom_on else '\uf204')


@lazy.window.function
def center_and_resize_floating(window):
    window.toggle_floating()

    if window.floating:
        window.cmd_set_size_floating(int(1920 * 0.7), int(1080 * 0.7))
        window.cmd_center()


def grow_floating(window, direction, width_step=32, height_step=32):
    if direction in 'hl':
        grow_width = width_step if direction == 'l' else -width_step
        window.cmd_set_size_floating(window.width + grow_width, window.height)
    else:
        grow_height = height_step if direction == 'k' else -height_step
        window.cmd_set_size_floating(window.width, window.height + grow_height)
    window.cmd_center()


@lazy.function
def grow_horizontal(qtile, direction):
    curr_window = qtile.current_window
    if curr_window.floating:
        grow_floating(curr_window, direction)
    else:
        group = qtile.current_window.group
        main_window = group.windows[0]
        curr_window_x = curr_window.cmd_get_position()[0]
        window_xs = [window.cmd_get_position()[0] for window in group.windows]
        curr_layout = qtile.current_layout

        if max(window_xs) > curr_window_x:
            # curr_window is on left
            if (curr_window == main_window):
                curr_layout.cmd_shrink_main() if direction == 'h' else curr_layout.cmd_grow_main()
            else:
                curr_layout.cmd_grow_main() if direction == 'h' else curr_layout.cmd_shrink_main()
        else:
            # curr_window is on right
            if (curr_window == main_window):
                curr_layout.cmd_grow_main() if direction == 'h' else curr_layout.cmd_shrink_main()
            else:
                curr_layout.cmd_shrink_main() if direction == 'h' else curr_layout.cmd_grow_main()


@lazy.function
def grow_vertical(qtile, direction):
    curr_window = qtile.current_window
    if curr_window.floating:
        grow_floating(curr_window, direction)
    else:
        curr_layout = qtile.current_layout
        group = qtile.current_window.group
        curr_window_y = curr_window.cmd_get_position()[1]
        window_ys = [window.cmd_get_position()[1] for window in group.windows]

        if min(window_ys) == curr_window_y:
            # curr window is at top
            curr_layout.cmd_shrink() if direction == 'k' else curr_layout.cmd_grow()
        else:
            # curr window is in middle or bottom
            curr_layout.cmd_grow() if direction == 'k' else curr_layout.cmd_shrink()


@lazy.function
def expand_info(qtile):
    info_box = qtile.widgets_map.get('info_box')
    info_box.cmd_toggle()
    clock_left_powerline = qtile.widgets_map.get('clock_left_powerline')
    clock_left_powerline.background = colors[4] if info_box.box_is_open else colors[1]


@lazy.function
def toggle_program(qtile, program):
    return_code = subprocess.run(['pgrep', program]).returncode
    qtile.cmd_spawn(program) if return_code == 1 else subprocess.run(['killall', program])


# 1 alt
# 4 super
mod = "mod1"
terminal = 'kitty'


#### KEYBINDS ####
keys = [
    Key([], 'Print', lazy.spawn('scrot -s /home/siam/Pictures/Screenshots/%Y-%m-%d-%T-screenshot.png'), desc='Take a screenshot'),
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "control"], "h", lazy.layout.swap_left(), desc="Move window to the left"),
    Key([mod, "control"], "l", lazy.layout.swap_right(), desc="Move window to the right"),
    Key([mod, "control"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "control"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "control"], "p", lazy.group.prev_window(), desc="Move focus to previous window"),
    Key([mod, "control"], "n", lazy.group.next_window(), desc="Move focus to next window"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "shift"], "h", grow_horizontal('h'), desc="Grow window to the left"),
    Key([mod, "shift"], "l", grow_horizontal('l'), desc="Grow window to the right"),
    Key([mod, "shift"], "j", grow_vertical('j'), desc="Grow window down"),
    Key([mod, "shift"], "k", grow_vertical('k'), desc="Grow window up"),

    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, 'control'], 'space', lazy.layout.flip(), desc='Flip main side'),
    Key([mod], "m", lazy.window.toggle_maximize(), desc="Toggle maximize"),
    Key([mod, 'control'], "f", center_and_resize_floating(), desc="Toggle floating"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    Key([mod], 'f', lazy.spawn('pcmanfm'), desc='Launch File Manager'),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawn('rofi -show drun'), desc="Spawn a command using a prompt widget"),
]

#### GROUPS ####
groups = [
    Group(name='1', label='\ue235', spawn=None),
    Group(name='2', label='\ufb10', spawn='discord'),
    Group(name='3', label='\uf6ed', spawn='thunderbird'),
    Group(name='4', label='\uf269', spawn='firefox'),
    Group(name='5', label='\uf313', spawn=None)
]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f'Switch to group {i.name}'
            ),
            # mod1 + control + letter of group = switch to & move focused window to group
            Key(
                [mod, "control"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f'Switch to & move focused window to group {i.name}'
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )


#### LAYOUTS####
layouts = [
    # layout.Columns(margin_on_single=10, margin=5, border_normal='#24273A', border_focus='#00FFFF', border_width=4),
    # layout.Max(),
    ## Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(single_border_width=0, single_margin=0, margin=20, border_normal='#1e1f28', border_focus='#00ffff', border_width=4),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

#### WIDGETS ####
widget_defaults = dict(
    # font='Ubuntu Mono Nerd Font Bold',
    font="RobotoMono Nerd Font Bold",
    fontsize=20,
    padding=3,
    background='#778899',
    foreground='#000000'
)
extension_defaults = widget_defaults.copy()

#### SCREENS ####
screens = [
    Screen(
        top=bar.Bar(
            [
                # widget.CurrentLayout(),
                # widget.CurrentLayoutIcon(background=colors[5], foreground=colors[7], scale=0.8, padding=0),
                # widget.Spacer(length=10, background=colors[6]),
                # widget.TextBox(text='\uf303 ', background=colors[6], padding=0,
                #                mouse_callbacks={'Button1': lazy.spawn('rofi -show drun')},
                #                name='arch_logo'
                #                ),
                # widget.TextBox(text='\ue0b0', fontsize=40, padding=0, background=colors[5], foreground=colors[6]),
                widget.GroupBox(highlight_method='line', fontsize=50, borderwidth=5, highlight_color=colors[5], block_highlight_text_color=colors[7], background=colors[5], foreground=colors[7], this_current_screen_border=colors[10], active=colors[7], inactive=colors[7], spacing=10, padding_x=0, padding_y=5, margin_x=10, margin_y=5),
                widget.TextBox(text='\ue0b0', fontsize=40, padding=0, background=colors[4], foreground=colors[5]),
                # widget.Systray(icon_size=25, background=colors[10], padding=10),
                widget.WindowName(background=colors[4], padding=10),

                widget.TextBox(text='\ue0b2', fontsize=40, padding=0, background=colors[4], foreground=colors[1]),
                widget.WidgetBox(widgets=[
                    # widget.CheckUpdates(distro='Arch', display_format='Updates: {updates}', no_update_string='no updates', colour_no_updates='#00ffff', colour_have_updates='#00ffff', background='#ff00ff', foreground='#00ffff'),
                    widget.CPU(format='\uf029 {load_percent:>3.0f}%', padding=10, background=colors[1],
                               foreground=colors[7], update_interval=5,
                               mouse_callbacks={'Button1': lazy.spawn('kitty htop')}
                               ),
                    widget.TextBox(text='\ue0b2', fontsize=40, padding=0, background=colors[1], foreground=colors[2], name='memory_left_powerline'),
                    widget.Memory(measure_mem='G', format='\uf1c0 {MemPercent:>3.0f}%', padding=10, background=colors[2], foreground=colors[7], update_interval=5, mouse_callbacks={'Button1': toggle_program('conky')}),
                    widget.DF(format='\uf7c9 {uf}/{s}{m}', padding=10, background=colors[2], foreground=colors[7], visible_on_warn=False, update_interval=60, mouse_callbacks={'Button1': toggle_program('conky')}),
                    widget.TextBox(text='\ue0b2', fontsize=40, padding=0, background=colors[2], foreground=colors[3], name='net_left_powerline'),
                    widget.Net(name='net_widget', interface='wlan0', format='\uf1eb  {down} \uf175\uf176 {up}', background=colors[3], foreground=colors[7], padding=10, update_interval=5,
                               mouse_callbacks={'Button1': toggle_program('connman-gtk')}),
                    widget.TextBox(text='\ue0b2', fontsize=40, padding=0, background=colors[3], foreground=colors[4], name='volume_left_powerline'),
                    # widget.Bluetooth(),
                    widget.Backlight(brightness_file='/sys/class/backlight/intel_backlight/brightness',
                                     max_brightness_file='/sys/class/backlight/intel_backlight/max_brightness',
                                     format='\uf5df {percent:>4.0%}',
                                     background=colors[4], foreground=colors[7],
                                     update_interval=0.2,
                                     mouse_callbacks={'Button1': toggle_program('clight-gui')}
                                     ),
                    widget.Volume(get_volume_command=os.path.expanduser('~/.shell-scripts/qtile/get-volume.sh'), fmt='\ufa7d {:>4}', background=colors[4], foreground=colors[7], padding=10, update_interval=0.2, mouse_callbacks={'Button1': toggle_program('pavucontrol')}),
                ],
                    background=colors[1], text_closed=' \ufa60  ', text_open=' \ufa60  ', mouse_callbacks={'Button1': expand_info},
                    name='info_box'),
                # widget.OpenWeather(location='Ottawa'),
                # widget.Wttr(location={'Ottawa': 'Ottawa'}),
                widget.TextBox(text='\ue0b2', fontsize=40, padding=0, background=colors[4], foreground=colors[5], name='clock_left_powerline'),
                widget.Clock(format="\uf5ed  %a %b %d %H:%M", padding=10, background=colors[5], foreground=colors[7]),
                widget.TextBox(text='\ue0b2', fontsize=40, padding=0, background=colors[5], foreground=colors[6]),
                widget.Battery(format='{char} {percent:2.0%}', discharge_char='\uf58b', charge_char='\uf583', full_char='\uf583', show_short_text=False, background=colors[6], foreground=colors[7], low_foreground=colors[7], padding=10, update_interval=60),
                widget.WidgetBox(widgets=[
                    widget.TextBox(text='Picom', background=colors[6], foreground=colors[7]),
                    widget.TextBox(text='\uf205' if picom_on else '\uf204',
                                   fontsize=30, width=45, padding=10, margin_y=10,
                                   background=colors[6], foreground=colors[7],
                                   mouse_callbacks={'Button1': toggle_picom},
                                   name='picom_toggle'),
                    widget.Spacer(length=10, background=colors[6]),
                ], close_button_location='right', text_closed='\uf992 ', text_open='\uf992 ', background=colors[6]),
                # widget.QuickExit(background=colors[6]),
                widget.Spacer(length=5, background=colors[6])
            ],
            40,  # top bar size
            margin=[0, 0, 0, 0],
            border_width=[0, 0, 0, 0],  # Draw top and bottom borders
            border_color=["#000000", "#000000", "#000000", "#000000"],
            background='#00000000',
            opacity=1.0
        ),
        wallpaper='~/.config/qtile/aurora.jpg',
        wallpaper_mode='stretch',
    ),
]

#### MOUSE ####
# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False


#### FLOATING ####
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class='pcmanfm'),  # File Manager
        Match(wm_class='feh'),  # Image Viewer
        Match(wm_class='connman-gtk'),  # Network Manager
        Match(wm_class='Pavucontrol'),  # Audio Manager
        Match(wm_class='Conky'),
        Match(wm_class='clight-gui'),
    ],
    border_normal='#1E1F28',
    border_focus='#00FFFF',
    border_width=4
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "Qtile"
