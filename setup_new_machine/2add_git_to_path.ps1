# Define the directories to add to the PATH
$directoriesToAdd = @(
    "C:\Program Files\Git\bin\",
    "C:\Program Files\Git\cmd\"
)

# Get the current value of the PATH environment variable
$currentPath = [System.Environment]::GetEnvironmentVariable("PATH", "User")

# Split the current PATH into an array of directory paths
$pathArray = $currentPath -split ";"

# Loop through the directories to add
foreach ($directoryToAdd in $directoriesToAdd) {
    # Check if the directory is already in the PATH
    if ($pathArray -contains $directoryToAdd) {
        Write-Host "Directory '$directoryToAdd' is already in the PATH."
    } else {
        # Append the directory to the PATH with a semicolon separator
        $currentPath += ";$directoryToAdd"
        Write-Host "Directory '$directoryToAdd' added to the PATH."
    }
}

# Set the updated PATH environment variable
[System.Environment]::SetEnvironmentVariable("PATH", $currentPath, "User")

# Reload the PATH environment variable in the current PowerShell session
$env:Path = [System.Environment]::GetEnvironmentVariable("PATH", "User")