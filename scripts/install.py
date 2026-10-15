#!/usr/bin/env python3
"""Preview or install this repository's dotfiles as backed-up symlinks."""

import argparse
from datetime import datetime
import os
from pathlib import Path
import shutil


REPOSITORY = Path(__file__).resolve().parents[1]


def entries():
    dotfiles = REPOSITORY / "dotfiles"
    yield dotfiles / ".bashrc", Path(".bashrc")
    yield dotfiles / ".gitconfig", Path(".gitconfig")
    for source in sorted((dotfiles / ".config").iterdir()):
        yield source, Path(".config") / source.name
    for source in sorted((dotfiles / ".local/bin").iterdir()):
        if source.is_file():
            yield source, Path(".local/bin") / source.name


def install(target, apply=False):
    target = target.expanduser().resolve()
    if target == REPOSITORY or target.is_relative_to(REPOSITORY):
        raise ValueError("the install target must be outside this repository")
    backup_root = target / ".local/state/setup/backups" / datetime.now().strftime("%Y%m%d-%H%M%S-%f")
    plan = []
    for source, relative in entries():
        destination = target / relative
        if destination.is_symlink() and destination.resolve() == source:
            print(f"Unchanged: {destination}")
            continue

        if destination.parent.resolve().is_relative_to(REPOSITORY):
            raise ValueError(f"destination parent points into this repository: {destination}")

        exists = os.path.lexists(destination)
        backup = backup_root / relative
        if exists:
            print(f"Backup: {destination} -> {backup}")
        print(f"Link: {destination} -> {source}")
        plan.append((source, destination, backup if exists else None))

    if apply:
        applied = []
        try:
            for source, destination, backup in plan:
                destination.parent.mkdir(parents=True, exist_ok=True)
                if backup:
                    backup.parent.mkdir(parents=True, exist_ok=True)
                    shutil.move(str(destination), str(backup))
                applied.append((destination, backup))
                destination.symlink_to(source, target_is_directory=source.is_dir())
        except (OSError, KeyboardInterrupt):
            for destination, backup in reversed(applied):
                destination.unlink(missing_ok=True)
                if backup:
                    shutil.move(str(backup), str(destination))
            raise
    print(f"{'Applied' if apply else 'Planned'} {len(plan)} changes.")
    if not apply:
        print("Preview only. Use --apply to install.")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apply", action="store_true", help="back up existing paths and install symlinks")
    parser.add_argument("--target", type=Path, default=Path.home(), help="home directory to install into")
    arguments = parser.parse_args()
    target = arguments.target.expanduser().resolve()
    try:
        install(target, arguments.apply)
    except (OSError, ValueError) as error:
        parser.exit(1, f"Installation failed: {error}\n")


if __name__ == "__main__":
    main()
