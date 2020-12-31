import os
import subprocess
from settings.theme import wallpaper
from libqtile.command import lazy

def init_apps_once():
    processes = [
        ['feh', '--bg-scale', wallpaper],
        ['dropbox'],
        ['redshift-gtk'],
    ]

    for p in processes:
        subprocess.Popen(p)

def init_monitors(monitor1='LVDS1', monitor2='VGA1', monitor3='HDMI1'):
    processes = [
        f"xrandr --output {monitor1} --primary --mode 1366x768 --pos 0x0 --rotate normal --output DP1 --off --output {monitor3} --off --output {monitor2} --mode 1366x768 --pos 1366x0 --rotate normal --output VIRTUAL1 --off",
        f"xrandr --output {monitor1} --primary --mode 1366x768 --pos 0x0 --rotate normal --output DP1 --off --output {monitor3} --mode 1920x1080 --pos 1366x0 --rotate normal --output {monitor2} --off --output VIRTUAL1 --off",
        #"sh .screenlayout/hdmi.sh",
        #"sh .screenlayout/vga.sh",
    ]

    for p in processes:
        subprocess.Popen(p, shell=True)
