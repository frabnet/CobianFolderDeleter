$maxCopies = 3
$dryRun = $true

Write-Host -NoNewLine "Reading folders... "
$aFolders = Get-ChildItem '.\' -Directory | Sort-Object Name -Descending
Write-Host "$($aFolders.length) folders found."

Write-Host -NoNewLine "Finding unique folders... "
$aUniqueNames = @()
ForEach ($folder in $aFolders) {
    $Split = $folder -Split " "
    $NameOnly = [string]$Split[0..($Split.count-2)] -Join " "
    $aUniqueNames += $NameOnly
}
$aUniqueNames = $aUniqueNames | Get-Unique
Write-Host "$($aUniqueNames.length) folders found."

ForEach ($name in $aUniqueNames) {
    Write-Host "Processing folder: $name"
    $found = 0     
    ForEach ($folder in $aFolders) {
        If ( $folder -match "$name") {            
            $found++
            Write-Host -NoNewline "`t$($folder): "
            If ($found -gt $maxCopies) {                
                If ($dryRun) {
                    Write-Host "Delete (no action taken, Dryrun is set) "           
                } else {
                    Write-Host "Delete"
                    Remove-Item -Recurse -Force $folder
                }
            } Else {
                Write-Host "Ok $found"
            }
        }
    }
}
Write-Host "Done."