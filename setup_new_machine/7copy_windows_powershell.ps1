# Get list of user profiles from the Users directory
$userProfiles = Get-ChildItem "C:\Users" | Where-Object { $_.PSIsContainer } | Select-Object -ExpandProperty Name

# Prompt user to select a profile from the list
Write-Host "Please select a user profile from the following list:"
$userProfiles | ForEach-Object { Write-Host "$($_)" }
$selectedProfile = Read-Host "Enter the user profile"

# Validate the selected profile
if ($userProfiles -contains $selectedProfile) {
    # Construct the path to the Documents folder for the selected profile
    $documentsPath = "C:\Users\$selectedProfile\Documents"
    $codeFolderPath = Join-Path -Path $documentsPath -ChildPath "code"
    $ocpiWinSetupPath = Join-Path -Path $codeFolderPath -ChildPath "ocpi_win_setup"

    # Check if the ocpi_win_setup repository exists
    if (-Not (Test-Path -Path $ocpiWinSetupPath)) {
        Write-Host "The 'ocpi_win_setup' repository does not exist. Please clone it first."
        exit 1
    }

    # Find the Microsoft.PowerShell_profile.ps1 file in the cloned repository
    $profilePath = Join-Path -Path $ocpiWinSetupPath -ChildPath "Microsoft.PowerShell_profile.ps1"
    if (-Not (Test-Path -Path $profilePath)) {
        Write-Host "The 'Microsoft.PowerShell_profile.ps1' file does not exist in the 'ocpi_win_setup' repository."
        exit 1
    }

    # Construct the path to the WindowsPowerShell folder in the selected user's profile
    $windowsPowerShellFolderPath = Join-Path -Path $documentsPath -ChildPath "WindowsPowerShell"
    if (-Not (Test-Path -Path $windowsPowerShellFolderPath)) {
        New-Item -Path $windowsPowerShellFolderPath -ItemType Directory
        Write-Host "Folder 'WindowsPowerShell' created successfully in $documentsPath"
    }

    # Copy the profile file to the WindowsPowerShell folder
    $destinationProfilePath = Join-Path -Path $windowsPowerShellFolderPath -ChildPath "Microsoft.PowerShell_profile.ps1"
    Copy-Item -Path $profilePath -Destination $destinationProfilePath

    # Read the content of the profile file
    $profileContent = Get-Content -Path $destinationProfilePath

    # Update the $userProfile variable definition with the selected location
    $updatedProfileContent = $profileContent -replace '^\s*\$userProfile\s*=.*$', "`$userProfile = 'C:\Users\$selectedProfile'"

    # Write the updated content back to the profile file
    Set-Content -Path $destinationProfilePath -Value $updatedProfileContent

    Write-Host "The 'Microsoft.PowerShell_profile.ps1' file has been copied and updated successfully."
} else {
    Write-Host "Invalid user profile selected. Please run the script again and select a valid profile."
}
