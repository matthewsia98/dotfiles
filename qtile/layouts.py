from colors import COLORS
from libqtile import layout
from libqtile.config import Match


layouts = [
    layout.Columns(
        insert_position=1,  # insert below
        margin_on_single=0,
        margin=5,
        border_width=2,
        border_normal=COLORS['base'],
        border_focus=COLORS['blue'],
        name='Columns'
    ),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(
        single_border_width=0,
        single_margin=0,
        margin=10,
        border_width=2,
        border_normal=COLORS['base'],
        border_focus=COLORS['blue'],
        name='MonadTall'
    ),
    # layout.MonadWide(),
    # layout.Max(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
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
    ],
    border_normal=COLORS['base'],
    border_focus=COLORS['blue'],
    border_width=1,
)
