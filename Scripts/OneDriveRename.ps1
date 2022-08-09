# Import: Import-Module C:\Temp\OneDriveCheck.ps1
# Check: OneDriveCheck -folder <path>
# Fix: OneDriveCheck -folder <path> -fix

function OneDriveCheck($Folder,[switch]$Fix) {
    $items = Get-ChildItem -Path $Folder -Recurse

    $UnsupportedChars = "[^a-zA-Z0-9ąćęłńóśźżĄĆĘŁŃÓŚŹŻ ()@_=+.,';[\]\-]"

    ForEach ( $item in $items ) {
        if ( $item.Name -match $UnsupportedChars ) {
            $newFileName = $item.Name
            Write-Host "$($item.FullName) has invalid characters!" -ForegroundColor Red

            if ( $Fix ) {
                $newFileName = (( $item.PSChildName ) -creplace $UnsupportedChars,"" )
                Rename-Item $item.FullName -newname ($newFileName)            
                Write-Host "$($item.Name) has been changed to $newFileName" -ForegroundColor Green
            }           
        }
    }
}
