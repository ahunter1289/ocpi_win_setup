# Start of master script
Write-Host "Master script started."

# Set policy to allow running scripts
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Get the current working directory
$pwd = Get-Location

# Run Script 1
Write-Host "Running Script 1..."
.\1install_git.ps1
Write-Host "Script 1 completed."

# Reset working directory to the original
Set-Location $pwd

# Run Script 2
Write-Host "Running Script 2 w/ Admin Priveleges..."
.\2add_git_to_path.ps1
Write-Host "Script 2 completed."

# Reset working directory to the original
Set-Location $pwd

# Run Script 3
Write-Host "Running Script 3..."
.\3initialize_git.ps1
Write-Host "Script 3 completed."

# Reset working directory to the original
Set-Location $pwd

# Run Script 4
Write-Host "Running Script 4..."
.\4install_vscode.ps1
Write-Host "Script 4 completed."

# Reset working directory to the original
Set-Location $pwd

# Run Script 5
Write-Host "Running Script 5..."
.\5download_install_python_3_9_13.ps1
Write-Host "Script 5 completed."

# Reset working directory to the original
Set-Location $pwd

# Run Script 6
Write-Host "Running Script 6..."
.\6create_code_folder_and_clone_repos.ps1
Write-Host "Script 6 completed."

# Reset working directory to the original
Set-Location $pwd

# Run Script 7
Write-Host "Running Script 7..."
.\7copy_windows_powershell.ps1
Write-Host "Script 7 completed."

# Reset working directory to the original
Set-Location $pwd

# Run Script 8
Write-Host "Running Script 8..."
.\8create_python_venv.ps1
Write-Host "Script 8 completed."

# Reset working directory to the original
Set-Location $pwd

# Run Script 9
Write-Host "Running Script 9..."
.\9create_vscode_ws.ps1
Write-Host "Script 9 completed."

# Reset working directory to the original
Set-Location $pwd

# End of master script
Write-Host "Master script completed."
Write-Host "------ Restart powershell for changes to take effect ------"
