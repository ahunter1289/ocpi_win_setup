# Define the user profile directory
$userProfile = "C:\Users\<your user profile folder name here>\"

# Version 3.9.13
New-Alias py "$userProfile\AppData\Local\Programs\Python\Python39\python.exe"
New-Alias python "$userProfile\AppData\Local\Programs\Python\Python39\python.exe"
New-Alias python3 "$userProfile\AppData\Local\Programs\Python\Python39\python.exe"

New-Alias activateocpinb "$userProfile\Documents\code\python_envs\win39ocpinbdev\Scripts\Activate.ps1"

function openps {
    code "$userProfile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
}

function openocpinbws {
    code "$userProfile\Documents\code\vscode_workspaces\win39ocpinbdev.code-workspace"
}
