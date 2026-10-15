# Setup

Personal Linux dotfiles and project documentation templates.

## Ownership

- `dotfiles/.config/nvim/`: Lua editor settings, custom colorscheme, filetype settings, and plugin specs.
- `dotfiles/.config/sway/`: compositor bindings, input, startup services, and ignored `local.conf` overrides.
- `dotfiles/.config/waybar/`: bar modules and GTK CSS.
- `dotfiles/.config/foot/` and `alacritty/`: terminal colors and shell/scrollback shortcuts.
- `dotfiles/.local/bin/`: Bash capture and scrollback helpers.
- `dotfiles/.bashrc` and `.gitconfig`: shared shell/Git settings; personal settings belong in local includes.
- `scripts/`: backed-up symlink installation and config validation.
- `guide/` and root `README.md`: setup and operating instructions.
- `blueprint/`: reusable documentation guidance, not active rules for this repository. Do not access `blueprint/docs/human/`.

## Preferences

- Focus Neovim on Markdown, Zig, and HTML/CSS/JavaScript/TypeScript without React.
- Keep plugins on current upstream branches; do not commit a plugin lockfile or introduce version pins.
- Keep `epwalsh/obsidian.nvim`; do not switch to a fork without the user's request.
- Keep custom Neovim bindings together in `lua/keymaps.lua`; plugin specs reference its tables/functions.
- Keep concise, aligned comments beside editor settings and explain non-obvious behavior.
- Preserve established shortcuts and the Kanagawa-inspired palette unless a change is requested.
- Validate repository configs before deployment. Do not use validation to reload the live session.
- Keep dependencies explicit in `guide/packages.md` and behavior/shortcuts current in `README.md`.

## Checks

```sh
python3 scripts/check.py
git diff --check
```

Installer previews use `python3 scripts/install.py`; temporary installations use `--target /tmp/<directory> --apply`.
