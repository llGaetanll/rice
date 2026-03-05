#!/bin/bash

STATEFILE="/tmp/whisper-dictate.status"

while true; do
    if [ -f "$STATEFILE" ]; then
        STATUS=$(cat "$STATEFILE")
        case "$STATUS" in
            recording)    echo "REC" ;;
            transcribing) echo "..." ;;
            *)            echo "" ;;
        esac
    else
        echo ""
    fi
    sleep 0.5
done
