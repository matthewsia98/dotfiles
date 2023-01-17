import os
import subprocess

from libqtile import hook, qtile
from libqtile.lazy import lazy
from libqtile.log_utils import logger


@hook.subscribe.startup
def startup():
    widgetbox1 = qtile.widgets_map.get("widgetbox1")
    widgetbox2 = qtile.widgets_map.get("widgetbox2")
    widgetbox_spacer = qtile.widgets_map.get("widgetbox_spacer")

    if widgetbox1.box_is_open:
        widgetbox1.cmd_toggle()
    if not widgetbox2.box_is_open:
        widgetbox2.cmd_toggle()
    widgetbox_spacer.length = 20

    musicwidget = qtile.widgets_map.get("musicwidget")
    if musicwidget.player == "None":
        musicwidget.text = "\uf001 No Music Playing \uf001"


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
    qtile.cmd_spawn(program) if return_code == 1 else subprocess.run(
        ["killall", program]
    )


@lazy.function
def toggle_floating(qtile, center=False, resolution=(1920, 1080), scale=0.8):
    window = qtile.current_window
    if center:
        # if not window.floating:
        window.toggle_floating()
        if window.floating:
            window.cmd_set_size_floating(
                int(resolution[0] * scale), int(resolution[1] * scale)
            )
            window.cmd_center()
            # bar height + margin + border
            window.cmd_set_position_floating(window.x, window.y + (40 + 10 + 10) // 2)
    else:
        window.toggle_floating()


@lazy.function
def move_window(qtile, direction, x_step=32, y_step=32):
    layout = qtile.current_layout
    window = qtile.current_window
    if window.floating:
        match direction:
            case "k":
                window.cmd_set_position_floating(window.x, window.y - y_step)
            case "j":
                window.cmd_set_position_floating(window.x, window.y + y_step)
            case "h":
                window.cmd_set_position_floating(window.x - x_step, window.y)
            case "l":
                window.cmd_set_position_floating(window.x + x_step, window.y)
    else:
        match direction:
            case "k":
                layout.cmd_shuffle_up()
            case "j":
                layout.cmd_shuffle_down()
            case "h":
                layout.cmd_shuffle_left()
            case "l":
                layout.cmd_shuffle_right()


@lazy.function
def kill_all(qtile):
    for window in qtile.current_group.windows:
        window.cmd_kill()


@lazy.function
def grow_window(qtile, direction, x_step=32, y_step=32):
    layout = qtile.current_layout
    layout_name = layout.name
    window = qtile.current_window
    if window.floating:
        if direction in "hl":
            grow_width = x_step if direction == "l" else -x_step
            window.cmd_set_size_floating(window.width + grow_width, window.height)
        else:
            grow_height = y_step if direction == "j" else -y_step
            window.cmd_set_size_floating(window.width, window.height + grow_height)
        # window.cmd_center()
    else:
        if layout_name == "Columns":
            match direction:
                case "k":
                    layout.cmd_grow_up()
                case "j":
                    layout.cmd_grow_down()
                case "h":
                    layout.cmd_grow_left()
                case "l":
                    layout.cmd_grow_right()
        elif layout_name == "MonadTall":
            match direction:
                case "k":
                    layout.cmd_grow()
                case "j":
                    layout.cmd_shrink()
                case "h":
                    layout.cmd_shrink_main()
                case "l":
                    layout.cmd_grow_main()
        elif layout_name == "MonadWide":
            match direction:
                case "k":
                    layout.cmd_shrink_main()
                case "j":
                    layout.cmd_grow_main()
                case "h":
                    layout.cmd_shrink()
                case "l":
                    layout.cmd_grow()
        elif layout_name == "MonadThreeCol":
            logger.warning(dir(layout))
            match direction:
                case "k":
                    layout.cmd_grow()
                case "j":
                    layout.cmd_shrink()
                case "h":
                    layout.cmd_shrink()
                case "l":
                    layout.cmd_grow()
        elif layout_name == "VerticalTile":
            match direction:
                case "k":
                    layout.shrink()
                case "j":
                    layout.grow()


@lazy.function
def toggle_minmax(qtile, m):
    layout = qtile.current_layout
    layout_name = layout.name
    window = qtile.current_window

    # if layout_name == "VerticalTile":
    #     layout.cmd_maximize() if m == "max" else layout.cmd_minimize()
    # else:
    window.cmd_toggle_maximize() if m == "max" else window.cmd_toggle_minimize()


@lazy.function
def normalize(qtile):
    for window in qtile.current_group.windows:
        if window.floating:
            window.toggle_floating()

    layout = qtile.current_layout
    layout.cmd_normalize()


@lazy.function
def flip_layout(qtile):
    layout = qtile.current_layout
    layout_name = layout.name
    if layout_name == "Columns":
        layout.cmd_swap_column_right()
    elif layout_name in {"MonadTall", "MonadWide"}:
        layout.cmd_flip()


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
def toggle_musicwidget(qtile):
    musicwidget = qtile.widgets_map.get("musicwidget")
    musicspacerleft = qtile.widgets_map.get("musicspacerleft")
    musicspacerright = qtile.widgets_map.get("musicspacerright")

    if musicwidget.player == "None":
        if musicwidget.length > 0:
            musicwidget.length = 0
            musicspacerleft.length = 10
            musicspacerright.length = 0
        else:
            musicwidget.length = 200
            musicspacerleft.length = 20
            musicspacerright.length = 10
    else:
        musicspacerleft.length = 20
        musicspacerright.length = 10

    for screen in qtile.screens:
        screen.top.draw()


@lazy.function
def toggle_bar(qtile):
    qtile.cmd_hide_show_bar("top")


@lazy.function
def show_text(qtile, name):
    widget = qtile.widgets_map.get(name)
    if name == "wifiwidget":
        widget.cmd_show_text()
    elif name == "batterywidget":
        widget.toggle_text()


@lazy.function
def toggle_conky(qtile):
    return_code = subprocess.run(["pgrep", "conky"]).returncode
    if return_code == 1:
        qtile.cmd_spawn(os.path.expanduser("~/.config/conky/scripts/launch-all.sh"))
    else:
        subprocess.run(["killall", "conky"])
