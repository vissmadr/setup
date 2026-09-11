# Raspberry Pi setup

Configure this Raspberry Pi 4 running Raspberry Pi OS. The OS is already installed and working. Do the setup, not just provide instructions; ask for my help when needed.

Use my repository as the reference: https://github.com/vissmadr/setup.git

## Install software

- Check the OS version and architecture, then use `apt` to install the needed software.
- Install Git and clone the repository into `~/core/setup` if it isn't already there.
- Read `guide/packages.md`, `guide/home.md`, and the dotfiles. Use their package list as a starting point, adapting package names to Raspberry Pi OS.
- Install Sway and its Wayland dependencies, Foot, Neovim, mpv, and the tools needed by the configs.
- Include essentials such as `build-essential` (GCC and make), `pkg-config`, `curl`, `unzip`, `ripgrep`, `fd-find`, `fzf`, and `wl-clipboard`. Install compiler/build tools and language runtimes required by the Neovim plugins.
- Install the launcher, fonts, and other small utilities referenced by the configs where available. Skip unrelated heavyweight applications.

## Put the configs in place

- Back up existing configs before replacing them.
- Copy the Sway, Foot, and Neovim configs from `dotfiles/.config/` into `~/.config/`. Use Foot by default; Alacritty is fine if needed.
- Copy any required helpers from `dotfiles/.local/bin/`, make them executable, and ensure `~/.local/bin` is on PATH.
- Merge useful Bash settings without breaking the existing shell setup.
- Adapt hardcoded paths, unavailable commands, fonts, and laptop-specific settings for this Pi. Preserve the repo's appearance and keybindings where practical.
- Check that the installed Neovim version supports the config and plugins; use compatible versions or make small adjustments as needed. Install the plugins and their actual prerequisites.
- Do not blindly run repository scripts or copy personal Git identity settings.

## Keep video playback uninterrupted

- Disable automatic screen blanking, locking, suspend, and hibernation for this setup. Check Sway's included configs and startup programs too.
- Disable the repo's automatic `gammastep` startup so it doesn't change video colors.
- Make sure mpv can play a video fullscreen indefinitely: use `--loop-file=inf` for one file or `--loop-playlist=inf` for a playlist.
- Keep playback simple. No custom services, supervisors, or boot automation unless I ask for them.

## Check the result

Verify Sway, Foot, Neovim, and the clipboard work, and test looping playback if a video is available. Help me enter the Sway session if necessary. Preserve working networking and coordinate any logout or reboot with me.

Finish with a short summary of what was installed, any config adjustments, how to start Sway, and the command to loop a video. Clearly mention anything that still needs my input or testing.
