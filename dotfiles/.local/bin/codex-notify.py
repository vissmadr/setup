#!/usr/bin/env python3
"""Notify on completed Codex turns unless its project terminal has focus."""

import json
import os
from pathlib import Path
import subprocess
import sys


def focused_pid(node):
    if node.get("focused") and node.get("pid"):
        return node["pid"]
    for child in node.get("nodes", []) + node.get("floating_nodes", []):
        pid = focused_pid(child)
        if pid:
            return pid
    return None


def project_has_focus(tree, cwd, proc=Path("/proc")):
    window = focused_pid(tree)
    if not window or not cwd:
        return False
    processes = {}
    for entry in proc.iterdir():
        if not entry.name.isdigit():
            continue
        try:
            # comm can contain spaces/parentheses; split after its closing ')'.
            status = (entry / "stat").read_text().rsplit(")", 1)[1].split()
            processes[int(entry.name)] = int(status[1])
        except (OSError, IndexError, ValueError):
            continue
    for pid in processes:
        try:
            if (proc / str(pid) / "comm").read_text().strip() != "codex":
                continue
            if (proc / str(pid) / "cwd").resolve() != Path(cwd).resolve():
                continue
        except OSError:
            continue
        seen = set()
        while pid and pid not in seen:
            if pid == window:
                return True
            seen.add(pid)
            pid = processes.get(pid)
    return False


def main():
    event = json.loads(sys.argv[1])
    if event.get("type") != "agent-turn-complete":
        return
    cwd = event.get("cwd", "")
    if os.environ.get("SWAYSOCK"):
        try:
            result = subprocess.run(
                ["swaymsg", "-t", "get_tree", "-r"], capture_output=True, text=True, check=True, timeout=2,
            )
            if project_has_focus(json.loads(result.stdout), cwd):
                return
        except (OSError, subprocess.SubprocessError, ValueError):
            pass  # If focus cannot be checked, still deliver the completion.
    project = Path(cwd).name or "Codex"
    subprocess.run(
        ["notify-send", "--app-name=codex", "--expire-time=2400", "--",
         f"Codex ({project})", "Codex finished work"], check=True,
    )


if __name__ == "__main__":
    main()
