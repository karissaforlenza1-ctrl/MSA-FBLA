# MSA FBLA Auto-Publisher
# Watches the website folder and automatically pushes changes to GitHub Pages.
# Leave this window open while you work; minimize it if you like.
# Press Ctrl+C to stop.

$repo = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $repo

# Make sure git is reachable even from a fresh session
$gitCmd = "C:\Program Files\Git\cmd"
if (Test-Path $gitCmd) { $env:Path = "$gitCmd;$env:Path" }

Write-Host "==============================================" -ForegroundColor Cyan
Write-Host "  MSA FBLA Auto-Publisher" -ForegroundColor Cyan
Write-Host "  Watching for website changes..." -ForegroundColor Cyan
Write-Host "  Keep this window open. Ctrl+C to stop." -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan

function Publish-Site {
    git add -A | Out-Null
    $pending = git status --porcelain
    if (-not $pending) { return }
    $stamp = Get-Date -Format "yyyy-MM-dd h:mm tt"
    git commit -m "Website update $stamp" | Out-Null
    Write-Host "[$stamp] Changes found - publishing to live website..." -ForegroundColor Yellow
    $output = git push origin main 2>&1 | Out-String
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[$stamp] Done! Live in about 1-2 minutes: https://msa-fbla.github.io/MSA-FBLA/" -ForegroundColor Green
    } else {
        Write-Host "[$stamp] Push failed. Check your internet connection, then save again to retry." -ForegroundColor Red
        Write-Host $output -ForegroundColor DarkRed
    }
}

# Publish anything pending from before the watcher started
try { Publish-Site } catch { Write-Host "Publish error: $_" -ForegroundColor Red }

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $repo
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

$ignored = '\\.git\\|\\.zip$|Thumbs\.db|Desktop\.ini'
$script:lastRun = Get-Date
$script:pendingChange = $false

$action = {
    $path = $Event.SourceEventArgs.FullPath
    if ($path -match $ignored) { return }
    $script:pendingChange = $true
}

Register-ObjectEvent $watcher Changed -Action $action | Out-Null
Register-ObjectEvent $watcher Created -Action $action | Out-Null
Register-ObjectEvent $watcher Deleted -Action $action | Out-Null
Register-ObjectEvent $watcher Renamed -Action $action | Out-Null

# Check every 10 seconds; publish at most once per 15 seconds so bursts of saves batch together
while ($true) {
    Start-Sleep -Seconds 10
    if ($script:pendingChange -and ((Get-Date) - $script:lastRun).TotalSeconds -ge 15) {
        $script:pendingChange = $false
        $script:lastRun = Get-Date
        try { Publish-Site } catch { Write-Host "Publish error: $_" -ForegroundColor Red }
    }
}
