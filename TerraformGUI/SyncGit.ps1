# Get GitHub Repository Archive
# Change SecurityProtocol for downloading from GitHub
$SavedSecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol
[System.Net.ServicePointManager]::SecurityProtocol = 'Tls,Tls11,Tls12'
Try {
    $Branch = 'main'
    $UrlDownload = "https://github.com/ClearMediaNV/Terraform/archive/$Branch.zip"
    $FileDownload = "$ENV:LOCALAPPDATA\$Branch.zip"
    $FolderDownload = "$ENV:LOCALAPPDATA\$Branch"
    # Download Archive
    (New-Object System.Net.WebClient).downloadFile($UrlDownload,$FileDownload)
    # Unzip Archive to Folder Download
    [VOID][System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem")
    [System.IO.Compression.ZipFile]::ExtractToDirectory($FileDownload, "$FolderDownload") 
    Push-Location -Path "$ENV:USERPROFILE\Documents"
    New-Item -Name 'TerraformGUI' -ItemType Directory -Force
    Copy-Item -Path "$FolderDownload\Terraform-$Branch\TerraformGUI\*" -Destination 'TerraformGUI' -Recurse -Force
    # Cleanup File & Folder Download
    Remove-Item -Path "$FileDownload" -Force
    Remove-Item -Path "$FolderDownload" -Recurse -Force
    }
   Catch {
         Write-Output 'GitHub Connection Error. Please Check DNS & Gateway Config. Please Check https://github.com/ClearMediaNV'
         Start-Sleep -Seconds 5
         }
# Restore Saved SecurityProtocol
[System.Net.ServicePointManager]::SecurityProtocol = $SavedSecurityProtocol
# The End
