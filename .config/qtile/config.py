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

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.config import EzKey
from libqtile.command import lazy
from libqtile import layout, bar, widget, extension
from plasma import Plasma

try:
    from typing import List  # noqa: F401
except ImportError:
    pass

mod = "mod4"

keys = [
    # Switch between windows in current stack pane
    EzKey("M-j", lazy.layout.down()),
    EzKey("M-k", lazy.layout.up()),

    # this currently only works with the plasma (i3 mimicking) layout
    EzKey("M-h", lazy.layout.left()),
    EzKey("M-l", lazy.layout.right()),

    # this currently only works with the plasma (i3 mimicking) layout
    EzKey("M-S-h", lazy.layout.move_left()),
    EzKey("M-S-l", lazy.layout.move_right()),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),

    # switch to a screen explicitly
    EzKey("M-1", lazy.to_screen(0)),
    EzKey("M-2", lazy.to_screen(1)),
    EzKey("M-3", lazy.to_screen(2)),

    # terminal
    EzKey("M-<Return>", lazy.spawn("terminator")),

    # dmenu
    EzKey("M-C-d", lazy.run_extension(extension.DmenuRun(
        dmenu_prompt=">",
        dmenu_font="Andika-10",
        background="#15181a",
        foreground="#00ff00",
        selected_background="#079822",
        selected_foreground="#fff",
        dmenu_height=24))),

    # Toggle between different layouts as defined below
    EzKey("M-S-<Tab>", lazy.next_layout()),

    # move to the group (i.e. workspace) on the right according to the bar
    #EzKey("M-l", lazy.screen.next_group()),

    # move to the group (i.e. workspace) on the left according to the bar
    #EzKey("M-h", lazy.screen.prev_group()),

    # switch to other screen
    EzKey("M-<Tab>", lazy.next_screen()),

    EzKey("M-S-q", lazy.window.kill()),
    EzKey("M-S-r", lazy.restart()),
    EzKey("M-S-e", lazy.shutdown()),
]

groups = [
    Group(name = "a", persist = True, init = True, label = "a: web"),
    Group(name = "s", persist = True, init = True, label = "s: sys"),
    Group(name = "d", persist = True, init = True, label = "d: emacs"),
    Group(name = "f", persist = True, init = True, label = "f: misc"),
    Group(name = "z", persist = False, init = False, label = "z: rats"),
    Group(name = "x", persist = False, init = False, label = "x: rats"),
    Group(name = "c", persist = False, init = False, label = "c: rats"),
    Group(name = "v", persist = False, init = False, label = "v: rats")
]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

layouts = [
    Plasma(
        border_normal='#333333',
        border_focus='#00e891',
        border_normal_fixed='#006863',
        border_focus_fixed='#00e8dc',
        border_width=1,
        border_width_single=0,
        margin=10
    ),
    layout.Max(),
    layout.Stack(num_stacks=2)
]

widget_defaults = dict(
    font='Source Code Pro',
    fontsize=14,
    padding=1,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.TextBox(text = "1 |"), # to indicate screen number
                widget.GroupBox(),
                widget.CurrentScreen(padding=10),
                widget.CPUGraph(),
                widget.WindowName(),
                widget.MemoryGraph(),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                #widget.YahooWeather(woeid = "2396707")
            ],
            24,
        ),
    ),
    Screen(
        bottom=bar.Bar(
            [
                widget.TextBox(text = "2 |"), # to indicate screen number
                widget.GroupBox(),
                widget.CurrentScreen(padding=10),
                widget.WindowName(),
                widget.CPUGraph(),
                widget.MemoryGraph(),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
            ],
            24,
        ),
    )
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
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
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
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
