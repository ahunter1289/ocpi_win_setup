# Check if winget is installed
if (-Not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Output "winget is not installed. Please install it from the Microsoft Store."
    Exit
}

# Install Windows Terminal using winget
winget install --id Microsoft.WindowsTerminal -e