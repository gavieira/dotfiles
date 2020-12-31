#Qtile configuration file

#Since this config uses the Wlan widget, this config needs iwlib (https://pypi.org/project/iwlib/)
#This config does not support multiple monitors. For more info on how to set it up, look at https://github.com/qtile/qtile/wiki/screens 

import subprocess
from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal


mod = "mod4"
terminal = guess_terminal()

##### KEY BINDINGS #####

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.up(),
        desc="Move focus down in stack pane"),
    Key([mod], "j", lazy.layout.down(),
        desc="Move focus up in stack pane"),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_up(),
        desc="Move window down in current stack "),
    Key([mod, "control"], "j", lazy.layout.shuffle_down(),
        desc="Move window up in current stack "),

    # Switch window focus to other pane(s) of stack
   Key([mod], "space", lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack"),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate(),
        desc="Swap panes of split stack"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),

    #Zoom into current pane
    Key([mod], "z", lazy.window.toggle_fullscreen(), desc="Toggle in and out of current pane"),

    #Runs dmenu with mod key
    #Key([mod], lazy.(), desc="Toggle in and out of current pane"),


]

#groups = [Group(i) for i in "asdfuiop"]
groups = [Group(i) for i in "123456"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

#### LAYOUTS ####

layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
     layout.MonadTall(),
     layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]


#### CLICKABLE EVENTS #####

def open_nmtui(qtile):
    qtile.cmd_spawn(f'{terminal} -e nmtui')

def open_pavucontrol(qtile):
    qtile.cmd_spawn('pavucontrol')

#### SCREENS/WIDGETS #####

widget_defaults = dict(
    font='sans',
    fontsize=12,
    #foreground='#000000',
    padding=3,
)
extension_defaults = widget_defaults.copy()


screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Systray(),
                widget.TextBox("VOL:",
                    mouse_callbacks = {'Button1': open_pavucontrol}),
                widget.Volume(),
                widget.TextBox("WIFI:",
                    mouse_callbacks = {'Button1': open_nmtui}),
                widget.Wlan(interface='wlp1s0',
                    mouse_callbacks={'Button1': open_nmtui}),
                widget.BatteryIcon(),
                #widget.CPUGraph(width=25),
                #widget.MemoryGraph(width=25, fill_color='#9e0000',  graph_color='#ff5757'),
                widget.CPU(background=['#f2d81a'], foreground='#000000'),
                widget.Memory(background=['#f2d81a'], foreground='#000000'),
                widget.Clock(format='%a, %d-%b %R', background=['#33ff6b'], foreground='#000000')
            ],
            24,
            #background=['#4a65ec', '#98a8fc'], #List in background makes a gradient of colors
            #opacity=0.5,
        ),
        wallpaper = "~/.config/qtile/wallpaper/wallpaper-arch.png",
        wallpaper_mode = "fill",
    ),
]


# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

#Function to run some programs at startup (NOT WORKING YET)
def startup_run():
    subprocess.Popen('dropbox', shell=True)
    subprocess.Popen('redshift-gtk', shell=True)

startup_run()
