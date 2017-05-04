Param (
    [switch]$Run,
    [Parameter(Mandatory=$true)][int]$Keep
)

Write-Host "CobianFolderDeleter v1.0" -ForegroundColor Green -BackgroundColor Black
Write-Host "https://github.com/frabnet/CobianFolderDeleter" -ForegroundColor Green -BackgroundColor Black

Write-Host "Folders to keep: $Keep"

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
    $deleted = 0
    ForEach ($folder in $aFolders) {
        If ( $folder -match "$name") {            
            $found++
            Write-Host -NoNewline "`t$($folder): "
            If ($found -gt $Keep) {                
                Write-Host "To delete"
                If ($Run) {
                    Remove-Item -Recurse -Force $folder         
                }
                $deleted++
            } Else {
                Write-Host "Ok $found"
            }
        }
    }
    Write-Host "`t$deleted folders deleted."
}
Write-Host "Done."

If (-Not $Run) {
    Write-Host "No folder were deleted." -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "To really delete folders, please run with -Run switch" -ForegroundColor Yellow -BackgroundColor Black
}