#!/bin/bash
# Reset a spare laptop's working tree to a clean state for the next candidate.
#
# Usage: ./scripts/reset_backup_laptop.sh CANDIDATE-07
#
# What it does:
#   1. Copies the current working tree to ../CANDIDATE-07/ (outside the repo),
#      so the previous candidate's work is preserved for review.
#   2. Restores a clean state with git reset --hard and git clean -fdx.
#
# Run this from the repo root. It does NOT push anything.

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <CANDIDATE-NUMBER>" >&2
    echo "Example: $0 CANDIDATE-07" >&2
    exit 1
fi

CANDIDATE="$1"
REPO_ROOT="$(git rev-parse --show-toplevel)"
BACKUP_DIR="${REPO_ROOT}/../${CANDIDATE}"

if [ -d "$BACKUP_DIR" ]; then
    echo "Backup target already exists: $BACKUP_DIR" >&2
    echo "Move or remove it first, then rerun." >&2
    exit 1
fi

echo "Copying working tree to $BACKUP_DIR ..."
# Copy the working tree (including untracked/ignored files) for review.
mkdir -p "$BACKUP_DIR"
# --archive preserves permissions; we copy everything except .git to keep it light.
rsync -a --exclude='.git' "$REPO_ROOT/" "$BACKUP_DIR/" 2>/dev/null || {
    # Fallback if rsync is unavailable.
    echo "rsync not found, falling back to cp ..."
    cp -a "$REPO_ROOT/." "$BACKUP_DIR/"
    rm -rf "$BACKUP_DIR/.git"
}

echo "Resetting repo to a clean state ..."
git reset --hard
git clean -fdx

echo "Done. Backup saved at $BACKUP_DIR. Repo is clean and ready for the next candidate."
