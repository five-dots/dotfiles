#!/usr/bin/env bash

current_pane_id=$(tmux display-message -p "#{pane_id}")
target_pane_id=$(tmux display-panes -d 0 "display-message -p '%%'")

# Trim leading and trailing whitespaces
target_pane_id=$(echo "${target_pane_id}" | sed "s/^[[:space:]]*//;s/[[:space:]]*$//")

tmux swap-pane -d -s "${current_pane_id}" -t "${target_pane_id}"
