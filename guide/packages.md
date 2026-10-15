# Packages

The package names below target Arch Linux. Install current versions; translate package names for another distribution.

## Desktop and session

```sh
sudo pacman -S --needed \
  sway swaybg swaylock waybar foot alacritty wmenu \
  grim slurp wl-clipboard wf-recorder gammastep brightnessctl \
  pipewire pipewire-pulse wireplumber pavucontrol networkmanager \
  xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk \
  polkit-gnome mako libnotify \
  ttf-jetbrains-mono-nerd otf-font-awesome
```

Sway's config starts Waybar, gammastep, the notification daemon, and the policy authentication agent. PipeWire and desktop portals use their distribution user services. Enable NetworkManager using the distribution's service setup if it is not already enabled.

`flock` and `pkill`, used by the recorder helper, come from `util-linux` and `procps-ng` on Arch. The included `/etc/sway/config.d/*` integration imports the session environment into systemd/D-Bus.

## Shell, editor, and development

```sh
sudo pacman -S --needed \
  git bash python neovim lua ripgrep fzf zoxide eza yazi btop less tldr \
  nodejs npm pnpm zig tree-sitter-cli base-devel curl tar unzip
```

Neovim requires version 0.12 or newer. The current Treesitter plugin requires Tree-sitter CLI 0.26.1+ and a C compiler; `base-devel` supplies the compiler on Arch. Install the CLI through the OS package manager rather than npm. See [upstream requirements](https://github.com/nvim-treesitter/nvim-treesitter#requirements).

The configured Mason language servers are `ts_ls`, `html`, `cssls`, `jsonls`, `marksman`, `zls`, and `lua_ls`. Missing servers install during interactive Neovim startup. Install formatting tools inside Neovim:

```vim
:MasonInstall prettier stylua
```

Prettier can also come from a project's Node dependencies. Zig formatting uses the system compiler. Keep Zig and ZLS compatible when updating them. Mason tools and plugins are updated independently; see the root README.

## Applications

```sh
sudo pacman -S --needed firefox obsidian imv mpv
```

Install Codex or other development assistants separately if you use the shell shortcuts. Their local binaries can live under `~/.local/bin` or `~/.opencode/bin`.

## Optional validation tools

```sh
sudo pacman -S --needed shellcheck stylua
```

`python3 scripts/check.py` uses Python 3.11+, Lua's `luac`, Foot, and Sway. ShellCheck and StyLua can additionally check shell code and format editor Lua without opening Neovim.
