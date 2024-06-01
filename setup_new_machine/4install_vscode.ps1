# Get list of user profiles from the Users directory
$userProfiles = Get-ChildItem "C:\Users" | Where-Object { $_.PSIsContainer } | Select-Object -ExpandProperty Name

# Prompt user to select a profile from the list
Write-Host "Please select a user profile from the following list:"
$userProfiles | ForEach-Object { Write-Host "$($_)" }
# Set the URL for the Visual Studio Code installer
$installerUrl = "https://update.code.visualstudio.com/latest/win32-x64-user/stable"

# Set the path where the installer will be downloaded
$installerPath = "$env:USERPROFILE\Downloads\VSCodeSetup.exe"

# Download the installer
Write-Host "Downloading Visual Studio Code installer..."
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

# Check if the download was successful
if (Test-Path -Path $installerPath) {
    Write-Host "Download complete. Installing Visual Studio Code..."

    # Execute the installer silently
    Start-Process -FilePath $installerPath -ArgumentList "/silent", "/mergetasks=!runcode" -NoNewWindow -Wait

    # Verify the installation
    if (Test-Path -Path "C:\Users\$env:USERNAME\AppData\Local\Programs\Microsoft VS Code\Code.exe") {
        Write-Host "Visual Studio Code installed successfully."
    } else {
        Write-Host "Installation failed. Please check the installer and try again."
    }

    # Clean up the installer file
    Remove-Item -Path $installerPath -Force
} else {
    Write-Host "Download failed. Please check your internet connection and try again."
}