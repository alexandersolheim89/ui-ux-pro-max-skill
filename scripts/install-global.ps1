# Install the ui-ux-pro-max Claude Code skill from this repository checkout
# into ~/.claude/skills/ so it is available in every project on this machine.
#
# Usage:
#   scripts\install-global.ps1             # install / update
#   scripts\install-global.ps1 -Uninstall  # remove the global skill
#
# Respects CLAUDE_CONFIG_DIR if set (defaults to ~/.claude).
param(
    [switch]$Uninstall
)

$ErrorActionPreference = 'Stop'

$RepoRoot = Split-Path -Parent $PSScriptRoot
$Src = Join-Path $RepoRoot '.claude/skills/ui-ux-pro-max'
$ConfigDir = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $HOME '.claude' }
$DestRoot = Join-Path $ConfigDir 'skills'
$Dest = Join-Path $DestRoot 'ui-ux-pro-max'

if ($Uninstall) {
    if (Test-Path $Dest) {
        Remove-Item -Recurse -Force $Dest
        Write-Host "Removed $Dest"
    } else {
        Write-Host "Nothing to remove at $Dest"
    }
    exit 0
}

if (-not (Test-Path (Join-Path $Src 'SKILL.md'))) {
    Write-Error "error: $Src\SKILL.md not found - run this script from a full repo checkout"
}

New-Item -ItemType Directory -Force -Path $DestRoot | Out-Null
if (Test-Path $Dest) { Remove-Item -Recurse -Force $Dest }
Copy-Item -Recurse $Src $Dest

# The in-repo SKILL.md addresses search.py via ${CLAUDE_PLUGIN_ROOT}, which is
# only set for Claude Marketplace plugin installs. For a personal skill in
# ~/.claude/skills/ that variable is empty, so rewrite the references to the
# installed location (forward slashes work for python on Windows too).
$SkillFile = Join-Path $Dest 'SKILL.md'
$DestForward = ($Dest -replace '\\', '/')
$Content = (Get-Content $SkillFile -Raw).Replace('${CLAUDE_PLUGIN_ROOT}/.claude/skills/ui-ux-pro-max', $DestForward)
Set-Content -Path $SkillFile -Value $Content -NoNewline

if ((Get-Content $SkillFile -Raw) -match 'CLAUDE_PLUGIN_ROOT') {
    Write-Error "error: failed to rewrite all CLAUDE_PLUGIN_ROOT references in $SkillFile (the path pattern in .claude/skills/ui-ux-pro-max/SKILL.md may have changed)"
}

Write-Host "Installed ui-ux-pro-max skill to $Dest"
Write-Host "It is now available in every project. Re-run this script after pulling updates."
