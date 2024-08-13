#!/usr/bin/env bash

base_session_name="${1}"
base_window_index="${2}"
base_current_path="${3}"
command="${4:-zsh}"

# Create a session specifically for popup windows if not exists
readonly session_name="popup"
if ! tmux has-session -t "${session_name}" 2>/dev/null; then
    tmux new-session -d -s "${session_name}"
    
    # Disable status line for popup session
    tmux set-option -t "${session_name}" status off
    
    # Creating a new session from run-shell switches to the new session for popup even if `-d` is specified,
    # so have to change it back to the original session.
    tmux switch-client -t "${base_session_name}:${base_window_index}"
fi

# Toggle popup window
if [[ "$(tmux display-message -p "#{session_name}")" == "${session_name}" ]]; then
    tmux detach-client
else
    # Create window if not exists
    readonly window_name="${base_session_name}_${base_window_index}_${command}"
    if ! tmux list-windows -t "${session_name}" -F "#{window_name}" | grep -q "^${window_name}$"; then
        tmux new-window -t "${session_name}" -n "${window_name}" -c "${base_current_path}" "${command}"
    fi

    # Change popup window size based on the command
    case "${command}" in
      zsh|taskwarrior-tui)
        height="80%"
        width="60%"
        ;;
      *)
        height="80%"
        width="80%"
        ;;
    esac

    tmux display-popup -E \
        -h "${height}" -w "${width}" \
        "tmux attach-session -t ${session_name}:${window_name}"
fi
