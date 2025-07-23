# install.ps1 – Nosebleed installer with folder picker

Add-Type -AssemblyName System.Windows.Forms

# Let user select installation folder
$dialog = New-Object System.Windows.Forms.FolderBrowserDialog
$dialog.Description = "Select a folder to install Nosebleed"
$dialog.ShowNewFolderButton = $true

if ($dialog.ShowDialog() -ne "OK") {
    Write-Host "❌ Installation cancelled."
    exit
}

$dir = $dialog.SelectedPath

# Download Nosebleed executable (change URL as needed)
$url = "https://github.com/LOVJOVI/Nosebleed/releases/latest/download/Nosebleed.exe"
$exePath = Join-Path $dir "Nosebleed.exe"

Write-Host "⬇ Downloading Nosebleed.exe to $exePath ..."
try {
    Invoke-WebRequest -Uri $url -OutFile $exePath -UseBasicParsing
    Write-Host "✅ Download complete."
} catch {
    Write-Host "❌ Download failed: $_"
    exit 1
}

# Add install folder to PATH if not already present
$envPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if ($envPath -notlike "*$dir*") {
    [Environment]::SetEnvironmentVariable("PATH", "$envPath;$dir", "User")
    Write-Host "✅ Nosebleed folder added to PATH (user-level). Restart terminal to use 'nosebleed'."
} else {
    Write-Host "ℹ Nosebleed folder is already in PATH."
}

Write-Host "`n✅ Nosebleed successfully installed to: $dir"
