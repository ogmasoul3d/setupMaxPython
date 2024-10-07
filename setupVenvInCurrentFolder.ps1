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


#update this row to the max version you are targeting
if (Test-Path -Path "$PSScriptRoot\maxversion.txt") {
    $maxV = Get-Content $PSScriptRoot\maxversion.txt
    write-host " [*] Found maxversion: $maxV in $PSScriptRoot\maxversion.txt" -ForegroundColor Green
    $maxName = $maxV
} else {
    write-host " [*] could not find the $PSScriptRoot\maxversion.txt" -ForegroundColor Red
    $maxName = 2021
}

#this is the correct python folder for max 2021 and 2022
$3dsmaxPythonVersion = "Python"

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

        Write-Host " [*] Setting up virtualenv in /venv folder.." -ForegroundColor Green
        $pyargs = @("-m", "virtualenv" ,"venv")
        & $pythonExe $pyargs
        
        if (Test-Path -Path "requirements.txt"){
            & ".\venv\Scripts\activate" /run
            Write-Host " [*] I found a requirement.txt inside the folder you are running this in.. I am installing the deps now.." -ForegroundColor Green
            $pyargs = @("-m", "pip" ,"install", "--upgrade", "-r", "requirements.txt")
            & $pythonExe $pyargs
        }
    }

    Write-Host " [*] creating shortcut on desktop.." -ForegroundColor Green
     
    # Specify the target path (the .ps1 file you want to link to)
    $targetPath = "$PSScriptRoot\startMaxLocal.ps1"  # Adjust the file name as needed

    # Use the parent directory of the script's folder as the "Start In" directory
    $startInFolder = Split-Path -Path $PSScriptRoot -Parent

    # Get the last folder name from the "Start In" path to use as the shortcut name
    $linkName = Split-Path -Path $startInFolder -Leaf

    # Define the path for the shortcut on the desktop
    $shortcutPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath("Desktop"), "$linkName.lnk")

    # Create a new WScript.Shell COM object
    $wShell = New-Object -ComObject WScript.Shell

    # Create the shortcut object
    $shortcut = $wShell.CreateShortcut($shortcutPath)

    # Set the shortcut properties
    $shortcut.TargetPath = $targetPath
    $shortcut.WorkingDirectory = "$startInFolder\"
    $shortcut.Description = "Shortcut to my PowerShell script"

    # Save the shortcut
    $shortcut.Save()

    Write-Output "Shortcut created on the desktop: $shortcutPath"

    Write-Host " [*] Generating 3dsmax splash screen.." -ForegroundColor Green
    & .\setupMaxPython\GenerateSplashScreen.ps1 -text $linkName


} else {
    "could not find a path to 3dsmax version $maxVersion"
}

