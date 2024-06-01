# ocpi_win_setup

## Setup New OCPI Lab Computer

The folder titled "setup_new_machine" contains a series of powershell scripts that can be used to do the following

- Download git and initialize it
- Install vscode
- Install python 3.9
- Create code folder and clone repos: data_analysis, laserlab, and winsetup
- Copy the powershell template that has handy commands
- Create a python venv for ocpinotebooks with all the required packages
- Create a vscodeworkspace

### Using the Scripts
1. Download the repo zip file
2. Extract the files in the setup_new_machine folder
3. Copy these files to clipboard
4. Navigate to ocpi lab computer location C:/Users/ocpi/Documents/WindowsPowershell (create the WindowsPowershell folder if it doesnt already exist)
5. Open a powershell terminal - do not do this with Admin priveleges
6. Run this code powershell "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser"
7. Navigate to the above folder and run 0master.ps1
8. Note there are several prompts that you will need to answer
9. After the scripts finish, delete all the scripts you just copied EXCEPT "Microsoft.PowerShell_profile.ps1"

## Some lessons learned about these scripts
- When set the paths Git/cmd and Git/bin, this should be set for the "User" and not "Machine"
- When cloning github repos froms powershell with admin priveleges, it causeed issues - be careful doing things with admin, can cause problems
