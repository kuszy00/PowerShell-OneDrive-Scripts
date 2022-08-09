Import-Module C:\Temp\OneDriveLib.dll
Get-ODStatus -Type Business1 | Out-File -FilePath c:\temp\StatusOD.txt

$name = Get-Content c:\temp\StatusOD.txt | Select -First 5 | Select -Last 1
$name.split([Environment]::NewLine) | ForEach-Object {
    $userName = $_.Split(":")[1]
    $userName = $userName.Split("\")[1]
}

$status = Get-Content c:\temp\StatusOD.txt | Select -First 8 | Select -Last 1
$status.split([Environment]::NewLine) | ForEach-Object {
    $userStatus = $_.Split(":")[1]
}

$userName + ';' + $userStatus | Out-File -FilePath "c:\temp\StatusOneDrive\$($userName)_$(Get-Date -Format "yyyyMMdd_HHmmss").txt"

Remove-Item -Path c:\temp\StatusOD.txt
