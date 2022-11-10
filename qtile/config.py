from keys import keys, groups
from layouts import layouts, floating_layout
from screens import widget_defaults, screens


keys = keys
groups = groups
widget_defaults = widget_defaults
screens = screens
layouts = layouts
floating_layout = floating_layout

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wmname = "Qtile"
