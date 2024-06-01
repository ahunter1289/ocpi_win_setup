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

    # Create the 'code' folder in the Documents directory
    $codeFolderPath = Join-Path -Path $documentsPath -ChildPath "code"
    if (-Not (Test-Path -Path $codeFolderPath)) {
        New-Item -Path $codeFolderPath -ItemType Directory
        Write-Host "Folder 'code' created successfully in $documentsPath"
    } else {
        Write-Host "The folder 'code' already exists in $documentsPath"
    }

    # Create subfolders within the 'code' folder
    $subfolders = @("python_envs", "envs_reqs", "vscode_workspaces")
    foreach ($subfolder in $subfolders) {
        $subfolderPath = Join-Path -Path $codeFolderPath -ChildPath $subfolder
        if (-Not (Test-Path -Path $subfolderPath)) {
            New-Item -Path $subfolderPath -ItemType Directory
            Write-Host "Subfolder '$subfolder' created successfully in $codeFolderPath"
        } else {
            Write-Host "Subfolder '$subfolder' already exists in $codeFolderPath"
        }
    }

    # Change current directory to the 'code' folder
    Set-Location -Path $codeFolderPath

    # Clone repositories into the 'code' folder
    $repositories = @(
        "https://github.com/ucsb/data_analysis.git",
        "https://github.com/ucsb/laserlab.git",
        "https://github.com/ahunter1289/ocpi_win_setup.git"
    )
    foreach ($repo in $repositories) {
        $repoName = $repo.Split("/")[-1].Replace(".git", "")
        $repoPath = Join-Path -Path $codeFolderPath -ChildPath $repoName
        if (-Not (Test-Path -Path $repoPath)) {
            Write-Host "Cloning repository '$repo' into $repoPath..."
            git clone $repo $repoPath
            Write-Host "Repository cloned successfully."
        } else {
            Write-Host "Repository '$repoName' already exists in $codeFolderPath"
        }
    }
} else {
    Write-Host "Invalid user profile selected. Please run the script again and select a valid profile."
}
