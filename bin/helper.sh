#!/usr/bin/env zsh

echo_green() {
    GREEN="\033[0;32m"
    END_GREEN="\033[0m"

    echo -e "${GREEN}${1}${END_GREEN}"
}
