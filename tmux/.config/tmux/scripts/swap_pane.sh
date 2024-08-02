#!/usr/bin/env bash

direction="${1}" # left, down, up or right

# Check if the current pane is at the edge
case "${direction}" in
    left)
        is_edge=$(tmux display-message -p "#{pane_at_left}")
        ;;
    down)
        is_edge=$(tmux display-message -p "#{pane_at_bottom}")
        ;;
    up)
        is_edge=$(tmux display-message -p "#{pane_at_top}")
        ;;
    right)
        is_edge=$(tmux display-message -p "#{pane_at_right}")
        ;;
    *)
        echo "Direction must be one of \"left\", \"down\", \"up\" or \"right\"."
        exit 1
        ;;
esac

# Do nothing if the pane is at the edge
if [[ "${is_edge}" -eq 1 ]]; then
    exit 0
fi

# Get pane_id, border position, and pane size for the current pane and other panes
case "${direction}" in
    left)
        current_info=$(tmux display-message -p "#{pane_id} #{pane_left} #{pane_top} #{pane_bottom}")
        mapfile -t other_panes < <(tmux list-panes -F "#{pane_id} #{pane_right} #{pane_top} #{pane_bottom}" -f "#{m:0,#{pane_active}}")
        boundary_offset=-2
        ;;
    down)
        current_info=$(tmux display-message -p "#{pane_id} #{pane_bottom} #{pane_left} #{pane_right}")
        mapfile -t other_panes < <(tmux list-panes -F "#{pane_id} #{pane_top} #{pane_left} #{pane_right}" -f "#{m:0,#{pane_active}}")
        boundary_offset=2
        ;;
    up)
        current_info=$(tmux display-message -p "#{pane_id} #{pane_top} #{pane_left} #{pane_right}")
        mapfile -t other_panes < <(tmux list-panes -F "#{pane_id} #{pane_bottom} #{pane_left} #{pane_right}" -f "#{m:0,#{pane_active}}")
        boundary_offset=-2
        ;;
    right)
        current_info=$(tmux display-message -p "#{pane_id} #{pane_right} #{pane_top} #{pane_bottom}")
        mapfile -t other_panes < <(tmux list-panes -F "#{pane_id} #{pane_left} #{pane_top} #{pane_bottom}" -f "#{m:0,#{pane_active}}")
        boundary_offset=2
        ;;
    *)
        echo "Direction must be one of \"left\", \"down\", \"up\" or \"right\"."
        exit 1
        ;;
esac

# Read the current pane info
IFS=' ' read -r current_pane_id current_boundary current_start current_end <<< "${current_info}"

max_length=0

for other_pane_info in "${other_panes[@]}"; do
    IFS=' ' read -r other_pane_id other_boundary other_start other_end <<< "${other_pane_info}"

    # Calculate boundary posistion diff
    diff=$((current_boundary - other_boundary + boundary_offset))

    # Calculate the length of the boundary tangent to the current pane 
    start=$([[ "${current_start}" -gt "${other_start}" ]] && echo "${current_start}" || echo "${other_start}")
    end=$([[ "${current_end}" -lt "${other_end}" ]] && echo "${current_end}" || echo "${other_end}")
    length=$((end - start))

    # Pane with diff=0 and max tangent length is the target pane
    if [[ "${diff}" -eq 0 ]] && [[ "${length}" -gt "${max_length}" ]]; then
        target_pane_id="${other_pane_id}"
        max_length="${length}"
    fi
done

tmux swap-pane -d -s "${current_pane_id}" -t "${target_pane_id}"
