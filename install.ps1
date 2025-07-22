# install.ps1 – Bbunnyy installer with folder picker

Add-Type -AssemblyName System.Windows.Forms

# Let user select installation folder
$dialog = New-Object System.Windows.Forms.FolderBrowserDialog
$dialog.Description = "Select a folder to install Bbunnyy"
$dialog.ShowNewFolderButton = $true

if ($dialog.ShowDialog() -ne "OK") {
    Write-Host "❌ Installation cancelled."
    exit
}

$dir = $dialog.SelectedPath

# Download Bbunnyy.exe
$url = "https://github.com/LOVJOVI/Bbunnyy/releases/download/BbunnyyReleases/Bbunnyy.exe"
$exePath = Join-Path $dir "Bbunnyy.exe"

Write-Host "⬇ Downloading Bbunnyy.exe to $exePath ..."
Invoke-WebRequest -Uri $url -OutFile $exePath

# Add install folder to PATH if not already
$envPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if ($envPath -notlike "*$dir*") {
    [Environment]::SetEnvironmentVariable("PATH", "$envPath;$dir", "User")
    Write-Host "✅ Bbunnyy folder added to PATH (user-level). Restart terminal to use 'Bbunnyy'."
} else {
    Write-Host "ℹ Bbunnyy folder is already in PATH."
}

Write-Host "`n✅ Bbunnyy successfully installed to: $dir"
