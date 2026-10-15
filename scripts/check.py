#!/usr/bin/env python3
"""Validate configs without starting apps or installing dependencies."""

import ctypes
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import tomllib


REPOSITORY = Path(__file__).resolve().parents[1]


def run(command, **options):
    if not shutil.which(command[0]):
        raise SystemExit(f"Missing validation dependency: {command[0]}")
    subprocess.run(command, cwd=REPOSITORY, check=True, **options)


def check_waybar_css(path):
    gtk = ctypes.CDLL("libgtk-3.so.0")
    gtk.gtk_css_provider_new.restype = ctypes.c_void_p
    gtk.gtk_css_provider_load_from_path.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.POINTER(ctypes.c_void_p)]
    gtk.gtk_css_provider_load_from_path.restype = ctypes.c_int
    gobject = ctypes.CDLL("libgobject-2.0.so.0")
    gobject.g_object_unref.argtypes = [ctypes.c_void_p]
    glib = ctypes.CDLL("libglib-2.0.so.0")
    glib.g_error_free.argtypes = [ctypes.c_void_p]
    provider = gtk.gtk_css_provider_new()
    error = ctypes.c_void_p()
    valid = gtk.gtk_css_provider_load_from_path(provider, os.fsencode(path), ctypes.byref(error))
    gobject.g_object_unref(provider)
    if not valid:
        class GError(ctypes.Structure):
            _fields_ = [("domain", ctypes.c_uint), ("code", ctypes.c_int), ("message", ctypes.c_char_p)]

        message = ctypes.cast(error, ctypes.POINTER(GError)).contents.message.decode()
        glib.g_error_free(error)
        raise SystemExit(message)


def main():
    dotfiles = REPOSITORY / "dotfiles"
    for path in dotfiles.rglob("*.toml"):
        tomllib.loads(path.read_text())
    json.loads((dotfiles / ".config/waybar/config.jsonc").read_text())
    check_waybar_css(dotfiles / ".config/waybar/style.css")
    for path in (REPOSITORY / "scripts").glob("*.py"):
        compile(path.read_text(), str(path), "exec")
    for path in [dotfiles / ".bashrc", *sorted((dotfiles / ".local/bin").iterdir())]:
        if not path.is_file():
            continue
        if path.suffix == ".py":
            compile(path.read_text(), str(path), "exec")
        else:
            run(["bash", "-n", str(path)])
    for path in sorted((dotfiles / ".config/nvim").rglob("*.lua")):
        run(["luac", "-p", str(path)])
    run(["foot", "--check-config", "--config", str(dotfiles / ".config/foot/foot.ini")])
    with tempfile.TemporaryDirectory(prefix="setup-check-") as runtime:
        environment = os.environ | {
            "XDG_RUNTIME_DIR": runtime,
            "WLR_BACKENDS": "headless",
            "WLR_RENDERER": "pixman",
        }
        environment.pop("SWAYSOCK", None)
        environment.pop("WAYLAND_DISPLAY", None)
        run(["sway", "--validate", "--config", str(dotfiles / ".config/sway/config")], env=environment)
    print("Shell, Lua, Python, TOML, Waybar JSON/CSS, Foot, and Sway checks passed.")


if __name__ == "__main__":
    main()
