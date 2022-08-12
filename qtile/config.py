import os
import subprocess

from libqtile.log_utils import logger
from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
# from libqtile.confreader import Config


#### GLOBALS ####
with open(os.path.expanduser('~/.qtile-powerline-enabled'), 'r') as f:
    POWERLINE_ENABLED = (int(f.read()) == 1)

PICOM_ON = None
LEFT_POWERLINE = '\uE0B2'
RIGHT_POWERLINE = '\uE0B0'
TOGGLE_ON = '\uF205'
TOGGLE_OFF = '\uF204'
POWERLINE_SIZE = 50
BAR_HEIGHT = 50
FONT = 'RobotoMono Nerd Font Bold'
FONT_SIZE = 20
COLORS = {
    'background': ['#24273A'],
    'foreground': ['#CAD3F5', '#24273A'],
    'selection_background': ['#F4DBD6'],
    'selection_foreground': ['#24273A'],
    'active_border_color': ['#00FFFF', '#B7BDF8'],
    'inactive_border_color': ['#6E738D'],
    'black': ['#494D54', '#5B6078'],
    'red': ['#ED8796', '#ED8796'],
    'orange': ['#FFBFA0'],
    'yellow': ['#EED49F', '#EED49F'],
    'green': ['#A6DA95', '#A6DA95'],
    'blue': ['#8AADF4', '#8AADF4'],
    'magenta': ['#F5BDE6', '#F5BDE6'],
    'purple': ['#C6A0F6'],
    'cyan': ['#8BD5CA', '#8BD5CA'],
    'white': ['#B8C0E0', '#A5ADCB'],
    'transparent': ['#00000000'],
}


#### FUNCTIONS ####
@hook.subscribe.startup
def autostart():
    global PICOM_ON, POWERLINE_ENABLED
    PICOM_ON = True

    with open(os.path.expanduser('~/.qtile-powerline-enabled'), 'r') as f:
        POWERLINE_ENABLED = (int(f.read()) == 1)
        logger.warning(f'POWERLINE_ENABLED: {POWERLINE_ENABLED}')

    picom_toggle = qtile.widgets_map.get('picom_toggle')
    if picom_toggle is not None:
        picom_toggle.update(TOGGLE_ON if PICOM_ON else TOGGLE_OFF)

    powerline_toggle = qtile.widgets_map.get('powerline_toggle')
    if powerline_toggle is not None:
        powerline_toggle.update(TOGGLE_ON if POWERLINE_ENABLED else TOGGLE_OFF)

    info_box = qtile.widgets_map.get('info_box')
    if info_box.box_is_open:
        info_box.cmd_toggle()


def spacer(length=None, background=None, name=None):
    length = 0 if length is None else length
    background = COLORS['transparent'][0] if background is None else background

    return widget.Spacer(length=length,
                         background=background,
                         name=name)


def separator(length=None, padding=None, background=None, foreground=None, name=None):
    length = 1 if length is None else length
    padding = 40 if padding is None else padding
    background = COLORS['transparent'][0] if background is None else background
    foreground = COLORS['transparent'][0] if foreground is None else foreground

    return widget.Sep(linewidth=length,
                      padding=padding,
                      background=background,
                      name=name
                      )


def powerline(direction, background=None, foreground=None, name=None):
    background = background if background is not None else COLORS['background'][0]
    foreground = foreground if foreground is not None else COLORS['foreground'][0]

    return widget.TextBox(text=LEFT_POWERLINE if direction == 'l' else RIGHT_POWERLINE,
                          fontsize=POWERLINE_SIZE,
                          padding=0,
                          background=background,
                          foreground=foreground,
                          name=name
                          )


def is_muted():
    output = str(subprocess.check_output(['pactl', 'get-sink-mute', '@DEFAULT_SINK@']))
    return 'yes' in output


def raise_volume(*args):
    if is_muted():
        subprocess.run(['pactl', 'set-sink-mute', '@DEFAULT_SINK@', '0'])
    else:
        subprocess.run(['pactl', 'set-sink-volume', '@DEFAULT_SINK@', '+5%'])


def toggle_picom():
    global PICOM_ON
    output = int(subprocess.check_output(os.path.expanduser('~/.shell-scripts/qtile/toggle-picom.sh')))
    PICOM_ON = (output == 1)
    picom_textbox = qtile.widgets_map.get('picom_toggle')
    if picom_textbox is not None:
        picom_textbox.update(TOGGLE_ON if PICOM_ON else TOGGLE_OFF)


def toggle_powerline():
    global POWERLINE_ENABLED
    POWERLINE_ENABLED = not POWERLINE_ENABLED

    with open(os.path.expanduser('~/.qtile-powerline-enabled'), 'w') as f:
        subprocess.call(['echo', '1' if POWERLINE_ENABLED else '0'], stdout=f)

    powerline_textbox = qtile.widgets_map.get('powerline_toggle')
    if powerline_textbox is not None:
        powerline_textbox.update(TOGGLE_ON if POWERLINE_ENABLED else TOGGLE_OFF)

    # conf = Config('~/.config/qtile/powerline-config.py' if POWERLINE_ENABLED else '~/.config/qtile/config.py')
    # qtile.config = conf
    qtile.cmd_reload_config()


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
def toggle_info(qtile):
    info_box = qtile.widgets_map.get('info_box')
    info_box.cmd_toggle()

    widgetbox_powerline = qtile.widgets_map.get('widgetbox_powerline')
    widgetbox_powerline.foreground = COLORS['orange' if info_box.box_is_open else 'green'][0]


@lazy.function
def toggle_program(qtile, program):
    return_code = subprocess.run(['pgrep', program]).returncode
    qtile.cmd_spawn(program) if return_code == 1 else subprocess.run(['killall', program])


def toggle_conky():
    return_code = subprocess.run(['pgrep', 'conky']).returncode
    qtile.cmd_spawn(os.path.expanduser('~/.shell-scripts/conky/launch-all.sh')) if return_code == 1 else subprocess.run(['killall', 'conky'])


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
    Key([mod], "p", lazy.group.prev_window(), desc="Move focus to previous window"),
    Key([mod], "n", lazy.group.next_window(), desc="Move focus to next window"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, 'shift'], "h", grow_horizontal('h'), desc="Grow window to the left"),
    Key([mod, 'shift'], "l", grow_horizontal('l'), desc="Grow window to the right"),
    Key([mod, 'shift'], "j", grow_vertical('j'), desc="Grow window down"),
    Key([mod, 'shift'], "k", grow_vertical('k'), desc="Grow window up"),

    # Key([mod, 'shift'], 'n', lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, 'control'], 'space', lazy.layout.flip(), desc='Flip main side'),
    Key([mod, 'control'], 'n', lazy.window.toggle_minimize(), desc='Toggle minimize'),
    Key([mod, 'control'], 'm', lazy.window.toggle_maximize(), desc="Toggle maximize"),
    Key([mod, 'control'], 'f', center_and_resize_floating(), desc="Toggle floating"),

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
    Group(name='1', label='\uE235', spawn=None),
    Group(name='2', label='\uFB10', spawn='discord'),
    Group(name='3', label='\uF6ED', spawn='thunderbird'),
    Group(name='4', label='\uF269', spawn='firefox'),
    Group(name='5', label='\uF313', spawn=None)
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


#### MOUSE ####
# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button2", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button3", lazy.window.bring_to_front()),
]


#### LAYOUTS####
layouts = [
    # layout.Columns(margin_on_single=10,
    #                margin=5,
    #                border_width=4,
    #                border_normal=COLORS['inactive_border_color'][0],
    #                border_focus=COLORS['active_border_color'][0],
    #                ),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(single_border_width=0,
                     single_margin=0,
                     margin=20,
                     border_width=2,
                     border_normal=COLORS['inactive_border_color'][0],
                     border_focus=COLORS['active_border_color'][0],
                     ),
    # layout.MonadWide(),
    # layout.Max(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

#### WIDGET DEFAULTS ####
widget_defaults = dict(
    font=FONT,
    fontsize=FONT_SIZE,
    padding=0,
    margin=0,
    background=COLORS['background'][0],
    foreground=COLORS['foreground'][0]
)
extension_defaults = widget_defaults.copy()


#### SCREENS ####
screens = [
    Screen(
        top=bar.Bar(
            widgets=[
                # spacer(length=0,
                #        background=COLORS['blue'][0] if POWERLINE_ENABLED else None,
                #        name='layout_spacer'
                #        ),
                # widget.CurrentLayout(),
                widget.CurrentLayoutIcon(background=COLORS['blue'][0] if POWERLINE_ENABLED else None,
                                         scale=0.6,
                                         ),
                separator(length=4,
                          padding=0,
                          background=COLORS['blue'][0] if POWERLINE_ENABLED else None
                          ),
                spacer(length=5,
                       background=COLORS['blue'][0] if POWERLINE_ENABLED else None,
                       name='layout_spacer'
                       ),
                # widget.Spacer(length=10, background=colors[6]),
                # widget.TextBox(text='\uF303 ', background=colors[6], padding=0,
                #                mouse_callbacks={'Button1': lazy.spawn('rofi -show drun')},
                #                name='arch_logo'
                #                ),
                # widget.TextBox(text=right_arrow, fontsize=40, padding=0, background=colors[5], foreground=colors[6]),
                widget.GroupBox(highlight_method='block',
                                fontsize=50,
                                borderwidth=5,
                                highlight_color=COLORS['selection_background'][0],
                                block_highlight_text_color=COLORS['selection_foreground'][0],
                                background=COLORS['blue'][0] if POWERLINE_ENABLED else None,
                                foreground=COLORS['foreground'][POWERLINE_ENABLED],
                                this_current_screen_border=COLORS['cyan'][0],
                                urgent_border=COLORS['red'][0],
                                urgent_text=COLORS['foreground'][POWERLINE_ENABLED],
                                active=COLORS['foreground'][POWERLINE_ENABLED],
                                inactive=COLORS['foreground'][POWERLINE_ENABLED],
                                rounded=True,
                                center_aligned=True,
                                spacing=0,
                                padding_x=3,
                                padding_y=0,
                                margin_x=0,
                                margin_y=3,
                                name='groupbox'
                                ),
                powerline('r',
                          background=COLORS['transparent'][0],
                          foreground=COLORS['blue'][0],
                          name='groupbox_powerline'
                          ) if POWERLINE_ENABLED else separator(length=4, name='groupbox_separator'),
                # widget.Systray(icon_size=25, background=colors[10], padding=10),
                widget.TaskList(background=COLORS['transparent'][0],
                                foreground=COLORS['foreground'][0],
                                border=COLORS['active_border_color'][0],
                                unfocused_border=COLORS['inactive_border_color'][0],
                                urgent_border=COLORS['red'][0],
                                highlight_method='border',
                                title_width_method=None,
                                rounded=True,
                                txt_floating='[\uF06D] ',
                                txt_maximized='[\uF067] ',
                                txt_minimized='[\uF068] ',
                                icon_size=0,
                                spacing=10,
                                margin_x=0,
                                margin_y=1,
                                padding_x=10,
                                padding_y=10,
                                ),
                # widget.WindowName(background=COLORS['transparent'][0],
                #                   foreground=COLORS['foreground'][0],
                #                   padding=10,
                #                   name='windowname'
                #                   ),
                # widget.WindowTabs(background=COLORS['transparent'][0],
                #                   foreground=COLORS['foreground'][0],
                #                   selected=('\uF005 ', ''),
                #                   ),
                # widget.Spacer(length=bar.STRETCH, background='#00000000'),
                # widget.TextBox(text=LEFT_ARROW,
                #                fontsize=ARROW_SIZE,
                #                padding=0,
                #                background=COLORS['background'][0],
                #                foreground=COLORS['foreground'][0],
                #                mouse_callbacks={'Button1': toggle_info}
                #                ) if POWERLINE_ENABLED else separator(),
                # widget.CheckUpdates(distro='Arch',
                #                     display_format='Updates: {updates}',
                #                     no_update_string='no updates',
                #                     colour_no_updates=COLORS['foreground'][0],
                #                     colour_have_updates=COLORS['green'][0],
                #                     background=COLORS['background'][0],
                #                     foreground=COLORS['foreground'][0],
                #                     ),
                powerline('l',
                          background=COLORS['transparent'][0],
                          foreground=COLORS['green'][0],
                          name='widgetbox_powerline'
                          ) if POWERLINE_ENABLED else separator(length=4, name='widgetbox_separator'),
                widget.WidgetBox(
                    widgets=[
                        widget.CPU(format='\uF029 {load_percent:>2.0f}%',
                                   padding=10,
                                   background=COLORS['orange'][0] if POWERLINE_ENABLED else None,
                                   foreground=COLORS['foreground'][POWERLINE_ENABLED],
                                   update_interval=5,
                                   mouse_callbacks={'Button1': toggle_conky},
                                   name='cpu'
                                   ),
                        widget.Memory(measure_mem='G',
                                      format='\uf1c0 {MemPercent:>2.0f}%',
                                      padding=10,
                                      background=COLORS['orange'][0] if POWERLINE_ENABLED else None,
                                      foreground=COLORS['foreground'][POWERLINE_ENABLED],
                                      update_interval=5,
                                      mouse_callbacks={'Button1': toggle_conky},
                                      name='memory'
                                      ),
                        # powerline('l',
                        #           background=COLORS['orange'][0],
                        #           foreground=COLORS['orange'][0],
                        #           name='df_powerline'
                        #           ) if POWERLINE_ENABLED else separator(length=4, name='df_separator'),
                        widget.DF(format='\uf7c9 {uf}/{s}{m}',
                                  padding=10,
                                  background=COLORS['orange'][0] if POWERLINE_ENABLED else None,

                                  foreground=COLORS['foreground'][POWERLINE_ENABLED],
                                  visible_on_warn=False,
                                  update_interval=60,
                                  mouse_callbacks={'Button1': toggle_conky},
                                  name='df'
                                  ),
                        powerline('l',
                                  background=COLORS['orange'][0],
                                  foreground=COLORS['yellow'][0],
                                  name='net_powerline'
                                  ) if POWERLINE_ENABLED else separator(length=4, name='net_separator'),
                        widget.Net(interface='wlan0',
                                   format='\uf1eb  {down} \uf175\uf176 {up}',
                                   background=COLORS['yellow'][0] if POWERLINE_ENABLED else None,
                                   foreground=COLORS['foreground'][POWERLINE_ENABLED],
                                   padding=10,
                                   update_interval=5,
                                   mouse_callbacks={'Button1': toggle_program('connman-gtk')},
                                   name='net'
                                   ),
                        powerline('l',
                                  background=COLORS['yellow'][0],
                                  foreground=COLORS['green'][0],
                                  name='backlight_powerline'
                                  ) if POWERLINE_ENABLED else separator(length=4, name='backlight_separator'),
                        # widget.Bluetooth(),
                        widget.Backlight(brightness_file='/sys/class/backlight/intel_backlight/brightness',
                                         max_brightness_file='/sys/class/backlight/intel_backlight/max_brightness',
                                         format='\uf5df {percent:>3.0%}',
                                         background=COLORS['green'][0] if POWERLINE_ENABLED else None,
                                         foreground=COLORS['foreground'][POWERLINE_ENABLED],
                                         padding=10,
                                         update_interval=0.2,
                                         mouse_callbacks={'Button1': toggle_program('clight-gui')},
                                         name='backlight'
                                         ),
                        widget.Volume(get_volume_command=os.path.expanduser('~/.shell-scripts/qtile/get-volume.sh'),
                                      fmt='\ufa7d {:>4}',
                                      background=COLORS['green'][0] if POWERLINE_ENABLED else None,
                                      foreground=COLORS['foreground'][POWERLINE_ENABLED],
                                      padding=10,
                                      update_interval=0.2,
                                      mouse_callbacks={'Button1': toggle_program('pavucontrol')},
                                      name='volume'
                                      ),
                        widget.TextBox(text='\uF5B0',
                                       background=COLORS['green'][0] if POWERLINE_ENABLED else None,
                                       foreground=COLORS['foreground'][POWERLINE_ENABLED],
                                       padding=10,
                                       mouse_callbacks={'Button1': toggle_program('blueman-manager')},
                                       name='bluetooth'
                                       ),
                    ],
                    close_button_location='right',
                    background=COLORS['green'][0] if POWERLINE_ENABLED else None,
                    foreground=COLORS['foreground'][POWERLINE_ENABLED],
                    fontsize=25,
                    text_closed='\uF303'.center(3),
                    text_open='\uF303'.center(3),
                    mouse_callbacks={'Button1': toggle_info},
                    name='info_box'
                ),
                # widget.OpenWeather(location='Ottawa'),
                # widget.Wttr(location={'Ottawa': 'Ottawa'}),
                powerline('l',
                          background=COLORS['green'][0],
                          foreground=COLORS['purple'][0],
                          name='clock_powerline'
                          ) if POWERLINE_ENABLED else separator(length=4, name='clock_separator'),
                widget.Clock(format='\uf5ed  %a %b %d %H:%M:%S',
                             background=COLORS['purple'][0] if POWERLINE_ENABLED else None,
                             foreground=COLORS['foreground'][POWERLINE_ENABLED],
                             padding=0 if POWERLINE_ENABLED else 10,
                             name='clock'
                             ),
                powerline('l',
                          background=COLORS['purple'][0],
                          foreground=COLORS['magenta'][0],
                          name='battery_powerline'
                          ) if POWERLINE_ENABLED else separator(length=4, name='battery_separator'),
                widget.Battery(format='{char} {percent:2.0%}',
                               discharge_char='\uf58b',
                               charge_char='\uf583',
                               full_char='\uf583',
                               show_short_text=False,
                               background=COLORS['magenta'][0] if POWERLINE_ENABLED else None,
                               foreground=COLORS['foreground'][POWERLINE_ENABLED],
                               low_foreground=COLORS['foreground'][POWERLINE_ENABLED],
                               padding=0 if POWERLINE_ENABLED else 10,
                               update_interval=60,
                               name='battery'
                               ),
                widget.Spacer(length=20 if POWERLINE_ENABLED else 10,
                              background=COLORS['magenta'][0] if POWERLINE_ENABLED else None,
                              name='battery_spacer'
                              ),
                widget.WidgetBox(
                    widgets=[
                        widget.TextBox(text='Powerline',
                                       background=COLORS['magenta'][0] if POWERLINE_ENABLED else None,
                                       foreground=COLORS['foreground'][POWERLINE_ENABLED],
                                       mouse_callbacks={'Button1': toggle_powerline},
                                       name='powerline_text'
                                       ),
                        widget.TextBox(text=TOGGLE_ON if PICOM_ON else TOGGLE_OFF,
                                       fontsize=30,
                                       width=45,
                                       padding=10,
                                       background=COLORS['magenta'][0] if POWERLINE_ENABLED else None,
                                       foreground=COLORS['foreground'][POWERLINE_ENABLED],
                                       mouse_callbacks={'Button1': toggle_powerline},
                                       name='powerline_toggle'
                                       ),
                        widget.Spacer(length=10,
                                      background=COLORS['magenta'][0] if POWERLINE_ENABLED else None,
                                      name='powerline_spacer'
                                      ),
                        widget.TextBox(text='Picom',
                                       background=COLORS['magenta'][0] if POWERLINE_ENABLED else None,
                                       foreground=COLORS['foreground'][POWERLINE_ENABLED],
                                       mouse_callbacks={'Button1': toggle_picom},
                                       name='picom_text'
                                       ),
                        widget.TextBox(text=TOGGLE_ON if PICOM_ON else TOGGLE_OFF,
                                       fontsize=30,
                                       width=45,
                                       padding=10,
                                       background=COLORS['magenta'][0] if POWERLINE_ENABLED else None,
                                       foreground=COLORS['foreground'][POWERLINE_ENABLED],
                                       mouse_callbacks={'Button1': toggle_picom},
                                       name='picom_toggle'
                                       ),
                        widget.Spacer(length=10,
                                      background=COLORS['magenta'][0] if POWERLINE_ENABLED else None,
                                      name='picom_spacer'
                                      ),
                    ],
                    close_button_location='right',
                    text_closed='\uF992 ',
                    text_open='\uF992 ',
                    background=COLORS['magenta'][0] if POWERLINE_ENABLED else None,
                    foreground=COLORS['foreground'][POWERLINE_ENABLED],
                    name='settings'
                ),
                widget.Spacer(length=5,
                              background=COLORS['magenta'][0] if POWERLINE_ENABLED else None
                              )
            ],
            size=BAR_HEIGHT,  # top bar size
            margin=[0, 0, 0, 0],
            border_width=[0, 0, 0, 0],  # Draw top and bottom borders
            border_color=COLORS['inactive_border_color'][0],
            background='#00000000',
            opacity=1.0,
            name='bar'
        ),
        wallpaper='~/.config/qtile/wallpapers/space2.jpg',
        wallpaper_mode='stretch',
    ),
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
        Match(wm_class='Conky'),  # System Monitor
        Match(wm_class='blueman-manager'),  # Bluetooth Manager
    ],
    border_normal=COLORS['inactive_border_color'][0],
    border_focus=COLORS['active_border_color'][0],
    border_width=2
)


auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

wmname = "Qtile"
