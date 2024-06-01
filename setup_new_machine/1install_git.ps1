# Set the URL for the Git installer
$installerUrl = "https://github.com/git-for-windows/git/releases/download/v2.45.1.windows.1/Git-2.45.1-64-bit.exe"

# Set the path where the installer will be downloaded
$installerPath = "$env:USERPROFILE\Downloads\GitSetup.exe"

# Function to download the installer with retry logic
function Download-File {
    param (
        [string]$url,
        [string]$outputPath,
        [int]$maxRetries = 3
    )

    $attempt = 0
    $success = $false

    while (-not $success -and $attempt -lt $maxRetries) {
        try {
            $attempt++
            Write-Host ("Attempt {0}: Downloading {1}" -f $attempt, $url)
            Invoke-WebRequest -Uri $url -OutFile $outputPath -ErrorAction Stop
            $success = $true
            Write-Host "Download successful."
        } catch {
            Write-Host ("Attempt {0} failed: {1}" -f $attempt, $_)
            if ($attempt -lt $maxRetries) {
                Write-Host "Retrying..."
            } else {
                Write-Host "Exceeded maximum retry attempts. Exiting."
                exit 1
            }
        }
    }
}

# Download the installer
Download-File -url $installerUrl -outputPath $installerPath

# Check if the download was successful
if (Test-Path -Path $installerPath) {
    Write-Host "Download complete. Installing Git..."

    # Execute the installer silently
    Start-Process -FilePath $installerPath -ArgumentList "/VERYSILENT", "/NORESTART" -NoNewWindow -Wait

    # Verify the installation
    $gitPath = "C:\Program Files\Git\bin\git.exe"
    if (Test-Path -Path $gitPath) {
        Write-Host "Git installed successfully."
    } else {
        Write-Host "Installation failed. Please check the installer and try again."
    }

    # Clean up the installer file
    Remove-Item -Path $installerPath -Force
} else {
    Write-Host "Download failed. Please check your internet connection and try again."
}
