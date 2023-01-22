# If folder name contains unsupported characters script must be run again to rename files inside renamed folder
# Import: Import-Module C:\Temp\OneDriveRename.ps1
# Check: OneDriveCheck -folder <path>
# Fix: OneDriveCheck -folder <path> -fix

function OneDriveRename($Folder,[switch]$Fix) {
    $items = Get-ChildItem -Path $Folder -Recurse

    $UnsupportedChars = "[^a-zA-Z0-9ąćęłńóśźżĄĆĘŁŃÓŚŹŻ ()@_=+.,';[\]\-]"
    $UnsupportedWords = "(?i)(\b(\b(CON|PRN|AUX|NUL|COM[0-9]|LPT[0-9])\b|(desktop.ini|\.lock)\b))"
    $UnsupportedVTI = "(?i)(_vti_)"

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
	    elseif ( $item.Name -match $UnsupportedWords ) {
            $newFileName = $item.Name
            Write-Host "$($item.FullName) has invalid word!" -ForegroundColor Red

            if ( $Fix ) {
                $newFileName = (( $item.PSChildName ) -creplace $UnsupportedWords,"_$($item.Name)" )
                Rename-Item $item.FullName -newname ($newFileName)            
                Write-Host "$($item.Name) has been changed to $newFileName" -ForegroundColor Green
            }           
        }
        elseif ( $item.Name -match $UnsupportedVTI ) {
            $newFileName = $item.Name
            Write-Host "$($item.FullName) has invalid fragment!" -ForegroundColor Red

            if ( $Fix ) {
                $newFileName = (( $item.PSChildName ) -creplace $UnsupportedVTI,"ti" )
                Rename-Item $item.FullName -newname ($newFileName)            
                Write-Host "$($item.Name) has been changed to $newFileName" -ForegroundColor Green
            }           
        }
    }
}