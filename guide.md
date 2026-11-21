# Setup guide

## Install

Keep this checkout at `~/all/light/setup`. Install the current Arch packages.

```sh
sudo pacman -S sway swaybg swaylock waybar foot alacritty wmenu grim slurp wl-clipboard wf-recorder gammastep brightnessctl pipewire pipewire-pulse wireplumber libpulse pavucontrol networkmanager xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk polkit-gnome mako libnotify ttf-jetbrains-mono-nerd otf-font-awesome util-linux procps-ng bash git python neovim lua ripgrep fd fzf zoxide eza yazi btop less nodejs npm pnpm prettier zig tree-sitter-cli base-devel curl tar zip unzip firefox obsidian imv mpv transmission-gtk
```

If you use NetworkManager, enable it with `sudo systemctl enable --now NetworkManager`. Install Codex separately if you use the shell shortcuts.

Create the optional home directories you use.

```sh
mkdir -p ~/all/light/arts ~/all/light/work ~/Apps ~/Assets ~/Captures/screenshots ~/Captures/videos
```

Run these from the checkout. The first command previews the symlinks. The second applies them.

```sh
python3 scripts/install.py
python3 scripts/install.py --apply
```

The installer links managed app directories under `~/.config`, Bash and Git settings, and helpers under `~/.local/bin`. It backs up replaced files under `~/.local/state/setup/backups/`. Edit the configs in this checkout. Start a new shell and Sway session after installing.

## Local settings

Put personal Bash and Git settings in `dotfiles/.bashrc.local` and `dotfiles/.gitconfig.local`. The installer links both into your home directory. Copy `dotfiles/.config/sway/local.conf.example` to `local.conf` in the same directory for monitor and input overrides.

If you use Git's credential store, put `.git-credentials` in `dotfiles/` with mode `0600` and add this to `.gitconfig.local`. Git ignores these local files.

```gitconfig
[credential]
    helper =
    helper = store --file ~/.git-credentials
```

## Shell and Neovim

Use `c` to jump between projects. Run `v` for Neovim, `a` for Codex inside Neovim, or `A` for Codex directly.

Choose `setup` in Codex's `/theme` picker to use the setup palette for code and diffs.

Neovim installs plugins and parsers on first use. Mason installs language servers when you open a file. Run `:MasonInstall stylua` for Lua formatting. Update tools with `:Lazy update`, `:TSUpdate`, and `U` in `:Mason`.

The Obsidian workspaces are `~/all/light/vault` and `~/all/light/arts/grappling`. Wrapping starts off. Spelling starts on in regular buffers.

| Keys                                              | Action                                                  |
| ------------------------------------------------- | ------------------------------------------------------- |
| `Space a` / `Space s`                             | Files / symbols and Markdown headings                   |
| `Space q` / `Space w`                             | Find files / search text                                |
| `Space e` / `Space r`                             | Diagnostics / recent files                              |
| `Space dq` / `Space dw`                           | Definitions / references                                |
| `Space de` / `Space dr` / `K`                     | Rename / code action / documentation                    |
| `Space d=`                                        | Format buffer or selection                              |
| `Space ff` / `Space fd` / `Space fq`              | Diff / file history / close diff                        |
| `Space oo` / `Space on` / `Space oe` / `Space ow` | Open in Obsidian / new note / find notes / search notes |
| `Space ol` / `Space ob` / `Space ot`              | Note links / backlinks / template                       |
| `Space x` / `Space z` / `Space v`                 | Toggle wrapping / numbers / spelling                    |
| `Space 1`, `Space 2`, or `Space 3`                | Open a terminal                                         |
| `Ctrl+3` in a Neovim terminal                     | Return to normal mode                                   |

See [Neovim keymaps](dotfiles/.config/nvim/lua/keymaps.lua) for the full list.

## Sway and terminals

`Mod` is Super after the Alt/Super swap. Caps Lock acts as Ctrl. `Alt+Space` switches between US and Bulgarian phonetic.

| Keys                              | Action                                                               |
| --------------------------------- | -------------------------------------------------------------------- |
| `Mod+Return` / `Mod+q`            | Open Foot / app launcher                                             |
| `Mod+m` / `Mod+Shift+m`           | Region / full-screen screenshot                                      |
| `Mod+n` / `Mod+Shift+n` / `Mod+b` | Region / full-screen recording / stop                                |
| `Mod+Escape`                      | Lock screen                                                          |
| `Mod+d` / `Mod+Shift+d`           | Dismiss latest / all notifications                                   |
| `Mod+Shift+z` / `Mod+Shift+x`     | Reload config / exit Sway                                            |
| `Ctrl+1` in Foot or Alacritty     | Edit the shell command. `ZZ` returns it to the prompt, `ZQ` cancels. |
| `Ctrl+2` in Foot / Alacritty      | Open scrollback in Neovim / enter terminal vi mode                   |

Screenshots go to `~/Captures/screenshots` and the clipboard. Recordings go to `~/Captures/videos`. Use `:w <path>` to save Foot scrollback beyond the current Neovim session. Start a new Sway session to pick up changes to startup services.

See [Sway bindings](dotfiles/.config/sway/conf.d/bindings.conf) for the full list.

## Maintain the setup

- Keep Neovim focused on Markdown, Zig, and HTML/CSS/JavaScript/TypeScript without React. Follow current upstream plugin branches, keep `epwalsh/obsidian.nvim`, and leave the generated Lazy lockfile out of Git.
- Keep custom Neovim bindings in [keymaps.lua](dotfiles/.config/nvim/lua/keymaps.lua) and have plugin specs refer to it. Preserve established shortcuts and the Kanagawa-inspired palette unless asked to change them.
- Edit Neovim colors in [palette.lua](dotfiles/.config/nvim/lua/colors/palette.lua) and [theme.lua](dotfiles/.config/nvim/lua/colors/theme.lua). Update the ANSI colors in [Foot](dotfiles/.config/foot/foot.ini) and [Alacritty](dotfiles/.config/alacritty/alacritty.toml) together. Waybar and Yazi use their app configs.
- Keep this guide current when changing packages, setup steps, or shortcuts.

Validate changes without reloading the live session.

```sh
python3 scripts/check.py
git diff --check
```

For an isolated installer test, run `python3 scripts/install.py --target /tmp/setup-home --apply`.
