# Define the URL for the Python 3.9.13 installer
$installerUrl = "https://www.python.org/ftp/python/3.9.13/python-3.9.13-amd64.exe"

# Define the path where the installer will be downloaded
$installerPath = "$env:USERPROFILE\Downloads\python-3.9.13-amd64.exe"

# Define the installation directory
$installDir = "$env:LOCALAPPDATA\Programs\Python\Python39"

# Function to download the installer
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

# Check if Python is already installed
$pythonPath = Join-Path -Path $installDir -ChildPath "python.exe"
if (Test-Path -Path $pythonPath) {
    Write-Host "Python is already installed in '$installDir'."
} else {
    # Download the installer if not already downloaded
    if (-not (Test-Path -Path $installerPath)) {
        Download-File -url $installerUrl -outputPath $installerPath
    }

    # Check if the download was successful
    if (Test-Path -Path $installerPath) {
        Write-Host "Download complete. Installing Python 3.9.13..."

        # Execute the installer with custom installation directory
        $arguments = "/quiet InstallAllUsers=1 TargetDir=`"$installDir`""
        Write-Host "Executing installer with arguments: $arguments"
        Start-Process -FilePath $installerPath -ArgumentList $arguments -NoNewWindow -Wait

        # Verify the installation
        if (Test-Path -Path $pythonPath) {
            Write-Host "Python 3.9.13 installed successfully."
        } else {
            Write-Host "Installation failed. The Python executable was not found in the expected directory."
        }

        # Clean up the installer file
        Remove-Item -Path $installerPath -Force
    } else {
        Write-Host "Download failed. Please check your internet connection and try again."
    }
}