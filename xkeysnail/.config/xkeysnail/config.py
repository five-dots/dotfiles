# -*- coding: utf-8 -*-

import re

from xkeysnail.transform import *

# # Swap Alt/Super
# define_modmap({
#     Key.LEFT_ALT: Key.LEFT_META,
#     Key.LEFT_META: Key.LEFT_ALT,
# })

# define_multipurpose_modmap({
#     Key.Q: [Key.Q, Key.LEFT_HYPER],
#     Key.CAPSLOCK: [Key.ESC, Key.LEFT_CTRL],
#     Key.LEFT_CTRL: [Key.ESC, Key.LEFT_CTRL],
#     Key.SPACE: [Key.SPACE, Key.LEFT_SHIFT],
#     Key.LEFT_META: [Key.HENKAN, Key.LEFT_META],
# })

# # Hyper key mappings
# define_keymap(None, {
#     # hjkl move/selection
#     K("Hyper-H"): K("Left"),
#     K("Hyper-J"): K("Down"),
#     K("Hyper-K"): K("Up"),
#     K("Hyper-L"): K("Right"),
#     K("Shift-Hyper-H"): K("Shift-Left"),
#     K("Shift-Hyper-J"): K("Shift-Down"),
#     K("Shift-Hyper-K"): K("Shift-Up"),
#     K("Shift-Hyper-L"): K("Shift-Right"),
#     K("Ctrl-Hyper-H"): K("Ctrl-Left"),
#     K("Ctrl-Hyper-J"): K("Ctrl-Down"),
#     K("Ctrl-Hyper-K"): K("Ctrl-Up"),
#     K("Ctrl-Hyper-L"): K("Ctrl-Right"),
#     K("Ctrl-Shift-Hyper-H"): K("Ctrl-Shift-Left"),
#     K("Ctrl-Shift-Hyper-J"): K("Ctrl-Shift-Down"),
#     K("Ctrl-Shift-Hyper-K"): K("Ctrl-Shift-Up"),
#     K("Ctrl-Shift-Hyper-L"): K("Ctrl-Shift-Right"),
#     # home/end
#     K("Hyper-N"): K("Home"),
#     K("Shift-Hyper-N"): K("Shift-Home"),
#     K("Hyper-Semicolon"): K("End"),
#     K("Shift-Hyper-Semicolon"): K("Shift-End"),
#     # PageUp/PageDown
#     K("Hyper-I"): K("Page_Up"),
#     K("Hyper-M"): K("Page_Down"),
#     # Insert
#     K("Hyper-O"): K("Insert"),
#     # Prev/Next Tab
#     K("Hyper-Comma"): K("Ctrl-Shift-Tab"),
#     K("Hyper-Dot"): K("Ctrl-Tab"),
#     # Ctrl Shortcuts
#     K("Hyper-Y"):     K("Ctrl-C"), # Yank
#     K("Hyper-X"):     K("Ctrl-X"), # Cut
#     K("Hyper-P"):     K("Ctrl-V"), # Paste
#     K("Hyper-A"):     K("Ctrl-A"), # Select All
#     K("Hyper-U"):     K("Ctrl-Z"), # Undo
#     K("Hyper-Slash"): K("Ctrl-F"), # Search
#     # Function Keys
#     K("Hyper-Key_1"): K("F1"),
#     K("Hyper-Key_2"): K("F2"),
#     K("Hyper-Key_3"): K("F3"),
#     K("Hyper-Key_4"): K("F4"),
#     K("Hyper-Key_5"): K("F5"),
#     K("Hyper-Key_6"): K("F6"),
#     K("Hyper-Key_7"): K("F7"),
#     K("Hyper-Key_8"): K("F8"),
#     K("Hyper-Key_9"): K("F9"),
#     K("Hyper-Key_0"): K("F10"),
#     K("Hyper-Minus"): K("F11"),
#     K("Hyper-Equal"): K("F12"),
# }, "Hyper mapping")

define_keymap(re.compile("gnome-terminal|kitty|code", re.IGNORECASE), {
    K("Esc"): [K("Muhenkan"), K("Esc")],
}, "Disable IME")

define_keymap(re.compile("gnome-terminal|kitty", re.IGNORECASE), {
    # Copy/Cut/Paste
    K("Ctrl-C"): K("Ctrl-Shift-C"),
    K("Ctrl-X"): K("Ctrl-Shift-X"),
    K("Ctrl-V"): K("Ctrl-Shift-V"),
    # Cancel
    K("Ctrl-Shift-C"): K("Ctrl-C"),
}, "Terminal")
