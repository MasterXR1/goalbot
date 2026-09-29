#!/bin/bash
# Mac: double-click to launch GoalBot at http://localhost:8765
cd "$(dirname "$0")"
( sleep 1; open "http://localhost:8765" ) &
python3 -m http.server 8765 --bind 127.0.0.1
