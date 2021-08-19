# **Some small scripts to simplify the setup and usage of python in 3dsmax development**

 **Note.** *This does not use gitbash/bash SH scripting. Instead I use Powershell, since this is more available on the renderfarm.*

--------

##  **InstallPipAndVirtualenv.ps1**

**Usage:**
*You need to update the **$maxName** variable to the version of max you are using and you need to update the **$3dsmaxPythonVersion** if that has changed. You see the name of the folder for python, inside the program folder for max. <br><br>
This is done on a freshly installed 3dsmax. **You do not need to run this again after it is installed**, only if you want to update pip after the initial installation*

```
#update this row to the max version you are targeting
$maxName = 2022

#this is the correct python folder for max 2021 and 2022
$3dsmaxPythonVersion = "Python37"
```


This script should:
1. find the install location of your 3dsmax..
2. *using the python version inside 3dsmax*, install the correct pip version and virtualEnv
3. it also updates pip if you already have it installed

--------
##  **setupVenvInCurrentFolder.ps1**

**Usage:**
*You need to update the **$maxName** variable to the version of max you are using and you need to update the **$3dsmaxPythonVersion** if that has changed. You see the name of the folder for python, inside the program folder for max<br><br>**This script is run every time I want to setup a new venv for a new project** I am working on. I usually copy this script to that folder and let it setup the virtual-environment.*

```
#update this row to the max version you are targeting
$maxName = 2022

#this is the correct python folder for max 2021 and 2022
$3dsmaxPythonVersion = "Python37"
```


This script should:
1. using the PIP and python inside 3dsmax, installed with "InstallPipAndVirtualenv.ps1"
2.  setup up a Venv directory inside the folder where this script is run.

--------
##  **startMaxLocal.ps1**

**Usage:**
*This is a small helper script that activates venv before starting 3dsmax, this makes the same virtual-environment available to 3dsmax. Which simplifies development<br><br>This script is run **every time** I start 3dsmax, that is using this specific Venv*

```
#update this row to the max version you are targeting
$maxName = 2022
```

This script should:
1. find venv folder in the folder this is run from
2. activate the venv
3. start 3dsMax from this terminal with venv activated
4. this makes everything you install in this virtual-environment accessable to 3dsmax, to import, as well

### **[my page with other learnings and findings in this Python & Max endevour](https://github.com/ogmasoul3d/setupMaxPython/tree/main/MaxPythonTipsnTricks)**