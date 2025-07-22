# install-bbunnyy.ps1
# Simple installer for Bbunnyy.exe from GitHub

$url = "https://github.com/LOVJOVI/Bbunnyy/releases/download/BbunnyyReleases/Bbunnyy.exe"
$dir = "$env:USERPROFILE\Bbunnyy"

# Create install directory
New-Item -ItemType Directory -Path $dir -Force | Out-Null

# Download the executable
Invoke-WebRequest -Uri $url -OutFile "$dir\Bbunnyy.exe"

# Add to PATH if not already added
$path = [Environment]::GetEnvironmentVariable("PATH", "User")
if ($path -notlike "*$dir*") {
    [Environment]::SetEnvironmentVariable("PATH", "$path;$dir", "User")
    Write-Host "✔ Bbunnyy folder added to PATH. Restart your terminal to use it."
}

Write-Host "✔ Bbunnyy installed to: $dir"
