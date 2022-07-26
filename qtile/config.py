# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
import os
import subprocess
from libqtile.log_utils import logger
from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
#from libqtile.utils import guess_terminal

picom_on = None

@hook.subscribe.startup
def autostart():
    global picom_on
    #subprocess.run(['picom', '--experimental-backends', '-b'])
    picom_on = True
    qtile.widgets_map['textbox'].update('\uf205' if picom_on else '\uf204')
    #lazy.reload_config()

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
    qtile.widgets_map['textbox'].update('\uf205' if picom_on else '\uf204')


# 1 alt
# 4 super
mod = "mod1"

#terminal = guess_terminal()
terminal = 'kitty'

keys = [
    Key([], 'XF86MonBrightnessUp', lazy.spawn('brightnessctl s +5%'), desc='Increase Screen Brightness'),
    Key([], 'XF86MonBrightnessDown', lazy.spawn('brightnessctl s 5%-'), desc='Decrease Screen Brightness'),
    Key([], 'XF86AudioMute', lazy.spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle'), desc='Mute Audio'),
    Key([], 'XF86AudioRaiseVolume', lazy.function(raise_volume), desc='Increase Volume'),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('pactl set-sink-volume @DEFAULT_SINK@ -10%'), desc='Decrease Volume'),
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
    Key([mod, "control"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "control"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "control"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "control"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "shift"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "shift"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "shift"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "shift"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "m", lazy.window.toggle_maximize(), desc="Toggle maximize"),
    Key([mod, 'control'], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], 'f', lazy.spawn('pcmanfm'), desc='Launch File Manager'),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "d", lazy.spawn('rofi -show drun'), desc="Spawn a command using a prompt widget"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

groups = [
            Group(name='1', label='Dev', spawn=None, 
                  layouts=[
                              layout.MonadTall(single_border_width=0, single_margin=20, margin=20, border_normal='#1e1f28', border_focus='#00ffff', border_width=2)
                          ]
                 ),
            Group(name='2', label='Chat', spawn='discord'),
            Group(name='3', label='Mail', spawn='thunderbird'),
            Group(name='4', label='Web', spawn=None),
	        Group(name='5', label='Etc', spawn=None)
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
    

layouts = [
   #layout.Columns(margin_on_single=10, margin=5, border_normal='#24273a', border_focus='#00ffff', border_width=4),
   #layout.Max(),
   ## Try more layouts by unleashing below layouts.
   #layout.Stack(num_stacks=2),
   #layout.Bsp(),
   #layout.Matrix(),
   layout.MonadTall(single_border_width=0, single_margin=0, margin=20, border_normal='#1e1f28', border_focus='#00ffff', border_width=4),
   #layout.MonadWide(),
   #layout.RatioTile(),
   #layout.Tile(),
   #layout.TreeTab(),
   #layout.VerticalTile(),
   #layout.Zoomy(),
]

widget_defaults = dict(
    font='Ubuntu Mono Nerd Font Bold',
    #font="NotoSans Nerd Font",
    fontsize=22,
    padding=3,
    background='#778899',
    foreground='#000000'
)
extension_defaults = widget_defaults.copy()

colors = ['#ffaaff', #lightpink
          '#ffb86c', #orange
          '#f1fa8c', #yellow
          '#50fa7b', #green
          '#00aaff', #darkblue
          '#5f55ff', #purple
          '#ff55ff', #pink
          '#24273a', #black
          '#f8f8f2', #white
          '#8700ff', #darkpurple
          '#00ffff'  #cyan
         ]
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.TextBox(text='\uf205' if picom_on else '\uf204', 
                               fontsize=30, width=45, padding=10, margin_y=10, 
                               background=colors[2], foreground=colors[7], 
                               mouse_callbacks={'Button1': toggle_picom}),
                widget.Spacer(length=10, background=colors[2]),
                #widget.CurrentLayout(),
                #widget.CurrentLayoutIcon(background=colors[0], scale=0.8, padding=0),
                #widget.Spacer(length=5, background=colors[7]),
                # highlight block
                #widget.TextBox(text='\ue0b2', fontsize=40, padding=0,  background=colors[2], foreground=colors[0]),
                widget.GroupBox(highlight_method='line', borderwidth=5, highlight_color=colors[0], block_highlight_text_color=colors[7],  background=colors[0], foreground=colors[7], this_current_screen_border=colors[10], active=colors[7], inactive=colors[7], spacing=10, padding_x=0, padding_y=5, margin_x=10, margin_y=5),
                # highlight border                
                #widget.GroupBox(highlight_method='border', highlight_color='#00ffff',  background='#00ffff', foreground='#ff00ff', this_current_screen_border='#ff00ff', active='#ff00ff', inactive='#ff00ff'),
                # highlight line
                #widget.GroupBox(highlight_method='line', highlight_color='#00ffff', this_current_screen_border='#ff00ff',  background='#00ffff', foreground='#ff00ff', active='#ff00ff', inactive='#ff00ff'),
                #widget.TaskList(),
                #widget.Spacer(length=5, background=colors[7]),
                #widget.WindowCount(),
                widget.TextBox(text='\ue0b2', fontsize=40, padding=0,  background=colors[0], foreground=colors[9]),
                widget.Spacer(length=10, background=colors[9]),
                widget.Prompt(background=colors[9], foreground=colors[7]),
                #widget.WindowTabs(background='#ff00ff', foreground='00ffff', separator=' | '),
                widget.WindowName(background=colors[9], foreground=colors[7]),
                #widget.Spacer(length=50),
                #widget.WindowName(),
                #widget.TextBox("default config", name="default"),
                #widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                #widget.TextBox(text='\ue0b2', fontsize=40, padding=0,  background='#00ffff', foreground='#ff00ff'),
                #widget.Systray(icon_size=20, background='#ff00ff', padding=0),
                #widget.Sep(linewidth=1, background='#000000'),
                widget.TextBox(text='\ue0b2', fontsize=40, padding=0,  background=colors[9], foreground=colors[1]),
                #widget.CheckUpdates(distro='Arch', display_format='Updates: {updates}', no_update_string='no updates', colour_no_updates='#00ffff', colour_have_updates='#00ffff', background='#ff00ff', foreground='#00ffff'),
                #widget.TextBox(text='\ue0b2', fontsize=40, padding=0,  background='#ff00ff', foreground='#00ffff'),
                #widget.CPU(format='\uf85a {load_percent}%', padding=0, background='#ff00ff', foreground='#00ffff', update_interval=15),
                widget.CPU(format='\uf029 {load_percent:>3.0f}%', padding=10, background=colors[1], foreground=colors[7], update_interval=5),
                #widget.Sep(linewidth=1, background='#000000'),
                widget.TextBox(text='\ue0b2', fontsize=40, padding=0,  background=colors[1], foreground=colors[2]),
                widget.Memory(measure_mem='G', format='\uf1c0 {MemPercent:>3.0f}%', padding=10, background=colors[2], foreground=colors[7], update_interval=5),
                #widget.Memory(measure_mem='G', format='\uf1c0 {MemUsed:.2f}{mm}/{MemTotal:.2f}{mm}', padding=0, background='#00ffff', foreground='#ff00ff', update_interval=5),
                #widget.Memory(format='{MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}', padding=0, background='#ff00ff', foreground='#00ffff', update_interval=15),
                #widget.Sep(linewidth=1, background='#000000'),	
                #widget.TextBox(text='\ue0b2', fontsize=40, padding=0,  background=colors[2], foreground=colors[2]),
                widget.DF(format='\uf7c9 {uf}/{s}{m}', padding=10, background=colors[2], foreground=colors[7], visible_on_warn=False, update_interval=60),
                widget.TextBox(text='\ue0b2', fontsize=40, padding=0,  background=colors[2], foreground=colors[3]),
                widget.Net(interface='wlp2s0', format='\uf1eb  {down} \uf175\uf176 {up}', background=colors[3], foreground=colors[7], padding=10, update_interval=5),
                widget.TextBox(text='\ue0b2', fontsize=40, padding=0,  background=colors[3], foreground=colors[4]),
                #widget.Bluetooth(),
                widget.Backlight(brightness_file='/sys/class/backlight/intel_backlight/brightness', 
                                 max_brightness_file='/sys/class/backlight/intel_backlight/max_brightness',
                                 format='\uf5df {percent:>4.0%}',
                                 background=colors[4], foreground=colors[7],
                                 update_interval=0.2
                                ),
                widget.Volume(get_volume_command=os.path.expanduser('~/.shell-scripts/qtile/get-volume.sh'), fmt='\ufa7d {:>4}', background=colors[4], foreground=colors[7], padding=10, update_interval=0.2),
                #widget.OpenWeather(location='Ottawa'),
                #widget.Wttr(location={'Ottawa': 'Ottawa'}),
                widget.TextBox(text='\ue0b2', fontsize=40, padding=0,  background=colors[4], foreground=colors[5]),
                #widget.Clock(format="\uf5ed %a %b %d %I:%M %p", padding=10, background='#00ffff', foreground='#ff00ff'),
                widget.Clock(format="\uf5ed %a %b %d %H:%M", padding=10, background=colors[5], foreground=colors[7]),
                #widget.Sep(linewidth=1, background='#000000'),
                #widget.BatteryIcon(),
                widget.TextBox(text='\ue0b2', fontsize=40, padding=0,  background=colors[5], foreground=colors[6]),
                #widget.Battery(format='{char} {percent:2.0%} {hour:d}h:{min:02d}m', discharge_char='\uf58b', charge_char='\uf583', full_char='\uf583', show_short_text=False, background='#ff00ff', foreground='#00ffff', low_foreground='#00ffff', update_interval=60),
                widget.Battery(format='{char} {percent:2.0%}', discharge_char='\uf58b', charge_char='\uf583', full_char='\uf583', show_short_text=False, background=colors[6], foreground=colors[7], low_foreground=colors[7], padding=10, update_interval=60),
                        #widget.QuickExit(),
                widget.Spacer(length=5, background=colors[6])
            ],
            40, # top bar size
            margin=[0, 0, 0, 0],
            border_width=[0, 0, 0, 0],  # Draw top and bottom borders
            border_color=["#000000", "#000000", "#000000", "#000000"],  # Borders are magenta
            background='#a9a1e1',
            opacity=1.0
        ),
        wallpaper='~/.config/qtile/vaporwave.jpg',
        wallpaper_mode='stretch',
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
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
        Match(wm_class='pcmanfm'), # File Manager
    ],
    border_normal='#1e1f28',
    border_focus='#00ffff',
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
