# vim: set filetype=zsh :
#!/bin/bash

# exec &> /tmp/tmux_switch_or_create.log

query=$1
session_name="$query"

# If no query was provided, use fzf to select a session
if [ -z "$query" ]; then
    session_name=$(tmux ls | awk -F: '{print $1}' | fzf-tmux --prompt="🖥  Switch Session: " --reverse -p -w 62% -h 38% -m --border --exit-0)
fi

# If there's a session_name at this point (either from the original $query or from fzf)
if [ -n "$session_name" ]; then
    # If the session does not exist, create a new detached session
    if ! tmux has-session -t "$session_name" 2>/dev/null; then
        tmux new-session -d -s "$session_name"
    fi

    # Depending on whether we're inside a tmux session or not, switch to or attach to the session
    if [ -n "$TMUX" ]; then
        tmux switch-client -t "$session_name"
    else
        tmux attach-session -t "$session_name"
    fi
fi
