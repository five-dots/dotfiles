# -*- coding: utf-8 -*-

import re
from xkeysnail.transform import *

define_multipurpose_modmap({
    Key.CAPSLOCK: [Key.ESC, Key.LEFT_CTRL],
    Key.SPACE: [Key.SPACE, Key.LEFT_SHIFT],
    Key.LEFT_ALT: [Key.MUHENKAN, Key.LEFT_ALT],
    Key.RIGHT_ALT: [Key.HENKAN, Key.RIGHT_ALT]
})

define_keymap(None, {
    #K("C-h"): K("Backspace"),
    K("M-h"): K("Left"),
    K("M-j"): K("Down"),
    K("M-k"): K("Up"),
    K("M-l"): K("Right")
}, "hjkl")
