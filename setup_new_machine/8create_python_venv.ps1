# Get list of user profiles from the Users directory
$userProfiles = Get-ChildItem "C:\Users" | Where-Object { $_.PSIsContainer } | Select-Object -ExpandProperty Name

# Prompt user to select a profile from the list
Write-Host "Please select a user profile from the following list:"
$userProfiles | ForEach-Object { Write-Host "$($_)" }
$selectedUser = Read-Host "Enter the user profile"

# Validate the selected user profile
if ($userProfiles -contains $selectedUser) {
    # Construct the path to the user's Documents folder
    $userDocumentsPath = "C:\Users\$selectedUser\Documents"

    # Construct the path to the 'code' folder in the user's Documents directory
    $codeFolderPath = Join-Path -Path $userDocumentsPath -ChildPath "code"
    if (-not (Test-Path -Path $codeFolderPath)) {
        New-Item -Path $codeFolderPath -ItemType Directory
        Write-Host "Folder 'code' created successfully in $userDocumentsPath"
    }

    # Construct the path to the 'python_envs' folder in the 'code' folder
    $pythonEnvFolderPath = Join-Path -Path $codeFolderPath -ChildPath "python_envs"
    if (-not (Test-Path -Path $pythonEnvFolderPath)) {
        New-Item -Path $pythonEnvFolderPath -ItemType Directory
        Write-Host "Folder 'python_envs' created successfully in $codeFolderPath"
    }

    # Name of the virtual environment
    $venvName = "win39ocpinbdev"

    # Construct the path to the virtual environment
    $venvPath = Join-Path -Path $pythonEnvFolderPath -ChildPath $venvName

    # Check if the virtual environment already exists
    if (-not (Test-Path -Path $venvPath)) {
        # Create the virtual environment
        Write-Host "Creating virtual environment '$venvName'..."
        python -m venv $venvPath

        # Activate the virtual environment
        Write-Host "Activating virtual environment '$venvName'..."
        & $venvPath\Scripts\Activate.ps1

        # Define the path to the requirements file
        $requirementsFile = Join-Path -Path $userDocumentsPath -ChildPath "code\ocpi_win_setup\win39_ocpinb_latest_dev_loose_requirements_5_31_2024.txt"

        # Check if requirements file exists
        if (Test-Path -Path $requirementsFile) {
            # Copy the requirements file into the virtual environment folder
            $destinationFile = Join-Path -Path $venvPath -ChildPath "original_env_requirements.txt"
            Copy-Item -Path $requirementsFile -Destination $destinationFile

            # Make edits to the requirements file
            $userFolderName = $selectedUser
            (Get-Content -Path $destinationFile) | ForEach-Object { $_ -replace '<your user profile folder name here>', $userFolderName } | Set-Content -Path $destinationFile

            # Install requirements using pip
            Write-Host "Installing requirements from '$destinationFile'..."
            pip install -r $destinationFile
        } else {
            Write-Host "Requirements file not found: $requirementsFile"
        }
    } else {
        Write-Host "Virtual environment '$venvName' already exists at: $venvPath"
    }
} else {
    Write-Host "Invalid user profile selected. Please run the script again and select a valid profile."
}
