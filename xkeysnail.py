# -*- coding: utf-8 -*-

import re

from xkeysnail.transform import *

define_multipurpose_modmap({
    Key.CAPSLOCK: [Key.ESC, Key.LEFT_CTRL],
    # Key.SPACE: [Key.SPACE, Key.LEFT_SHIFT],
    Key.LEFT_ALT: [Key.MUHENKAN, Key.LEFT_ALT],
    Key.RIGHT_ALT: [Key.HENKAN, Key.RIGHT_ALT]
})

define_keymap(None, {
    #K("C-h"): K("Backspace"),
    # hjkl move
    K("M-h"): K("Left"),
    K("M-j"): K("Down"),
    K("M-k"): K("Up"),
    K("M-l"): K("Right"),

    K("Shift-M-h"): K("Shift-Left"),
    K("Shift-M-j"): K("Shift-Down"),
    K("Shift-M-k"): K("Shift-Up"),
    K("Shift-M-l"): K("Shift-Right"),
    K("C-Shift-M-h"): K("Home"),
    K("C-Shift-M-l"): K("End")
}, "hjkl")
