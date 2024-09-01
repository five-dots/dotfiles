#!/usr/bin/env bash

base_pane_id="${1}"
base_current_command="${2}"

file=$(
    fdfind --type f --hidden --exclude .git \
        | fzf-tmux -p -w 60% -h 60% --preview "bat --color=always --style=header,grid --line-range :500 {}"
)

if [[ -z "${file}" ]]; then
    exit 0
fi

if [[ "${base_current_command}" == "${EDITOR}" ]]; then
    tmux send-keys -t "${base_pane_id}" ":e ${file}" C-m
else
    tmux send-keys -t "${base_pane_id}" "${EDITOR:-nvim} ${file}" C-m
fi

