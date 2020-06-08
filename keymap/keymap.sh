#!/bin/sh

if [ -x "$(command -v xmodmap)" ]; then
    xmodmap ~/.Xmodmap

    if [ -x "$(command -v xcape)" ]; then
        if pgrep -x "xcape" > /dev/null; then
            killall xcape
        fi

        ## SandS
        # xmodmap -e 'keycode 255=space'
        # xmodmap -e 'keycode 65=Shift_L'
        # xcape -e '#65=space'

        ## Control_L to Escape if alone
        xcape -e 'Control_L=Escape'

        ## Hyper_R to Henkan_Mode if alone
        xcape -e 'Hyper_R=Henkan_Mode'
    fi
fi
