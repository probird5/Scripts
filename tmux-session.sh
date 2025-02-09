#!/bin/bash

# Start a new Tmux session named 'custom-layout'
tmux new-session -d -s custom-layout

# Rename the window
tmux rename-window -t custom-layout:1 'Main'

# Split the window: left pane for Neovim
tmux send-keys -t custom-layout:1.0 'nvim' C-m
sleep 0.5  # Allow some time for Neovim to load properly

# Split the right pane into a top and bottom layout
tmux split-window -h -t custom-layout:1
tmux split-window -v -t custom-layout:1.1

# Run btop in the bottom-right pane
tmux send-keys -t custom-layout:1.2 'btop' C-m

# Attach to the session
tmux select-pane -t custom-layout:1.0
tmux attach-session -t custom-layout

