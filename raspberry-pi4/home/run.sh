#!/bin/bash
# Run from cron or a terminal. Press q in the video window to stop playback.
set -euo pipefail
export PATH=/usr/bin:/bin

video_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
interactive=false
if [[ -t 0 || -t 1 || -t 2 ]]; then
    interactive=true
fi

# Keep a second invocation from starting another player.
exec 9>"$video_dir/.video-player.lock"
if ! flock -n 9; then
    echo "Video playback is already running (or starting). Press q in its window to stop it."
    exit 0
fi
if "$interactive"; then
    exec > >(tee "$video_dir/video.log") 2>&1
    echo "Starting video. This terminal stays occupied during playback; press q in the video window or Ctrl+C here to stop."
else
    exec >"$video_dir/video.log" 2>&1
fi

if [[ ! -r "$video_dir/video.mp4" ]]; then
    echo "Cannot read $video_dir/video.mp4"
    exit 1
fi

# Cron has no desktop environment. Wait for automatic Sway login, then find
# its Wayland socket instead of assuming that it will be called wayland-0.
if ! "$interactive"; then
    sleep 15
fi
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export XDG_SESSION_TYPE=wayland
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
unset DISPLAY
# Keep the current terminal's Wayland display when it is valid.
wayland_socket="${WAYLAND_DISPLAY:-}"
if [[ "$wayland_socket" != /* ]]; then
    wayland_socket="$XDG_RUNTIME_DIR/$wayland_socket"
fi
if [[ ! -S "$wayland_socket" || ! -O "$wayland_socket" ]]; then
    unset WAYLAND_DISPLAY
fi
shopt -s nullglob
for ((attempt = 0; attempt < 120; attempt++)); do
    if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
        break
    fi
    if (( attempt == 0 )); then
        echo "Waiting for the Sway/Wayland session..."
    fi
    for socket in "$XDG_RUNTIME_DIR"/wayland-*; do
        if [[ -S "$socket" && -O "$socket" ]]; then
            export WAYLAND_DISPLAY="${socket##*/}"
            break 2
        fi
    done
    sleep 1
done

if [[ -z "${WAYLAND_DISPLAY:-}" ]]; then
    echo "Wayland did not become ready after waiting 120 seconds. Check Sway autologin."
    exit 1
fi

# Vulkan selects the Pi's V3D GPU; EGL on this installation selects llvmpipe.
# Stretch to the available fullscreen area, even when aspect ratios differ.
echo "Playing $video_dir/video.mp4 on $WAYLAND_DISPLAY"
exec /usr/bin/mpv \
    --no-config \
    --profile=fast \
    --vo=gpu \
    --gpu-context=waylandvk \
    --gpu-api=vulkan \
    --hwdec=no \
    --fullscreen \
    --keepaspect=no \
    --loop-file=inf \
    --stop-screensaver=yes \
    --no-osc \
    --osd-level=0 \
    --quiet \
    --cursor-autohide=always \
    --wayland-app-id=boot-video \
    --input-ipc-server="$XDG_RUNTIME_DIR/mpv-video.sock" \
    -- "$video_dir/video.mp4"
