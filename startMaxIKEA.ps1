<#
    .DESCRIPTION
    setup pip with the 3dsmax python install

    .PARAMETER maxVersion
    #3dsmax 2022 == 24.0
    #3dsmax 2021 == 23.0
    #3dsmax 2020 == 22.0
    #3dsmax 2019 == 21.0
#> 

$maxName = 2022

# the ID used in regedit is based in name of max - the year 1998
$maxVersion = $maxName - 1998

#this gets the max install path on your machine
$InstallPath = Get-ItemProperty -Path HKLM:\SOFTWARE\Autodesk\3dsMax\*$maxVersion*\

#!!!! this can sometimes return an array or somtimes just a string.. WATCH out.. this can bite you.
if ($InstallPath.Installdir -is [array]){
    $3dsMaxLocation = $InstallPath.Installdir[0]
} else {
    $3dsMaxLocation = $InstallPath.Installdir
}


if (Test-Connection -TargetName comseelm-nt9100.ikea.com -Quiet) {
    if ($3dsMaxLocation){
        if (Test-Path -Path "./venv") {
            write-host " [*] found venv installation in this folder"  -ForegroundColor Green
            Write-Host " [*] activate venv_3dsmax"  -ForegroundColor Green
            & ".\venv\Scripts\activate" /run 

            Write-Host " [*] start max with this virtualEnv active"  -ForegroundColor Green
            write-Host " max location: $3dsMaxLocation\3dsmax.exe" -ForegroundColor Yellow
            & "$3dsMaxLocation\3dsmax.exe" /run 
        } else {
            Write-Host "you have not setup a Venv here.. do this before running this script" -ForegroundColor Red
        }
    } else {
        Write-Host "Could not find any max installed.. have you setup the correct maxversion to search for.. It can be changed in the top of this script" -ForegroundColor Red
    }
} else {
    Write-Host "cannot activate since you have not started Cisco VPN connection"

}