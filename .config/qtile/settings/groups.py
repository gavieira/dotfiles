from libqtile.config import Group

group_settings = [
    (
        "1",
        {
            "label": "",
            "layout": "monadwide",
        }
    ),
    (
        "2",
        {
            "label": "Web",
            "layout": "max"
        }
    ),
    (
        "3",
        {
            "label": "Docs",
            "layout": "max"
        }
    ),
    (
        "4",
        {
            "label": "Vid",
            "layout": "max"
        }
    ),
    (
        "7",
        {
            "label": "",
            "layout": "max"
        }
    ),
    (
        "8",
        {
            "label": "",
            "layout": "max"
        }
    ),
    (
        "9",
        {
            "label": "Email",
            "layout": "max"
        }
    ),
    (
        "0",
        {
            "label": "Music",
            "layout": "max"
        }
    )
]

exports = [Group(name, **kwargs) for name, kwargs in group_settings]
