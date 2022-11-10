import os
from colors import COLORS
from functions import toggle_program, toggle_widgetbox
from libqtile.config import Screen
from libqtile.bar import Bar
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
# from libqtile.log_utils import logger


widget_defaults = dict(
    font='Roboto Mono Medium',
    fontsize=20,
    padding=0,
    margin=0,
    # background=COLORS["transparent"],
    foreground=COLORS['crust'],
)

WIDGETBOX1_COLOR = 'green'
WIDGETBOX2_COLOR = 'peach'
BAR_BACKGROUND_COLOR = 'surface0'

screens = [
    Screen(
        top=Bar(
            widgets=[
                widget.Spacer(length=5),
                widget.CurrentLayoutIcon(
                    scale=0.7,
                    use_mask=True,
                    # foreground=[COLORS['green']],
                    padding=8,
                    decorations=[
                        RectDecoration(
                            colour=COLORS['blue'],
                            radius=6,
                            filled=True,
                            group=True,
                        )
                    ]
                ),
                widget.CurrentLayout(
                    padding=8,
                    decorations=[
                        RectDecoration(
                            colour=COLORS['blue'],
                            radius=6,
                            filled=True,
                            group=True,
                        )
                    ]
                ),
                widget.WindowCount(
                    text_format='{num}',
                    show_zero=True,
                    padding=8,
                    decorations=[
                        RectDecoration(
                            colour=COLORS['blue'],
                            radius=6,
                            filled=True,
                            group=True,
                        )
                    ]
                ),
                widget.Spacer(length=20),
                widget.GroupBox(
                    hide_unused=True,
                    disable_drag=True,
                    toggle=False,
                    highlight_method='block',
                    borderwidth=4,
                    this_current_screen_border=COLORS["crust"],  # block fill color
                    block_highlight_text_color=COLORS["text"],  # block text color
                    active=COLORS['crust'],  # text color
                    urgent_alert_method='block',
                    urgent_border=COLORS['red'],
                    urgent_text=COLORS['crust'],
                    spacing=4,
                    margin_x=6,
                    margin_y=3,  # push labels down
                    padding_x=2,
                    padding_y=2,
                    decorations=[
                        RectDecoration(
                            colour=COLORS['lavender'],
                            radius=6,
                            filled=True,
                            group=True
                        )
                    ]
                ),
                widget.Spacer(length=20),
                widget.CheckUpdates(
                    display_format='\ueb9a {updates}',
                    no_update_string="\ueaa2 0",
                    colour_have_updates=COLORS['red'],
                    colour_no_updates=COLORS['green'],
                    update_interval=60,
                    execute='~/.shell-scripts/qtile/check_updates.sh',
                    padding=8,
                    decorations=[
                        RectDecoration(
                            colour=COLORS['surface2'],
                            radius=6,
                            filled=True,
                            group=True
                        )
                    ],
                    name='updateswidget'
                ),
                widget.Spacer(),
                widget.Clock(
                    format="%A, %B %-d %H:%M:%S",
                    padding=48,
                    decorations=[
                        RectDecoration(
                            colour=COLORS['mauve'],
                            radius=6,
                            filled=True
                        )
                    ]
                ),
                widget.Spacer(),
                widget.WidgetBox(
                    widgets=[
                        widget.Net(
                            format="\uf1eb {down} \uf175\uf176 {up}",
                            mouse_callbacks={"Button1": toggle_program("connman-gtk")},
                            padding=8,
                            decorations=[
                                RectDecoration(
                                    colour=COLORS['green'],
                                    radius=6,
                                    filled=True,
                                    group=True
                                )
                            ]
                        ),
                        # widget.WiFiIcon(),
                        widget.Spacer(length=20),
                        widget.CPU(
                            format="\uF029 {load_percent:>2.0f}%",
                            update_interval=5,
                            padding=8,
                            decorations=[
                                RectDecoration(
                                    colour=COLORS['peach'],
                                    radius=6,
                                    filled=True,
                                    group=True
                                )
                            ]
                        ),
                        widget.Spacer(length=20),
                        widget.Memory(
                            measure_mem="G",
                            format="\uf1c0 {MemPercent:>2.0f}%",
                            update_interval=5,
                            padding=8,
                            decorations=[
                                RectDecoration(
                                    colour=COLORS['lavender'],
                                    radius=6,
                                    filled=True,
                                    group=True
                                )
                            ]
                        ),
                        widget.Spacer(length=20),
                        widget.DF(
                            format="\uf7c9 {uf}/{s}{m}",
                            visible_on_warn=False,
                            update_interval=60,
                            padding=8,
                            decorations=[
                                RectDecoration(
                                    colour=COLORS['pink'],
                                    radius=6,
                                    filled=True,
                                    group=True
                                )
                            ]
                        )
                    ],
                    close_button_location="right",
                    text_closed=" \uEBE2 ",
                    # text_open=" \uEBE2 ",
                    text_open="",
                    padding=8,
                    decorations=[
                        RectDecoration(
                            colour=COLORS[WIDGETBOX1_COLOR],
                            radius=6,
                            filled=True,
                            group=True
                        )
                    ],
                    mouse_callbacks={'Button1': toggle_widgetbox(1)},
                    name='widgetbox1'
                ),
                widget.Spacer(length=20, name='widgetbox_spacer'),
                widget.WidgetBox(
                    widgets=[
                        widget.Backlight(
                            backlight_name="intel_backlight",
                            format="\uf185 {percent:2.0%}",
                            padding=16,
                            decorations=[
                                RectDecoration(
                                    colour=COLORS['peach'],
                                    radius=6,
                                    filled=True,
                                    group=True
                                )
                            ]
                        ),
                        widget.Spacer(length=20),
                        widget.Volume(
                            get_volume_command=os.path.expanduser("~/.shell-scripts/qtile/get-volume.sh"),
                            fmt="\ufa7d {:>4}",
                            mouse_callbacks={"Button1": toggle_program("pavucontrol")},
                            padding=16,
                            decorations=[
                                RectDecoration(
                                    colour=COLORS['lavender'],
                                    radius=6,
                                    filled=True,
                                    group=True
                                )
                            ]
                        ),
                        widget.Spacer(length=20),
                        # widget.Battery(
                        #     format="{char} {percent:2.0%}",
                        #     discharge_char="\uf58b",
                        #     charge_char="\uf583",
                        #     full_char="\uf583",
                        #     update_interval=60,
                        #     show_short_text=False,
                        #     padding=16,
                        #     decorations=[
                        #         RectDecoration(
                        #             colour=COLORS['pink'],
                        #             radius=6,
                        #             filled=True,
                        #             group=True
                        #         )
                        #     ]
                        # ),
                        widget.UPowerWidget(
                            battery_height=16,
                            battery_width=32,
                            fill_normal=COLORS['green'],
                            fill_low=COLORS['yellow'],
                            fill_critical=COLORS['red'],
                            text_displaytime=3,
                            border_colour=COLORS[BAR_BACKGROUND_COLOR],
                            border_charge_colour=COLORS[BAR_BACKGROUND_COLOR],
                            border_critical_colour=COLORS[BAR_BACKGROUND_COLOR],
                            margin=8,
                            decorations=[
                                RectDecoration(
                                    colour=COLORS['pink'],
                                    radius=6,
                                    filled=True,
                                    group=True
                                )
                            ]
                        ),
                    ],
                    close_button_location="right",
                    # text_closed=" \uEB94 ",
                    # text_open=" \uEB94 ",
                    text_closed="",
                    text_open="",
                    padding=8,
                    decorations=[
                        RectDecoration(
                            colour=COLORS[WIDGETBOX2_COLOR],
                            radius=6,
                            filled=True,
                            group=True
                        )
                    ],
                    mouse_callbacks={'Button1': toggle_widgetbox(2)},
                    name='widgetbox2'
                ),
                widget.Spacer(length=5),
            ],
            size=40,
            # margin=[0, 10, 0, 10],
            margin=10,
            # border_width=[20, 20, 20, 20],
            border_width=10,
            border_color=COLORS[BAR_BACKGROUND_COLOR],
            background=COLORS[BAR_BACKGROUND_COLOR],
            # border_color=COLORS['transparent'],
            # background=COLORS['transparent'],
            opacity=1.0,
        ),
        wallpaper='~/.config/qtile/wallpapers/catppuccin_triangle.png',
        wallpaper_mode='stretch',
    )
]
