#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ARTIFACTS="$ROOT/artifacts"
RUN_TIMESTAMP="${RUN_TIMESTAMP:-$(date '+%Y-%m-%d_%H-%M-%S')}"
RESULTS_DIR="${RESULTS_DIR:-$ARTIFACTS/results/$RUN_TIMESTAMP}"
DEVICE_ID="${DEVICE_ID:-emulator-5554}"
REMOTE_VIDEO="/sdcard/graton-full-flow.mp4"
LOCAL_VIDEO="$RESULTS_DIR/videos/graton-full-flow.mp4"
SEGMENT_DIR="$RESULTS_DIR/videos/.segments"
PYTHON="${PYTHON:-$ROOT/.venv/bin/python}"
SEGMENT_SECONDS="${SEGMENT_SECONDS:-170}"
FFMPEG="${FFMPEG:-$("$PYTHON" -c 'import imageio_ffmpeg; print(imageio_ffmpeg.get_ffmpeg_exe())')}"

mkdir -p "$RESULTS_DIR/videos"
rm -rf "$SEGMENT_DIR"
mkdir -p "$SEGMENT_DIR"
rm -f "$LOCAL_VIDEO"

start_recording() {
  adb -s "$DEVICE_ID" shell rm -f "$REMOTE_VIDEO"
  adb -s "$DEVICE_ID" shell screenrecord --time-limit "$SEGMENT_SECONDS" "$REMOTE_VIDEO" &
  record_pid=$!
}

cleanup() {
  if kill -0 "$record_pid" 2>/dev/null; then
    kill "$record_pid" 2>/dev/null || true
    wait "$record_pid" 2>/dev/null || true
  fi
  local segment="$SEGMENT_DIR/segment-$(printf '%04d' "$segment_index").mp4"
  adb -s "$DEVICE_ID" pull "$REMOTE_VIDEO" "$segment" >/dev/null 2>&1 || true
  adb -s "$DEVICE_ID" shell rm -f "$REMOTE_VIDEO" >/dev/null 2>&1 || true
  if [ -s "$segment" ]; then
    segment_index=$((segment_index + 1))
  else
    rm -f "$segment"
  fi
  if [ "$segment_index" -eq 0 ]; then
    return
  fi
  find "$SEGMENT_DIR" -name 'segment-*.mp4' -print0 \
    | sort -z \
    | while IFS= read -r -d '' file; do printf "file '%s'\n" "$file"; done \
    > "$SEGMENT_DIR/concat.txt"
  "$FFMPEG" -y -f concat -safe 0 -i "$SEGMENT_DIR/concat.txt" -c copy "$LOCAL_VIDEO" >/dev/null 2>&1
  rm -rf "$SEGMENT_DIR"
}

segment_index=0
record_pid=
start_recording

cd "$ARTIFACTS"
MOBILE_PLATFORM=android \
EXECUTION_TARGET=local \
APPIUM_SERVER_URL="${APPIUM_SERVER_URL:-http://127.0.0.1:4723}" \
DEVICE_NAME="$DEVICE_ID" \
APP_PACKAGE="${APP_PACKAGE:-com.playerhub.graton}" \
APP_ACTIVITY="${APP_ACTIVITY:-com.playerhub.hub.MainActivity}" \
"$PYTHON" -m robot \
  --outputdir "$RESULTS_DIR" \
  --output output.xml \
  --log log.html \
  --report report.html \
  tests &
robot_pid=$!

while kill -0 "$robot_pid" 2>/dev/null; do
  if ! kill -0 "$record_pid" 2>/dev/null; then
    wait "$record_pid" 2>/dev/null || true
    segment="$SEGMENT_DIR/segment-$(printf '%04d' "$segment_index").mp4"
    adb -s "$DEVICE_ID" pull "$REMOTE_VIDEO" "$segment" >/dev/null 2>&1 || true
    adb -s "$DEVICE_ID" shell rm -f "$REMOTE_VIDEO" >/dev/null 2>&1 || true
    if [ -s "$segment" ]; then
      segment_index=$((segment_index + 1))
    else
      rm -f "$segment"
    fi
    start_recording
  fi
  sleep 1
done

set +e
wait "$robot_pid"
robot_status=$?
set -e
trap - EXIT
cleanup
exit "$robot_status"
