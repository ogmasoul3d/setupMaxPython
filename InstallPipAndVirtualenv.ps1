<#
    .DESCRIPTION
    python function to check if a module could be imported..

    this is python code since I could not get the pip-check to work from powershell
    since I needed to specify for a certain version of python (the one in max)


#>
$checkPipPythonCode=@"
import sys
import os
# calculate stuff


def module_exists(module_name):
    try:
        __import__(module_name)
    except ImportError:
        return $false
    else:
        return $true

print(module_exists('pip'))
"@

$checkPip = New-TemporaryFile
$checkPipPythonCode | Out-File  -Encoding "UTF8" $checkPip.FullName


function Test-CommandExists
{
	<#
	.SYNOPSIS
	Determines if the provided command exists.
	Returns true if exists, or false if it doesn't.
	.EXAMPLE
	PS C:\> Test_CommandExists cmd
	#>
	
	Param ($command)
	$oldPreference = $ErrorActionPreference
	$ErrorActionPreference = 'stop'
	# If the command exists, return boolean true
	try {if(Get-Command $command){RETURN $true}}
	# If the command fails to exist, return boolean false
	Catch {RETURN $false}
	Finally {$ErrorActionPreference=$oldPreference}
}

function New-TemporaryDirectory {
    $parent = [System.IO.Path]::GetTempPath()
    [string] $name = [System.Guid]::NewGuid()
    New-Item -ItemType Directory -Path (Join-Path $parent $name)
}

<#
    .DESCRIPTION
    setup pip with the 3dsmax python install

    .PARAMETER maxVersion
    #3dsmax 2022 == 24.0
    #3dsmax 2021 == 23.0
    #3dsmax 2020 == 22.0
    #3dsmax 2019 == 21.0
#> 

#update this row to the max version you are targeting
$maxName = 2021
#this is the correct python folder for max 2021 and 2022
$3dsmaxPythonVersion = "Python37"

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

        ## PYTHON
        if(Test-CommandExists "python")
        {
            # Pip already exists
            Write-Host " [*] Python already exists in PATH; " -ForegroundColor Green
            #python -m pip install --upgrade pip
            
        }
        else
        {
            # Pip doesn't exist so assume it needs installed
            Write-Host " [*] Need to setup python..." -ForegroundColor Green
            #(new-object System.Net.WebClient).DownloadFile('https://raw.github.com/pypa/pip/master/contrib/get-pip.py', 'c:\envs\get-pip.py')
            #python c:\envs\get-pip.py
            #v3-(Invoke-WebRequest https://raw.github.com/pypa/pip/master/contrib/get-pip.py).Content | python -
        }

        ## PIP
        $pipisInstalled = & $pythonExe $checkPip
        Write-Host " [*] $pythonExe" -ForegroundColor Green
        
        if ([bool]::Parse($pipisInstalled)) {
            Write-Host " [*] pip is installed" -ForegroundColor Green
            
            # Pip already exists
            Write-Host " [*] Pip already exists in PATH; running pip install --upgrade pip" -ForegroundColor Green
            $pyargs = @("-m", "pip", "install", "--upgrade", "pip")
            & $pythonExe $pyargs

            Write-Host " [*] Now installing VirtualEnv package..." -ForegroundColor Green
            $pyargs = @("-m", "pip" ,"install" ,"virtualenv", '--user')
            & $pythonExe $pyargs

        } else {
            Write-Host " [*] pip is NOT installed" -ForegroundColor Yellow
            
            $getpip = New-TemporaryDirectory
            Write-Host " [*] temp dir: " + $getpip

            Write-Host " [*] download pip installer" -ForegroundColor Green
            (new-object System.Net.WebClient).DownloadFile('https://bootstrap.pypa.io/get-pip.py', "$getpip\get-pip.py")

            Write-Host " [*] Now installing Pip..." -ForegroundColor Green
            $pyargs = @("$getpip\get-pip.py", '--user')
            & $pythonExe $pyargs

            Write-Host " [*] Now installing VirtualEnv package..." -ForegroundColor Green
            $pyargs = @("-m", "pip" ,"install" ,"virtualenv", '--user')
            & $pythonExe $pyargs
        }
        Write-Host " [*] remove temp py script: $checkPip" -ForegroundColor Green
        remove-item $checkPip

        
    } else {
        "Path doesn't exist. Check params in this script could be a newer version of max or python included in max"
    }
} else {
    "could not find a path to 3dsmax version $maxVersion"

}
