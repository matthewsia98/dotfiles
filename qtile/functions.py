import os
import subprocess
from libqtile import qtile, hook
from libqtile.lazy import lazy
from libqtile.log_utils import logger


@hook.subscribe.startup
def startup():
    widgetbox1 = qtile.widgets_map.get('widgetbox1')
    widgetbox2 = qtile.widgets_map.get('widgetbox2')
    widgetbox_spacer = qtile.widgets_map.get('widgetbox_spacer')

    if widgetbox1.box_is_open:
        widgetbox1.cmd_toggle()
    if not widgetbox2.box_is_open:
        widgetbox2.cmd_toggle()
    widgetbox_spacer.length = 20

    musicwidget = qtile.widgets_map.get('musicwidget')
    # logger.warning(dir(musicwidget))
    if musicwidget.player == 'None':
        musicwidget.text = '\uf001 No Music Playing \uf001'


# @hook.subscribe.client_new
# def client_new(window):
#     logger.warning(dir(window))
#     logger.warning(window.floating)
#     wm_class = window.get_wm_class()
#     if wm_class == "Conky" and not window.floating:
#         window.toggle_floating()
#         window.cmd_set_size_floating(800, 800)
#     logger.warning(window.floating)


def is_muted():
    output = str(subprocess.check_output(["pactl", "get-sink-mute", "@DEFAULT_SINK@"]))
    return "yes" in output


def raise_volume(*args):
    if is_muted():
        subprocess.run(["pactl", "set-sink-mute", "@DEFAULT_SINK@", "0"])
    else:
        subprocess.run(["pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%"])


@lazy.function
def toggle_program(qtile, program):
    return_code = subprocess.run(["pgrep", program]).returncode
    qtile.cmd_spawn(program) if return_code == 1 else subprocess.run(["killall", program])


@lazy.function
def toggle_floating(qtile, resolution=(1920, 1080), scale=0.8):
    window = qtile.current_window
    window.toggle_floating()

    if window.floating:
        window.cmd_set_size_floating(resolution[0] * scale, resolution[1] * scale)
        window.cmd_center()


@lazy.function
def grow_window(qtile, direction, width_step=32, height_step=32):
    layout = qtile.current_layout
    layout_name = layout.name
    window = qtile.current_window
    if window.floating:
        if direction in "hl":
            grow_width = width_step if direction == "l" else -width_step
            window.cmd_set_size_floating(window.width + grow_width, window.height)
        else:
            grow_height = height_step if direction == "k" else -height_step
            window.cmd_set_size_floating(window.width, window.height + grow_height)
        window.cmd_center()
    else:
        if layout_name == 'Columns':
            match direction:
                case 'h':
                    layout.cmd_grow_left()
                case 'l':
                    layout.cmd_grow_right()
                case 'k':
                    layout.cmd_grow_up()
                case 'j':
                    layout.cmd_grow_down()
        elif layout_name == 'MonadTall':
            match direction:
                case 'h':
                    layout.cmd_shrink_main()
                case 'l':
                    layout.cmd_grow_main()
                case 'k':
                    layout.cmd_grow()
                case 'j':
                    layout.cmd_shrink()


@lazy.function
def toggle_widgetbox(qtile, n):
    widgetbox1 = qtile.widgets_map.get("widgetbox1")
    widgetbox2 = qtile.widgets_map.get("widgetbox2")
    widgetbox_spacer = qtile.widgets_map.get("widgetbox_spacer")

    if n == 1:
        if widgetbox2.box_is_open:
            widgetbox2.cmd_toggle()
        widgetbox1.cmd_toggle()
    elif n == 2:
        if widgetbox1.box_is_open:
            widgetbox1.cmd_toggle()
        widgetbox2.cmd_toggle()

    if not widgetbox1.box_is_open:
        widgetbox_spacer.length = 20 if widgetbox2.box_is_open else 0
    else:
        widgetbox_spacer.length = 0


@lazy.function
def show_text(qtile, name):
    widget = qtile.widgets_map.get(name)
    if name == 'wifiwidget':
        widget.cmd_show_text()
    elif name == 'batterywidget':
        widget.toggle_text()


@lazy.function
def toggle_conky(qtile):
    return_code = subprocess.run(["pgrep", 'conky']).returncode
    if return_code == 1:
        qtile.cmd_spawn(os.path.expanduser("~/.shell-scripts/conky/launch-all.sh"))
    else:
        subprocess.run(["killall", 'conky'])


@lazy.function
def open_prompt(qtile):
    def callback(text):
        qtile.cmd_spawn(text)

    promptwidget = qtile.widgets_map.get('promptwidget')
    promptwidget.start_input('', callback)
