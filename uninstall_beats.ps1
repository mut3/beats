# Remove Elastic Beats collectors from a Windows system
# Set some default values
$install_dir = "C:\Program Files\Elastic"
$filebeat_dir = "$install_dir\filebeat\"
$winlogbeat_dir = "$install_dir\winlogbeat\"
$topbeat_dir = "$install_dir\topbeat\"

# Run service uninstall scripts
PowerShell.exe -ExecutionPolicy UnRestricted -File "$filebeat_dir\uninstall-service-filebeat.ps1"
PowerShell.exe -ExecutionPolicy UnRestricted -File "$winlogbeat_dir\uninstall-service-winlogbeat.ps1"
PowerShell.exe -ExecutionPolicy UnRestricted -File "$topbeat_dir\uninstall-service-topbeat.ps1"

# clear install directory
rm "$install_dir"