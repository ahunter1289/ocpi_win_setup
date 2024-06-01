# Set up Git configuration
Write-Host "Initializing Git configuration..."
git config --global user.name "ocpi.planck"
git config --global user.email "ocpi.computers.planck@gmail.com"

# Check Git configuration
Write-Host "Git configuration set up successfully."
Write-Host "Your global Git configuration:"
git config --global --list
