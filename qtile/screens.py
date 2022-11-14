import os
from colors import COLORS
from functions import toggle_program, toggle_widgetbox, show_text, toggle_conky
from libqtile.config import Screen
from libqtile.bar import Bar
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
# from libqtile.log_utils import logger
from libqtile.lazy import lazy


widget_defaults = dict(
    font='Roboto Mono Medium',
    fontsize=20,
    padding=0,
    margin=0,
    # background=COLORS["transparent"],
    foreground=COLORS['crust'],
)

WIDGETBOX1_COLOR = 'lavender'
# WIDGETBOX2_COLOR = 'peach'
BAR_BACKGROUND_COLOR = 'surface0'
BAR_TEXT_COLOR = 'text'
RECT_DECORATION_RADIUS = 8

screens = [
    Screen(
        top=Bar(
            widgets=[
                widget.Spacer(length=5),
                widget.CurrentLayoutIcon(
                    scale=0.7,
                    use_mask=True,
                    foreground=[COLORS[BAR_TEXT_COLOR]],
                    padding=8,
                    decorations=[
                        RectDecoration(
                            colour=COLORS[BAR_BACKGROUND_COLOR],
                            radius=RECT_DECORATION_RADIUS,
                            filled=True,
                            group=True,
                        )
                    ]
                ),
                # widget.CurrentLayout(
                #     padding=8,
                #     decorations=[
                #         RectDecoration(
                #             colour=COLORS['blue'],
                #             radius=RECT_DECORATION_RADIUS,
                #             filled=True,
                #             group=True,
                #         )
                #     ]
                # ),
                widget.WindowCount(
                    text_format='{num}',
                    show_zero=True,
                    foreground=COLORS[BAR_TEXT_COLOR],
                    padding=8,
                    decorations=[
                        RectDecoration(
                            colour=COLORS[BAR_BACKGROUND_COLOR],
                            radius=RECT_DECORATION_RADIUS,
                            filled=True,
                            group=True,
                        )
                    ],
                    name='windowcountwidget',
                ),
                # widget.WindowName(
                #     format='{state} {name}',
                #     scroll=True,
                #     scroll_step=4,
                #     width=100,
                #     padding=8,
                #     decorations=[
                #         RectDecoration(
                #             colour=COLORS['blue'],
                #             radius=RECT_DECORATION_RADIUS,
                #             filled=True,
                #             group=True,
                #         )
                #     ]
                # ),
                widget.Spacer(length=10),
                widget.GroupBox(
                    hide_unused=True,
                    disable_drag=True,
                    toggle=False,
                    highlight_method='block',
                    borderwidth=4,
                    this_current_screen_border=COLORS[BAR_BACKGROUND_COLOR],  # block fill color
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
                            radius=RECT_DECORATION_RADIUS,
                            filled=True,
                            # group=True
                        )
                    ]
                ),
                widget.Spacer(length=20),
                # widget.Mpd2(
                #     idle_message='Idle',
                #     idle_format='\uf886 {idle_message}',
                #     status_format='\uf886 {title}',
                #     play_states={
                #         'pause': '\uead1',
                #         'play': '\ueb2c',
                #         'stop': '\uead7'
                #     },
                #     scroll=True,
                #     scroll_step=2,
                #     scroll_interval=0.1,
                #     scroll_delay=1,
                #     scroll_clear=True,
                #     width=200,
                #     # max_chars=10,
                #     padding=16,
                #     decorations=[
                #         RectDecoration(
                #             colour=COLORS['yellow'],
                #             radius=RECT_DECORATION_RADIUS,
                #             filled=True
                #         )
                #     ]
                # ),
                widget.Mpris2(
                    # objname='org.mpris.MediaPlayer2.spotify',
                    objname=None,
                    display_metadata=['xesam:title', 'xesam:artist'],
                    # objname=None,
                    paused_text='\uf001 (\uead1) {track} \uf001',
                    playing_text='\uf001 (\ueb2c) {track} \uf001',
                    # paused_text='\uead1 {track}',
                    # playing_text='\ueb2c {track}',
                    # stopped_text='\uead7',
                    scroll=True,
                    scroll_step=4,
                    scroll_interval=0.1,
                    scroll_clear=False,
                    scroll_delay=1,
                    width=200,
                    padding=8,
                    decorations=[
                        RectDecoration(
                            colour=COLORS['yellow'],
                            radius=RECT_DECORATION_RADIUS,
                            filled=True
                        )
                    ],
                    name='musicwidget'
                ),
                widget.Spacer(length=20),
                widget.CheckUpdates(
                    distro='Arch_checkupdates',
                    display_format='\ueb9a {updates}',
                    no_update_string="\ueaa2 0",
                    colour_have_updates=COLORS['maroon'],
                    colour_no_updates=COLORS['green'],
                    update_interval=60,
                    execute='~/.shell-scripts/qtile/check_updates.sh',
                    padding=8,
                    decorations=[
                        RectDecoration(
                            colour=COLORS[BAR_BACKGROUND_COLOR],
                            radius=RECT_DECORATION_RADIUS,
                            filled=True,
                            # group=True
                        )
                    ],
                    name='updateswidget'
                ),
                # widget.Spacer(length=10),
                # widget.Prompt(
                #     prompt='> ',
                #     foreground=COLORS[BAR_TEXT_COLOR],
                #     cursor_color=COLORS[BAR_TEXT_COLOR],
                #     name='promptwidget'
                # ),
                widget.Spacer(),
                widget.Clock(
                    format="%A, %B %-d %H:%M:%S",
                    padding=64,
                    decorations=[
                        RectDecoration(
                            colour=COLORS['mauve'],
                            radius=RECT_DECORATION_RADIUS,
                            filled=True
                        )
                    ]
                ),
                widget.Spacer(),
                widget.WidgetBox(
                    widgets=[
                        widget.Spacer(length=10),
                        widget.Net(
                            format="\uf1eb {down} \uf175\uf176 {up}",
                            mouse_callbacks={"Button1": toggle_program("connman-gtk")},
                            padding=8,
                            decorations=[
                                RectDecoration(
                                    colour=COLORS['green'],
                                    radius=RECT_DECORATION_RADIUS,
                                    filled=True,
                                    # group=True
                                )
                            ]
                        ),
                        widget.Spacer(length=10),
                        widget.CPU(
                            format="\uF029 {load_percent:>2.0f}%",
                            update_interval=5,
                            padding=8,
                            decorations=[
                                RectDecoration(
                                    colour=COLORS['peach'],
                                    radius=RECT_DECORATION_RADIUS,
                                    filled=True,
                                    # group=True
                                )
                            ],
                            mouse_callbacks={"Button1": toggle_conky()},
                        ),
                        widget.Spacer(length=10),
                        widget.Memory(
                            measure_mem="G",
                            format="\uf1c0 {MemPercent:>2.0f}%",
                            update_interval=5,
                            padding=8,
                            decorations=[
                                RectDecoration(
                                    colour=COLORS['blue'],
                                    radius=RECT_DECORATION_RADIUS,
                                    filled=True,
                                    # group=True
                                )
                            ],
                            mouse_callbacks={"Button1": toggle_conky()},
                        ),
                        widget.Spacer(length=10),
                        widget.DF(
                            format="\uf7c9 {uf}/{s}{m}",
                            # foreground=COLORS[BAR_TEXT_COLOR],
                            visible_on_warn=False,
                            update_interval=60,
                            padding=8,
                            decorations=[
                                RectDecoration(
                                    colour=COLORS['yellow'],
                                    radius=RECT_DECORATION_RADIUS,
                                    filled=True,
                                    # group=True
                                )
                            ]
                        ),
                    ],
                    close_button_location="left",
                    text_closed=" \uEBE2 ",
                    text_open=" \uEBE2 ",
                    # text_open="",
                    padding=8,
                    decorations=[
                        RectDecoration(
                            colour=COLORS[WIDGETBOX1_COLOR],
                            radius=RECT_DECORATION_RADIUS,
                            filled=True,
                            # group=True
                        )
                    ],
                    mouse_callbacks={'Button1': toggle_widgetbox(1)},
                    name='widgetbox1'
                ),
                widget.Spacer(length=0, name='widgetbox_spacer'),
                widget.WidgetBox(
                    widgets=[
                        widget.Backlight(
                            backlight_name="intel_backlight",
                            format="\uf185 {percent:2.0%}",
                            padding=16,
                            decorations=[
                                RectDecoration(
                                    colour=COLORS['peach'],
                                    radius=RECT_DECORATION_RADIUS,
                                    filled=True,
                                    # group=True
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
                                    colour=COLORS['blue'],
                                    radius=RECT_DECORATION_RADIUS,
                                    filled=True,
                                    # group=True
                                )
                            ]
                        ),
                        widget.Spacer(length=20),
                        widget.TextBox(
                            text='\uf294',
                            fontsize=24,
                            foreground=COLORS['yellow'],
                            padding=0,
                            decorations=[
                                RectDecoration(
                                    colour=COLORS[BAR_BACKGROUND_COLOR],
                                    radius=RECT_DECORATION_RADIUS,
                                    filled=True,
                                    # group=True
                                )
                            ],
                            mouse_callbacks={'Button1': toggle_program('blueman-manager')}
                        ),
                        widget.Spacer(length=10),
                        widget.WiFiIcon(
                            interface='wlan0',
                            wifi_arc=75,
                            foreground=COLORS[BAR_TEXT_COLOR],
                            active_colour=COLORS['blue'],
                            inactive_colour=COLORS['crust'],
                            padding=10,
                            decorations=[
                                RectDecoration(
                                    colour=COLORS[BAR_BACKGROUND_COLOR],
                                    radius=RECT_DECORATION_RADIUS,
                                    filled=True,
                                    # group=True
                                )
                            ],
                            name='wifiwidget',
                            expanded_timeout=3,
                            mouse_callbacks={
                                'Button1': show_text('wifiwidget'),
                                'Button3': toggle_program('connman-gtk'),
                            }
                        ),
                        widget.Spacer(length=10),
                        widget.UPowerWidget(
                            battery_height=16,
                            battery_width=32,
                            text_discharging='({percentage:.0f}%) {tte} remaining',
                            text_charging='({percentage:.0f}%) {ttf} to full',
                            foreground=COLORS[BAR_TEXT_COLOR],
                            fill_normal=COLORS['green'],
                            fill_low=COLORS['yellow'],
                            fill_critical=COLORS['red'],
                            text_displaytime=3,
                            border_colour=COLORS['crust'],
                            border_charge_colour=COLORS['crust'],
                            border_critical_colour=COLORS['crust'],
                            margin=0,
                            decorations=[
                                RectDecoration(
                                    colour=COLORS[BAR_BACKGROUND_COLOR],
                                    radius=RECT_DECORATION_RADIUS,
                                    filled=True,
                                    # group=True
                                )
                            ],
                            name='batterywidget',
                            mouse_callbacks={
                                'Button1': show_text('batterywidget'),
                                'Button3': lazy.spawn(os.path.expanduser("~/.shell-scripts/qtile/check_battery.sh")),
                            }
                        ),
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
                        #             radius=RECT_DECORATION_RADIUS,
                        #             filled=True,
                        #             group=True
                        #         )
                        #     ]
                        # ),
                    ],
                    close_button_location="left",
                    # text_closed=" \uEB94 ",
                    # text_open=" \uEB94 ",
                    text_closed="",
                    text_open="",
                    padding=8,
                    # decorations=[
                    #     RectDecoration(
                    #         colour=COLORS[WIDGETBOX2_COLOR],
                    #         radius=RECT_DECORATION_RADIUS,
                    #         filled=True,
                    #         # group=True
                    #     )
                    # ],
                    mouse_callbacks={'Button1': toggle_widgetbox(2)},
                    name='widgetbox2'
                ),
                widget.Spacer(length=5),
            ],
            size=40,
            margin=[10, 10, 10, 10],
            # margin=10,
            border_width=[10, 10, 10, 10],
            # border_width=10,
            border_color=COLORS[BAR_BACKGROUND_COLOR],
            background=COLORS[BAR_BACKGROUND_COLOR],
            # border_color=COLORS['transparent'],
            # background=COLORS['transparent'],
            opacity=1.0,
        ),
        wallpaper='~/.config/qtile/wallpapers/cat-sound.png',
        wallpaper_mode='fill',
    )
]
