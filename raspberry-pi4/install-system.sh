#!/bin/bash
# Run with sudo. Installs packages and selects Sway for the NEXT login/boot.
set -euo pipefail
[[ "${SUDO_USER:-}" == "pateplay" ]] || { echo "This captured installer expects the pateplay user; adapt paths and account first." >&2; exit 1; }
mkdir -p /home/pateplay/.local/state/pi-setup
[[ $EUID -eq 0 ]] || { echo 'Run this script with sudo.' >&2; exit 1; }
exec > >(tee -a /home/pateplay/.local/state/pi-setup/system-install.log) 2>&1
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y --no-remove upgrade
apt-get -y --no-remove install sway swaybg waybar foot foot-terminfo wmenu \
  xwayland xdg-desktop-portal-wlr xdg-desktop-portal-gtk lxpolkit \
  wl-clipboard wf-recorder grim slurp mpv ffmpeg imv \
  pulseaudio-utils pavucontrol fonts-font-awesome fonts-jetbrains-mono fonts-roboto \
  git curl ca-certificates unzip zip build-essential pkg-config \
  ripgrep fd-find fzf zoxide eza btop tealdeer less poppler-utils jq \
  nodejs npm python3 python3-venv ruby \
  mesa-vulkan-drivers libvulkan1 vulkan-tools cron dbus-user-session

backup_dir="/var/backups/pi-sway-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup_dir"
cp -a /etc/lightdm/lightdm.conf "$backup_dir/lightdm.conf"
for config in /etc/systemd/logind.conf.d/90-pi-display.conf /etc/systemd/sleep.conf.d/90-pi-display.conf; do
  if [[ -e "$config" ]]; then cp -a "$config" "$backup_dir/$(basename "$(dirname "$config")")-$(basename "$config")"; fi
done

# The main LightDM file overrides drop-ins on this OS, so edit its existing seat.
python3 - <<'PY'
from pathlib import Path
import re
p = Path('/etc/lightdm/lightdm.conf')
s = p.read_text()
values = {'user-session': 'sway', 'autologin-session': 'sway', 'autologin-user': 'pateplay'}
for key, value in values.items():
    s, count = re.subn(r'^' + re.escape(key) + r'=.*$', key + '=' + value, s, flags=re.M)
    if count != 1:
        raise SystemExit('Expected exactly one LightDM setting: ' + key)
p.write_text(s)
PY
install -d /etc/systemd/logind.conf.d /etc/systemd/sleep.conf.d
cat > /etc/systemd/logind.conf.d/90-pi-display.conf <<'EOF'
[Login]
IdleAction=ignore
HandleSuspendKey=ignore
HandleHibernateKey=ignore
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
EOF
cat > /etc/systemd/sleep.conf.d/90-pi-display.conf <<'EOF'
[Sleep]
AllowSuspend=no
AllowHibernation=no
AllowSuspendThenHibernate=no
AllowHybridSleep=no
EOF
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target
systemctl set-default graphical.target
systemctl enable lightdm.service
systemctl enable --now cron.service
lightdm --show-config
printf '\nSystem setup complete. Backup: %s\nSway starts on the next login or reboot; the current session was not stopped.\n' "$backup_dir"
touch /home/pateplay/.local/state/pi-setup/system-complete
