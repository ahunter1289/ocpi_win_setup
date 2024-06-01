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

    # Construct the path to the 'vscode_workspaces' folder in the 'code' folder
    $workspaceFolderPath = Join-Path -Path $codeFolderPath -ChildPath "vscode_workspaces"
    if (-not (Test-Path -Path $workspaceFolderPath)) {
        New-Item -Path $workspaceFolderPath -ItemType Directory
        Write-Host "Folder 'vscode_workspaces' created successfully in $codeFolderPath"
    }

    # Define the name for the workspace
    $workspaceName = "win39ocpinbdev"

    # Construct the path to the new Visual Studio Code workspace file
    $workspaceFileName = "$workspaceName.code-workspace"
    $workspaceFilePath = Join-Path -Path $workspaceFolderPath -ChildPath $workspaceFileName

    # Prompt the user to input folders for the workspace
    $selectedFolders = @()
    $inputFolder = ""
    while ($inputFolder -ne "done") {
        $inputFolder = Read-Host "Enter the path of a folder you want to add to the workspace (e.g., G:\Shared drives\OCPI\Lab\ocpi_notebooks\ocpi_notebooks), or type 'done' to finish"
        if ($inputFolder -ne "done") {
            # Replace backslashes with forward slashes
            $inputFolder = $inputFolder -replace '\\', '/'
            $selectedFolders += $inputFolder
        }
    }

    # Create the content for the workspace file
    $foldersContent = $selectedFolders | ForEach-Object {
        @"
        {
            "path": "$_"
        },
"@
    }

    $workspaceContent = @"
{
    "folders": [
$foldersContent
    ],
    "settings": {}
}
"@

    # Write the content to the workspace file
    Set-Content -Path $workspaceFilePath -Value $workspaceContent

    Write-Host "Visual Studio Code workspace '$workspaceName' created successfully at: $workspaceFilePath"
} else {
    Write-Host "Invalid user profile selected. Please run the script again and select a valid profile."
}
