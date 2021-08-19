$Script:MyInvocation.MyCommand.Path
write-host (Get-Item $Script:MyInvocation.MyCommand.Path ).DirectoryName


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

#this is the correct python folder for max 2021 and 2022
$3dsmaxPythonVersion = "Python37"



#!!!! this can sometimes return an array or somtimes just a string.. WATCH out.. this can bite you.
if ($InstallPath.Installdir -is [array]){
    $3dsMaxLocation = $InstallPath.Installdir[0]
} else {
    $3dsMaxLocation = $InstallPath.Installdir
}

##check so python folder is not null..
if ($3dsMaxLocation) { 
    
    Write-Host "you max is installed here: $3dsMaxLocation"

    $PythonFolder = join-path $3dsMaxLocation $3dsmaxPythonVersion
    $env:PYTHONPATH=$PythonFolder
    
    Write-Host ("you python.exe is here: " + $PythonFolder )

    "Test if folder [$PythonFolder] exists"
    if (Test-Path -Path $PythonFolder) {
        "Python folder exists!"
        $pythonExe = Join-Path $PythonFolder "python.exe"

        Write-Host " [*] Setting up virtualenv in /venv folder.." -ForegroundColor Green
        $pyargs = @("-m", "venv" ,"venv")
        & $pythonExe $pyargs
    }
} else {
    "could not find a path to 3dsmax version $maxVersion"
}
