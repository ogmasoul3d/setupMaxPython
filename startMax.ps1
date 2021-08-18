if (Test-Connection -TargetName comseelm-nt9100.ikea.com -Quiet) {
    Write-Host "activate venv_3dsmax" 
    & ".\venv_3dsmax\Scripts\activate" /run 
    Write-Host "start max with this virtualEnv active" 
    & "C:\Program Files\Autodesk\3ds Max 2021\3dsmax.exe" /run 
}