# Colors

The setup uses a Kanagawa-inspired palette with `#202020` terminal backgrounds and `#C7C3A5` foreground text.

- Neovim palette: [palette.lua](dotfiles/.config/nvim/lua/colors/palette.lua).
- Neovim semantic roles: [theme.lua](dotfiles/.config/nvim/lua/colors/theme.lua).
- Neovim highlight groups: `dotfiles/.config/nvim/lua/colors/highlights/`.
- Neovim statusline: `dotfiles/.config/nvim/lua/colors/extra/lualine.lua`.
- Terminal ANSI palettes: `dotfiles/.config/foot/foot.ini` and `dotfiles/.config/alacritty/alacritty.toml`.
- Desktop module colors: `dotfiles/.config/waybar/style.css`.
- Yazi palette: `dotfiles/.config/yazi/flavors/kanagawa.yazi/flavor.toml`.

Change a Neovim color's value in its palette and its use in the semantic theme. Other applications keep native config files; update both terminals together when changing ANSI colors. There is no palette generation step.

Restore Neovim's highlights with `:colorscheme setup`. The editor keeps a transparent main background so it uses the terminal's background.
