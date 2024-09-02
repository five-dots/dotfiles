#!/usr/bin/env bash

base_pane_id="${1}"
base_current_command="${2}"

file=$(
    fdfind --absolute-path --type f --hidden \
        | fzf-tmux -p -w 60% -h 60% --preview "bat --color=always --style=header,grid --line-range :500 {}"
)

if [[ -z "${file}" ]]; then
    exit 0
fi

if [[ "${base_current_command}" == "${EDITOR}" ]]; then
    # TODO: 既に buffer に存在していたら swith する処理を入れる
    tmux send-keys -t "${base_pane_id}" ":e ${file}" C-m
else
    tmux send-keys -t "${base_pane_id}" "${EDITOR:-nvim} ${file}" C-m
fi

