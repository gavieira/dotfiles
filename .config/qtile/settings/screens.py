from libqtile.config import Screen
from settings.bars import primary, secondary

screens_settings = [
    Screen(top=primary),
    Screen(top=secondary)
]

exports = screens_settings
