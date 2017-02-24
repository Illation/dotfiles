#!/bin/sh
tmux new-session -d 'nvim' #-c nvim 
tmux split-window -p 5 -v 'zsh'
tmux split-window -h 'ranger' #-c ranger
tmux -2 attach-session -d 
