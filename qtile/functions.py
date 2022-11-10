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

    if widgetbox1.box_is_open:
        widgetbox_spacer.length = 0
    else:
        widgetbox_spacer.length = 20


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
        if direction == "h":
            lazy.layout.grow_left()
        elif direction == "l":
            lazy.layout.grow_right()
        elif direction == "k":
            lazy.layout.grow_up()
        elif direction == "j":
            lazy.layout.grow_down()


@lazy.function
def toggle_widgetbox(qtile, n):
    widgetbox1 = qtile.widgets_map.get("widgetbox1")
    widgetbox2 = qtile.widgets_map.get("widgetbox2")
    widgetbox_spacer = qtile.widgets_map.get("widgetbox_spacer")

    if n == 1:
        if (not widgetbox1.box_is_open and widgetbox2.box_is_open) \
                or (widgetbox1.box_is_open and not widgetbox2.box_is_open):
            widgetbox2.cmd_toggle()
            widgetbox1.cmd_toggle()
        if widgetbox1.box_is_open:
            widgetbox_spacer.length = 0
        else:
            widgetbox_spacer.length = 20
        logger.warning(widgetbox_spacer.length)
    elif n == 2:
        if widgetbox1.box_is_open:
            widgetbox1.cmd_toggle()
        widgetbox2.cmd_toggle()
