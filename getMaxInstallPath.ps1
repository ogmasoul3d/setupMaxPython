Function Test-CommandExists {
    Param ($command)
    $oldPreference = $ErrorActionPreference
    $ErrorActionPreference = ‘stop’
    try {if(Get-Command $command){RETURN $true}}
    Catch {Write-Host “$command does not exist”; RETURN $false}
    Finally {$ErrorActionPreference=$oldPreference}
} #end function test-CommandExists

#3dsmax 2022 == 24.0
#3dsmax 2021 == 23.0
#3dsmax 2020 == 22.0
#3dsmax 2019 == 21.0
$maxVersion = 23.0

#this is the correct python folder for max 2021 and 2022
$3dsmaxPythonVersion = "Python37"

#this gets the max install path on your machine
$InstallPath = Get-ItemProperty -Path HKLM:\SOFTWARE\Autodesk\3dsMax\*$maxVersion*\
Write-Host ("you max is installed here: " + $InstallPath.Installdir)

$PythonFolder = $InstallPath.Installdir[0] + $3dsmaxPythonVersion


"Test if folder [$PythonFolder] exists"
if (Test-Path -Path $PythonFolder) {
    "Path exists!"
    $cmd = $PythonFolder+"\python.exe"
    $cmd = "pip -V"
    Write-Host $cmd
    Test-CommandExists $cmd

    
} else {
    "Path doesn't exist."
}