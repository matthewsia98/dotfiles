from colors import CATPPUCCIN
from libqtile import layout
from libqtile.config import Match


BORDER_NORMAL_COLOR = "text"
BORDER_FOCUS_COLOR = "blue"
BORDER_FLOAT_COLOR = "green"
BORDER_WIDTH = 4
SINGLE_BORDER_WIDTH = 2
MARGIN_WIDTH = 10
SINGLE_MARGIN_WIDTH = 0

layouts = [
    layout.Columns(
        insert_position=1,  # insert below
        num_columns=2,
        border_focus=CATPPUCCIN[BORDER_FOCUS_COLOR],
        border_normal=CATPPUCCIN[BORDER_NORMAL_COLOR],
        border_on_single=SINGLE_BORDER_WIDTH != 0,
        single_border_width=SINGLE_BORDER_WIDTH,
        border_width=BORDER_WIDTH,
        margin_on_single=[
            0,
            SINGLE_MARGIN_WIDTH,
            SINGLE_MARGIN_WIDTH,
            SINGLE_MARGIN_WIDTH,
        ],
        # margin_on_single=SINGLE_MARGIN_WIDTH,
        margin=[0, MARGIN_WIDTH, MARGIN_WIDTH, MARGIN_WIDTH],
        name="Columns",
    ),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(
        new_client_position="after_current",
        ratio=0.5,
        border_focus=CATPPUCCIN[BORDER_FOCUS_COLOR],
        border_normal=CATPPUCCIN[BORDER_NORMAL_COLOR],
        single_border_width=SINGLE_BORDER_WIDTH,
        border_width=BORDER_WIDTH,
        single_margin=[
            0,
            SINGLE_MARGIN_WIDTH,
            SINGLE_MARGIN_WIDTH,
            SINGLE_MARGIN_WIDTH,
        ],
        # single_margin=SINGLE_MARGIN_WIDTH,
        margin=MARGIN_WIDTH,
        name="MonadTall",
    ),
    layout.MonadWide(
        new_client_position="after_current",
        ratio=0.5,
        border_focus=CATPPUCCIN[BORDER_FOCUS_COLOR],
        border_normal=CATPPUCCIN[BORDER_NORMAL_COLOR],
        single_border_width=SINGLE_BORDER_WIDTH,
        border_width=BORDER_WIDTH,
        single_margin=SINGLE_MARGIN_WIDTH,
        margin=MARGIN_WIDTH,
        name="MonadWide",
    ),
    layout.MonadThreeCol(
        new_client_position="after_current",
        main_centered=True,
        ratio=0.5,
        border_focus=CATPPUCCIN[BORDER_FOCUS_COLOR],
        border_normal=CATPPUCCIN[BORDER_NORMAL_COLOR],
        single_border_width=SINGLE_BORDER_WIDTH,
        border_width=BORDER_WIDTH,
        single_margin=SINGLE_MARGIN_WIDTH,
        margin=MARGIN_WIDTH,
        name="MonadThreeCol",
    ),
    # layout.Max(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    layout.VerticalTile(
        border_focus=CATPPUCCIN[BORDER_FOCUS_COLOR],
        border_normal=CATPPUCCIN[BORDER_NORMAL_COLOR],
        single_border_width=SINGLE_BORDER_WIDTH,
        border_width=BORDER_WIDTH,
        single_margin=[
            0,
            SINGLE_MARGIN_WIDTH,
            SINGLE_MARGIN_WIDTH,
            SINGLE_MARGIN_WIDTH,
        ],
        # single_margin=SINGLE_MARGIN_WIDTH,
        margin=[0, MARGIN_WIDTH, MARGIN_WIDTH, MARGIN_WIDTH],
        name="VerticalTile",
    ),
    # layout.Zoomy(),
]

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
        Match(wm_class="pcmanfm"),  # File Manager
        Match(wm_class="feh"),  # Image Viewer
        Match(wm_class="connman-gtk"),  # Network Manager
        Match(wm_class="Pavucontrol"),  # Audio Manager
        Match(wm_class="Conky"),  # System Monitor
        Match(wm_class="blueman-manager"),  # Bluetooth Manager
        Match(wm_class="rofi"),
    ],
    border_normal=CATPPUCCIN[BORDER_NORMAL_COLOR],
    border_focus=CATPPUCCIN[BORDER_FLOAT_COLOR],
    border_width=BORDER_WIDTH,
)
