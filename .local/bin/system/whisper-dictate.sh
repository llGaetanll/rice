#!/bin/bash


WHISPER_DIR="$HOME/files/repo/whisper.cpp"
WHISPER_BIN="$WHISPER_DIR/build/bin/whisper-cli"

MAX_DURATION_SEC=30
MODEL="$WHISPER_DIR/models/ggml-large-v3.bin"

TMPWAV="/tmp/whisper-dictate.wav"
PIDFILE="/tmp/whisper-dictate.pid"
STATEFILE="/tmp/whisper-dictate.status"

if [ -f "$PIDFILE" ]; then
    kill "$(cat "$PIDFILE")" 2>/dev/null
    wait "$(cat "$PIDFILE")" 2>/dev/null
    rm "$PIDFILE"

    echo "transcribing" > "$STATEFILE"
    notify-send -u low -t 2000 "🎙️ Transcribing..."

    TEXT=$("$WHISPER_BIN" -m "$MODEL" -f "$TMPWAV" -t 8 --no-prints --language auto 2>/dev/null | sed 's/\[.*\] *//')
    TEXT=$(echo "$TEXT" | sed '1{/^$/d}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    if [ -n "$TEXT" ]; then
        xdotool type --delay 5 "$TEXT"
    else
        notify-send -u low -t 2000 "❌ No speech detected"
    fi

    rm -f "$TMPWAV" "$STATEFILE"
else
    arecord -f S16_LE -r 16000 -c 1 -d "$MAX_DURATION_SEC" "$TMPWAV" &
    echo $! > "$PIDFILE"
    echo "recording" > "$STATEFILE"
    notify-send -u low -t 2000 "🔴 Recording..."
fi
