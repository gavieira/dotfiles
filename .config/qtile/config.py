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

from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, KeyChord
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import os, subprocess


#startup programs
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

#programs to be opened in fullscreen
@hook.subscribe.client_new
def start_fullscreen(window):
    rules = [
        Match(wm_class="mpv")
        #Add other applications in this list
    ]

    if any(window.match(rule) for rule in rules):
        window.togroup(qtile.current_group.name)
        window.toggle_fullscreen()


mod = "mod4"
mod1 = "Menu"
terminal = guess_terminal()
browser = 'firefox'
music = 'lxterminal -e ncmpcpp'
ref_manager = 'zotero'
print_screen = "flameshot gui"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), lazy.group.prev_window().when(layout = 'max'),  desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), lazy.group.next_window().when(layout = 'max'), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "left", lazy.layout.left(), lazy.group.prev_window().when(layout = 'max'),  desc="Move focus to left"),
    Key([mod], "right", lazy.layout.right(), lazy.group.next_window().when(layout = 'max'), desc="Move focus to right"),
    Key([mod], "down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "Tab", lazy.screen.toggle_group(warp = False), desc="Toggle between screens"),
    Key([mod], "n", lazy.next_screen(), desc="Next monitor"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "up", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), lazy.layout.shrink_main().when(layout = 'monadtall'), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), lazy.layout.grow_main().when(layout = 'monadtall'), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), lazy.layout.grow().when(layout = 'monadtall'), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), lazy.layout.shrink().when(layout = 'monadtall'), desc="Grow window up"),
    Key([mod, "control"], "left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "control"], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
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
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn(browser), desc="Launch browser"),
    Key([], "Print", lazy.spawn(print_screen), desc="Prints screen"),
    Key([mod], "m", lazy.spawn(music), desc="Launch music player"),
    Key([mod], "p", lazy.spawn('mpc toggle'), desc="Launch music player"),
    Key([mod, "shift"], "period", lazy.spawn('mpc next'), desc="Previous track"),
    Key([mod, "shift"], "comma", lazy.spawn('mpc prev'), desc="Next track"),
    Key([mod], "o", lazy.spawn('mpc single'), desc="Repeat single track"),
    Key([mod, "shift"], "o", lazy.spawn(os.path.expanduser('~/.config/switch_monitors.sh'), shell = True), desc="Switch notebook mode"),
    Key([mod], "bracketleft", lazy.spawn('pactl -- set-sink-volume 0 -5%'), desc="Decrease volume"),
    Key([mod], "bracketright", lazy.spawn('pactl -- set-sink-volume 0 +5%'), desc="Increase volume"),
    Key([mod], "period", lazy.spawn('brightnessctl set 10%+'), desc="Increase brigthness"),
    Key([mod], "comma", lazy.spawn('brightnessctl set 10%-'), desc="Decrease brigthness"),
    Key([mod], "z", lazy.spawn(ref_manager), desc="Launch reference manager"),
    # Toggle between different layouts as defined below
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "d", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
	KeyChord([mod, "shift"], "e", [
		Key([], "s", lazy.spawn('shutdown now'), desc = "Shutdown computer"),
    	Key([], "r", lazy.spawn('reboot'), desc = "Reboot computer"), 
        Key([], "l", lazy.shutdown(), desc = "Shutdown Qtile")],
    	mode="Exit mode: [s]hutdown, [r]eboot, [l]ogout")
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [Group(i) for i in "123456789"] #Defining groups
#groups[0] = Group("1", layout='monadtall') #Changing group 1 default layout

for i in groups:
    keys.extend(
        [
            # mod1 + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    #layout.Stack(num_stacks=2),
    #layout.Bsp(),
    #layout.Matrix(),
    layout.MonadTall(ratio=0.4),
    #layout.MonadWide(),
    #layout.RatioTile(),
    #layout.Tile(),
    #layout.TreeTab(),
    #layout.VerticalTile(),
    #layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
    )
    
extension_defaults = widget_defaults.copy()

def get_filename_no_ext(path):
    '''Function to get song filename in Mpd2 widget'''
    path = path.replace('&', 'and') #Somehow, the mpd widget has issues with the ampersand character, so we're replacing it
    filename = os.path.basename(path)
    filename_no_ext = os.path.splitext(filename)[0]
    return filename_no_ext


screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(),
                widget.GroupBox(hide_unused = True),
                widget.Prompt(),
                widget.TaskList(theme_mode = 'preferred'),
                widget.Chord(foreground = '#FF0000'),
                widget.TextBox("|"),
                widget.Mpd2(status_format = '{file}' ,
                format_fns = {'file': lambda file: get_filename_no_ext(file) },
                scroll = True,
                scroll_step = 1.5,
                width = 200
                ),
                widget.Mpd2(status_format = '[{play_status}{repeat}{random}{single}{consume}{updating_db}]'),
                widget.TextBox("|"),
                widget.Volume(
                    fmt = 'Vol: {}',
                    volume_app = 'pactl',
                    volume_down_command = 'pactl -- set-sink-volume 0 -5%',
                    volume_up_command = 'pactl -- set-sink-volume 0 +5%',
                    ),
                widget.TextBox("|"),
                widget.DF(
                    visible_on_warn = False,
                    format = 'HOME ({uf}{m})'
                ),
                widget.TextBox("|"),
                widget.DF(
                    visible_on_warn = False,
                    partition = '/media/extra_ssd/',
                    format = 'extra_ssd ({uf}{m})'
                ),
                widget.TextBox("|"),
                widget.Battery(fmt = "Bat: {}"),
                widget.TextBox("|"),
                widget.Pomodoro(
                    length_pomodori = 30,
                    length_short_break = 10,
                    length_long_break = 10
                    ),
                widget.TextBox("|"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(),
                widget.TextBox("|"),
                widget.Clock(format="%d-%b %H:%M"),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(),
                widget.GroupBox(hide_unused = True),
                widget.Prompt(),
                widget.TaskList(theme_mode = 'preferred'),
                widget.Spacer(),
                widget.Chord(foreground = "FF0000"),
                widget.TextBox("|"),
                widget.Mpd2(status_format = '{file}' ,
                format_fns = {'file': lambda file: get_filename_no_ext(file) },
                scroll = True,
                scroll_step = 1.5,
                width = 200
                ),
                widget.Mpd2(status_format = '[{play_status}{repeat}{random}{single}{consume}{updating_db}]'),
                widget.TextBox("|"),
                widget.Volume(
                    fmt = 'Vol: {}',
                    volume_app = 'pactl',
                    volume_down_command = 'pactl -- set-sink-volume 0 -5%',
                    volume_up_command = 'pactl -- set-sink-volume 0 +5%',
                    ),
                widget.TextBox("|"),
                widget.Clock(format="%d-%b %H:%M"),
                widget.QuickExit(mouse_callbacks = {
                'Button1': lambda: qtile.cmd_spawn('shutdown now'),
                'Button2': lambda: lazy.shutdown(),
                'Button3': lambda: qtile.cmd_spawn('reboot'),
                }),
            ],
            24,
        ),
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
floats_kept_above = True
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
    ]
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
wmname = "LG3D"
