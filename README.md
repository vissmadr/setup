# Setup

Personal Linux dotfiles for Bash, Neovim, Sway, Waybar, Foot, Alacritty, Yazi, and btop. The editor focuses on Markdown, Zig, and HTML/CSS/JavaScript/TypeScript without React.

## Install

Install the dependencies in [guide/packages.md](guide/packages.md), then preview the symlinks:

```sh
python3 scripts/install.py
```

Apply them when ready:

```sh
python3 scripts/install.py --apply
```

The installer links each application directory, the shell/Git configs, and individual helpers under `~/.local/bin`. Existing files, directories, and symlinks move to `~/.local/state/setup/backups/<timestamp>/`, preserving their relative paths. Re-running it leaves correct symlinks alone. If a link operation fails, links changed during that run are rolled back and their backups restored. Empty parent/backup directories may remain. Keep this checkout in place: edits here become live after installation.

Before installing, preserve your Git identity and any machine-specific Git settings in `~/.gitconfig.local`. The tracked config includes that file and uses an in-memory credential cache. SSH authentication works independently of that cache.

For an isolated installation, use `--target /tmp/setup-home --apply`. The default invocation only prints a plan.

Start a new shell after installation. Start a new Sway session to apply startup services; `Mod+Shift+z` reloads bindings/settings but does not restart session services. During an existing session, restart Waybar manually to load its changed config.

## Neovim

Requires Neovim 0.12+, Git, Node.js/npm, a C compiler, `curl`, `tar`, and the Tree-sitter CLI. First startup installs plugins and missing parsers asynchronously. The first file's highlighting attaches once its parser finishes installing.

Mason installs the configured language servers on an interactive startup: TypeScript/JavaScript, HTML, CSS, JSON, Markdown (Marksman), Zig (ZLS), and Lua for editing this setup. Install the two external formatters once:

```vim
:MasonInstall prettier stylua
```

Zig formatting uses your installed `zig fmt`. Keep Zig and ZLS on compatible versions. Prettier formats web files, JSON/JSONC, YAML, and Markdown; project formatter settings still apply, with Markdown prose wrapping preserved. Formatting is manual, so writing a file does not rewrite it.

Plugins follow their upstream branches without version pins. Lazy's generated lockfile lives in Neovim's state directory and is not tracked. Update plugins with `:Lazy update`, parsers with `:TSUpdate`, and language servers/formatters through `:Mason` (`U` updates all installed tools). The background plugin checker checks availability without applying updates.

The existing `epwalsh/obsidian.nvim` plugin is retained. The `vault` and `grappling` workspaces match the previous live configuration; note titles, disabled frontmatter, templates, attachments, and link navigation remain configured. All custom keybindings live in `dotfiles/.config/nvim/lua/keymaps.lua`, grouped by editor feature and plugin. Plugin specs reference those definitions to preserve lazy loading; completion, Obsidian vault mappings, and Markdown motions are defined there too. Unmodified plugin defaults are noted at the end of that file.

Markdown uses soft wrapping, display-line `j`/`k` (counts such as `5j` still move by file lines), visible link syntax, and English spell checking. Spelling starts on for regular files with muted curly underlines and is automatically disabled in terminal buffers; toggle it per window with `Space v`. Use `z=` for suggestions, `zg` to remember a valid word in your personal dictionary, and `]s`/`[s` to move between flagged words. Change `spelllang` locally for other languages. Zig uses four-space indentation. The `setup` colorscheme keeps the existing palette and can be restored with `:colorscheme setup`.

| Keys | Action |
| --- | --- |
| `Space a` / `Space s` | Files / symbols and Markdown headings |
| `Space q` / `Space w` | Find files / search text, including hidden files while respecting ignore files |
| `Space e` / `Space r` | Diagnostics / recent files |
| `Space dq` / `Space dw` | Definitions / references |
| `Space de` / `Space dr` / `K` | Rename / code action / documentation |
| `Space d=` | Format buffer or visual selection |
| `Space ff` / `Space fd` / `Space fq` | Diff / file history / close diff |
| `Space oo` / `Space on` / `Space oe` / `Space ow` | Open in Obsidian / new note / find notes / search notes |
| `Space ol` / `Space ob` / `Space ot` | Note links / backlinks / template |
| `Ctrl+n` / `Ctrl+p` / `Enter` | Select completion; Enter accepts an explicitly selected item |
| `Ctrl+l` / `Ctrl+h` in insert/snippet mode | Next/previous snippet field |
| `Space x` / `Space z` / `Space v` | Toggle wrapping / numbers / spelling |
| `Space c` | Toggle color previews |
| `Space 1` | Open a terminal |
| `Ctrl+3` in a Neovim terminal | Leave terminal mode |

Completion/snippets load when needed; Telescope, Aerial, Diffview, formatting, and color previews load on their commands or keys. Use `:Lazy profile`, `:checkhealth`, and `:ConformInfo` to inspect behavior.

## Desktop

Sway keeps the existing workspace, focus, resize, and launch bindings. Its main config defines shared commands and appearance; `conf.d/` separates bindings, input, and session services. `Mod` is Super after the configured Alt/Super swap. The keyboard layouts are US and Bulgarian phonetic, switched with Alt+Space; Caps Lock acts as Ctrl.

| Keys | Action |
| --- | --- |
| `Mod+m` / `Mod+Shift+m` | Region / full-screen screenshot, saved and copied as PNG |
| `Mod+n` / `Mod+Shift+n` / `Mod+b` | Region / full-screen recording / stop this setup's recorder |
| `Mod+Escape` | Lock screen |
| `Mod+d` / `Mod+Shift+d` | Dismiss latest / all notifications |
| `Mod+Shift+z` / `Mod+Shift+x` | Reload config / exit Sway |
| `Ctrl+1` in Foot or Alacritty | Edit the shell command; `ZZ` returns it to the prompt, `ZQ` cancels |
| `Ctrl+2` in Foot / Alacritty | Open scrollback in Neovim / terminal vi mode |

Foot’s Ctrl+2 opens regular Neovim in a normal tiled window, with the scrollback in an editable temporary file. Search, edit, copy, and quit as usual; use `:w <path>` to keep a copy, since the temporary file is removed when Neovim closes. The exported scrollback is plain text, so original terminal-output colors are not retained.

Ctrl+1 never executes the edited command automatically: press Enter at the Bash prompt to run it. Cancelling restores the original command. This applies to the Ctrl+1 command editor; ordinary Neovim buffers keep their normal quit behavior.

Captures create `~/Pictures/screenshots` and `~/Videos/screencasts` as needed. Cancelled selections leave the clipboard unchanged. Recording allows one managed recorder per session runtime directory; stopping it requires a locked PID file, so stale PID files do not target unrelated recordings.

Locking is manual with `Mod+Escape`; this setup does not configure automatic locking or idle screen-off timers.

Copy `~/.config/sway/local.conf.example` to `~/.config/sway/local.conf` for monitor/touchpad settings. This file is ignored by Git and loaded last. Keep personal Bash settings in `~/.bashrc.local` and Git settings in `~/.gitconfig.local`.

Sway retains the distribution's `/etc/sway/config.d/*` integration. On a distribution without that integration, configure its systemd/D-Bus environment and desktop portals separately.

## Validate

```sh
python3 scripts/check.py
git diff --check
```

The config check uses Lua's compiler, GTK's CSS parser, and Sway's headless validation backend; it does not reload the desktop or install plugins.

## Layout

- `dotfiles/`: application configs and executable session helpers.
- `scripts/`: installation preview/application and syntax/config validation.
- `guide/`: package and home-directory setup notes.
- `blueprint/`: reusable project documentation templates; its README explains application rules.
- `colors.md`: palette ownership and editing notes.

## Notifications

Mako hides ordinary notifications after 2.4 seconds; critical alerts stay until dismissed.

For Codex completion notifications, set the top-level `notify` command in
`~/.codex/config.toml` to `["python3", "/absolute/path/to/home/.local/bin/codex-notify.py"]`
and set `notifications = ["approval-requested"]` inside `[tui]` to keep approval alerts
while avoiding duplicate built-in completion notifications.
The helper checks Sway's focused window and its child processes, including shells inside
Neovim. It suppresses completion alerts when that window contains Codex running in the
same project directory. This is a window-level check: another Neovim buffer in that same
window also suppresses alerts, and multiple sessions in the same directory share this rule.
When Sway focus cannot be determined, completion notifications are delivered normally.
Only turn-completion events use this helper; approval notifications keep Codex’s built-in behavior.
