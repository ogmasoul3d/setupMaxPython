if (Test-Path -Path ".\maxversion.txt") {
    $maxV = Get-Content .\maxversion.txt
    write-host "Found maxversion:" $maxV "in maxversion.txt"
    $maxName = $maxV
} else {
    $maxName = 2021
}

write-host "$PSScriptRoot\tjosan.txt"