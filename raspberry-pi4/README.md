# Replicate the working Pi 4 video player

This directory captures the Pi-specific configuration from the working
`pateplay` machine on 2026-09-18. The user confirmed automatic playback after
reboot and smooth playback after the Vulkan rendering fix. The main Arch
dotfiles elsewhere in this repository have not been changed.

This handoff contains setup documentation, configuration files and the launcher.
The new Pi will use a different video supplied separately as `~/video.mp4`.

For another Pi 4, cloning the working microSD is the closest reproduction:
it preserves the OS, kernel, Mesa drivers, packages, local tools, video,
configuration and startup entry together. A fresh rebuild can use this snapshot,
but current apt packages may differ from the captured versions.

## What actually fixed playback

The authoritative launcher is `home/run.sh`, copied unchanged from `~/run.sh`.
Its essential mpv flags are:

```text
--no-config --profile=fast --vo=gpu
--gpu-context=waylandvk --gpu-api=vulkan --hwdec=no
--fullscreen --keepaspect=no --loop-file=inf
```

This uses GPU rendering through Vulkan and CPU video decoding. It is not a
hardware-decoding fix. On this installation the EGL playback path selected
llvmpipe; the Vulkan path selected the Pi's V3D GPU. Do not replace these flags
with the older generic mpv configuration: `--no-config` intentionally bypasses
`~/.config/mpv/mpv.conf`.

`--keepaspect=no` stretches the picture to fill the fullscreen area supplied by
Sway, without adding letterboxing or cropping the image. A different screen
aspect ratio will distort the picture. Monitor orientation is configured
separately by the production installer in Sway. Black borders encoded inside
the video itself are part of the image and are not removed by this option.

The original playback check used H.264 at 1280x720, 30 fps, with no audio stream.
No video is included or required from the original Pi. Verify smooth playback
with the new Pi's own video, since its codec, resolution and frame rate may differ.

Reference versions:

| Component | Working version |
| --- | --- |
| OS | Raspberry Pi OS, Debian 13 trixie, ARM64 |
| Kernel | 6.18.50+rpt-rpi-v8 |
| Sway | 1.10.1-2+rpt1 |
| mpv | 0.40.0-3+deb13u1 |
| Mesa EGL / DRI / Vulkan | 26.2.2-1~bpo13+0~rpt1 |
| Vulkan loader | 1.4.309.0-1 |
| FFmpeg | 8:7.1.5-0+deb13u1+rpt2 |

`packages-installed.tsv` is the full version inventory, not an instruction to
blindly install every listed package. `apt-manual.txt` records manual selections.

## Clone using another PC and one card reader

1. Save work and shut down the source Pi cleanly with `sudo poweroff`. Wait for
   shutdown, disconnect power, then remove the microSD. Do not remove it live.
2. Put the source card in the other PC's reader. Identify the entire physical
   card by model and size. Do not select just its small FAT boot partition.
3. Use a disk-imaging tool to **read the whole card into an image file** on the
   PC's internal drive. Do not save the image onto the source card itself.
   The source card is about 116.5 GiB (marketed as 128 GB). An uncompressed raw
   image needs that much free space even though much less space is in use.
4. Safely eject the source card and keep it unchanged. Insert the destination.
5. Identify the destination again: its device name may differ. Verify its actual
   byte capacity is at least that of the source. Same printed capacity is not a
   guarantee. A larger card avoids this issue; 256 GB is ample for this source.
6. **Writing erases everything on the destination.** Write the saved image to
   the destination's entire physical device and enable verification in the
   imaging tool when available. Wait for completion and safely eject it.
7. Put the original card back in the original Pi and the cloned card in the new
   Pi 4. Attach the intended HDMI display and power up the new Pi. It should
   automatically enter Sway after the startup wait. A whole-card clone initially
   includes the old video too: stop playback and replace `~/video.mp4` with the
   new Pi's intended video before deployment.
8. If the destination is larger, the original partition sizes initially remain.
   Expand the root filesystem on the new Pi using raspi-config if the extra
   space is needed.

The exact imaging commands depend on whether the other PC runs Linux, Windows,
or macOS. Identify the actual disks before constructing any raw-write command.
Raspberry Pi Imager can write an existing image via its custom-image option;
creating the source image requires a disk-reading/imaging tool.

### Arch Linux / Sway: graphical imaging

On the other PC, install `gnome-disk-utility` with pacman and launch
`gnome-disks` as your normal user. Allow roughly 130 GB of free space for this
card's raw image. In Disks, select the source card's whole device in the left
sidebar, unmount its mounted partitions, then use the top-level drive menu's
**Create Disk Image…** action. Save the `.img` on the PC's internal storage.
Wait for completion, safely eject, and swap to the destination card. Select that
card's whole device and use **Restore Disk Image…** with the saved `.img`.
Double-check the selected destination before accepting the erase confirmation.
Do not use the partition gear menu's partition-image actions: the bootable
clone needs the entire card, including its partition table and both partitions.

For the most reliable image, use the shut-down source card as above. A raw image
of the running Pi's root filesystem is not a consistent backup.

An alternative is Raspberry Pi OS's SD Card Copier (`piclone`, already installed
on the source), with a USB reader plugged into the Pi. It supports filesystem
copying and new partition UUIDs. Close applications that write data first.

### Give the clone its own identity

A whole-card copy also copies the hostname, OS machine ID, SSH host keys, saved
Wi-Fi settings, user files, browser sessions and signed-in tools. It does not
copy board EEPROM/firmware, hardware serial numbers or the hardware MAC address.

Before running both machines together on the same network, configure a distinct
hostname (for example `pateplay-2`), inspect copied static network settings, and
give the clone its own machine ID and SSH host keys. Do this on the clone only,
using its local console; regenerating SSH keys changes its remote host identity.
Keep the username `pateplay` so the captured absolute paths continue to work.
If a saved network profile is tied to the old MAC address, adapt that profile.
Do not publish the full disk image: it contains the source machine's credentials.

## Fresh-install route

Use Raspberry Pi OS **64-bit with Desktop**, based on Debian 13/trixie, on the
new Pi 4. Create the user `pateplay`; choose a different hostname. Configure
networking normally. This recipe assumes that OS family and account name.

Clone this repository, ensuring this directory has actually been committed and
pushed first. Until then it is only on the source Pi and can instead be copied
by USB or SSH.

```sh
git clone https://github.com/vissmadr/setup.git ~/setup
cd ~/setup/raspberry-pi4
```

### 1. Packages and system settings

Review `install-system.sh`, then run it on the new Pi:

```sh
sudo bash ~/setup/raspberry-pi4/install-system.sh
```

This adapted installer includes the original apt packages plus the crucial
`mesa-vulkan-drivers`, `libvulkan1`, `vulkan-tools`, `cron` and session D-Bus
support. It backs up LightDM settings, selects Sway autologin, enables graphical
boot and cron, and disables sleep/hibernate. It does not reboot or log out.
It assumes the Raspberry Pi OS LightDM config contains the expected active
settings; it stops if this differs rather than guessing.

Check `/boot/firmware/config.txt` for `dtoverlay=vc4-kms-v3d` and `arm_64bit=1`.
The captured file is included as `reference-boot-config.txt` for comparison.
Do not overwrite a new machine's whole boot configuration or copy the original
`cmdline.txt`/`fstab`: their partition identifiers belong to that installation.

### 2. Restore the Pi-specific user files

Back up existing destination files first. Restore the selected directories from
`home/.config/` into `~/.config/`, using the snapshot in this directory instead
of copying the Arch dotfiles over it afterwards. Restore `home/.xsessionrc`,
`home/run.sh`, and `home/.local/bin/nvim-scrollback-foot` to corresponding paths.
Make both scripts executable. Merge this line into the destination `.bashrc`:

```sh
[ ! -f "$HOME/.config/bash/pi-setup.bash" ] || . "$HOME/.config/bash/pi-setup.bash"
```

Ensure `~/.local/bin` is on PATH in the login environment too. Create the
directories used by your shortcuts:

```sh
mkdir -p ~/.local/bin ~/.local/opt ~/.local/share/fonts
mkdir -p ~/core ~/work ~/Apps ~/Assets
mkdir -p ~/Pictures/backgrounds ~/Pictures/screenshots ~/Videos/screencasts
ln -s /usr/bin/fdfind ~/.local/bin/fd
ln -s ~/setup ~/core/setup
```

Do not replace existing links without inspecting them. Use the `pateplay` user
for these operations, not root. The snapshot already includes Debian fzf paths,
Foot compatibility fixes, the correct scrollback helper path, the keyboard
layout, laptop-module removal, and disabled idle/color-shifting startup.

### 3. Restore the local tools and editor

Debian's Neovim 0.10 is too old for this configuration. `downloads.json` contains
the exact upstream release URLs and SHA-256 digests used for these ARM64 tools:

- Neovim 0.12.5: extract the complete tarball under `~/.local/opt` and link
  `~/.local/bin/nvim` to `../opt/nvim-linux-arm64/bin/nvim`.
- Node.js 24.21.0: extract under `~/.local/opt` and link `~/.local/bin/node` to
  `../opt/node-v24.21.0-linux-arm64/bin/node`.
- Yazi 26.9.1: extract both `yazi` and `ya` into `~/.local/bin`.
- Tree-sitter CLI 0.27.0: decompress the gzip executable into
  `~/.local/bin/tree-sitter`.
- StyLua 2.5.2: extract `stylua` into `~/.local/bin`.
- JetBrains Mono Nerd Font 3.5.1: extract the NerdFontMono `.ttf` files under
  `~/.local/share/fonts/JetBrainsMono`, then run `fc-cache -f`.

Verify each download against its manifest digest before extracting it. Set
executable permissions on extracted tools. Preserve the Neovim/Node directory
structure; copying their executable alone loses runtime files. For exact copies
without downloading, transfer those selected directories/binaries and fonts
from the source Pi instead. Do not copy the entire home directory or credentials.

Use `npm-packages.json` to install the recorded versions of all eight npm tools
with `npm install --global --prefix "$HOME/.local" package@version ...`.
Check `node --version` first: it must select the local Node 24, not Debian's
Node 20. Transitive npm dependencies can still change in a fresh install.

The snapshot includes `home/.config/nvim/lazy-lock.json`. Clone lazy.nvim from
its official repository at the commit recorded for `lazy.nvim` in that lockfile
into `~/.local/share/nvim/lazy/lazy.nvim`. Use `nvim --headless '+Lazy! restore'
+qa` to restore recorded plugin revisions rather than updating to new versions.

Treesitter installs asynchronously: allow the installation tasks to finish,
including query files and revision files, before quitting. There are 21 parsers
listed in `lua/plugins/treesitter.lua`. To bootstrap deterministically, use a
temporary minimal Neovim init that adds the installed nvim-treesitter plugin to
runtimepath, configures `install_dir` to `stdpath('data') .. '/site'`, and calls
`require('nvim-treesitter').install(languages, {max_jobs=2}):wait(600000)` with
that same list. Do not run two parser installers concurrently. Exit only after
the task completes, not merely when `.so` files appear. Then check normal
Neovim startup, `:checkhealth nvim-treesitter`, and language-server attachment.

### 4. Video and boot playback

Place the video intended for the new Pi at `~/video.mp4`, using a USB drive or
SSH. Supply this file separately; do not copy the original Pi's video as part
of the setup. If replacing a video on a running system, stop playback first,
finish copying, then run `~/run.sh` again. Keep the captured launcher's FPS fix,
environment discovery, logging and duplicate guard.

If the new video is not available yet, finish the software and startup setup
and report video verification as pending. The launcher reports a missing file
and exits; it must be started again after the file is supplied, or on reboot.

Use `crontab -e` as `pateplay` and add this line once, preserving existing jobs:

```cron
@reboot /home/pateplay/run.sh
```

Do not put it in root's crontab or add a second launch in Sway. There is no
supervisor: a manually closed or crashed player stays stopped until relaunched
or rebooted. Boot waits 15 seconds and then waits for the Wayland socket;
terminal launches start immediately when the compositor is ready.

### 5. Verify before deployment

- `foot --check-config`; validate Sway without disturbing the current desktop.
- `lightdm --show-config`: `user-session=sway`, `autologin-session=sway`,
  `autologin-user=pateplay`; graphical target and LightDM/cron enabled.
- `systemctl is-enabled sleep.target suspend.target hibernate.target`: masked.
- `lsmod`: `v3d` and `vc4`; `vulkaninfo --summary`: Pi V3D available, not only a
  software Vulkan device. `mpv --no-config --gpu-context=help`: `waylandvk` exists.
- Run `~/run.sh` inside Sway. Verify fullscreen playback, smooth motion and
  multiple loops. `~/video.log` should show mpv's video output, not an error.
- For renderer diagnostics, stop the existing player and run its exact mpv
  arguments with `--log-file=/tmp/mpv-renderer.log -v` added. Inspect that log
  for the selected V3D Vulkan device; do not accept llvmpipe/lavapipe as evidence
  of GPU rendering. Check dropped frames over a sustained run, not startup alone.
- Save work and reboot with the user's coordination. Verify automatic playback
  on the actual HDMI monitor. Test the final resolution, second monitor if used,
  audio if present, and enough runtime to observe thermal/load problems.

## Handoff to an assistant on a fresh Pi

> Replicate the working Pi 4 setup using `~/setup/raspberry-pi4/README.md` and
> its captured files. Inspect this machine first, back up existing settings,
> and perform the installation. Preserve the exact `run.sh` Vulkan rendering
> flags and user-cron startup. Use the captured Pi configs, local tool versions,
> and plugin lockfile. This Pi will play a different video, supplied separately
> as `~/video.mp4`. Do not copy the original Pi's video. If the new video is
> missing, complete the setup and report playback verification as pending.
> Do not copy private credentials, overwrite unrelated networking, or reboot
> without coordinating with me. Verify the actual video plays smoothly after
> reboot. Report any deviations from the captured system.

The original short `raspberry-setup.md` describes the earlier general desktop
setup. For this video-player replication, this guide supersedes its instruction
to omit boot playback automation.

## Sources

- [Official SD Card Copier project](https://github.com/raspberrypi-ui/piclone)
- [Raspberry Pi Imager documentation](https://www.raspberrypi.com/documentation/computers/getting-started.html)
- [mpv option reference](https://mpv.io/manual/stable/)

Captured files and helper installer were reviewed locally. A fresh installation
using this directory has not yet been executed on a second Pi. Cloning is the
route that retains the exact installed dependency versions.
