###### Create user account ######
# Define the username and password
$username = "andrewhunter"
$password = "password1234"

# Convert the password to a secure string
$securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force

# Create the user account
New-LocalUser -Name $username -Password $securePassword -FullName $username -Description "User account for $username"

# Add the user to the Administrators group
Add-LocalGroupMember -Group "Administrators" -Member $username

###### Download Software ######

# Google chrome
# vscode
# git
# notepad++


###### Make a copy of the powershell script to the following location ######

# C:\Users<USER>\OneDrive\Documents\WindowsPowerShell

###### Setup python environments and SSH keys ########

###### Pull swdev repos #######
