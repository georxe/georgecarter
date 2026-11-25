# Reset a spare laptop's working tree to a clean state for the next candidate.
#
# Usage: .\scripts\reset_backup_laptop.ps1 CANDIDATE-07
#
# What it does:
#   1. Copies the current working tree to ..\CANDIDATE-07\ (outside the repo),
#      so the previous candidate's work is preserved for review.
#   2. Restores a clean state with git reset --hard and git clean -fdx.
#
# Run this from the repo root. It does NOT push anything.

param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Candidate
)

$ErrorActionPreference = "Stop"

$repoRoot = (git rev-parse --show-toplevel).Trim()
if (-not $repoRoot) {
    Write-Error "Not inside a git repository."
    exit 1
}

$backupDir = Join-Path (Split-Path $repoRoot -Parent) $Candidate

if (Test-Path $backupDir) {
    Write-Error "Backup target already exists: $backupDir`nMove or remove it first, then rerun."
    exit 1
}

Write-Host "Copying working tree to $backupDir ..."
New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
# Copy everything except .git to keep the backup light.
Get-ChildItem -Path $repoRoot -Force | Where-Object { $_.Name -ne ".git" } | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $backupDir -Recurse -Force
}

Write-Host "Resetting repo to a clean state ..."
git reset --hard
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
git clean -fdx
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "Done. Backup saved at $backupDir. Repo is clean and ready for the next candidate."
