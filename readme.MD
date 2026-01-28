# **Some small scripts to simplify the setup and usage of python in 3dsmax development**

 **Note.** *This does not use gitbash/bash SH scripting. Instead I use Powershell, since this is more available on the renderfarm.*

Here are my small powershell scripts to setup:
* inital install of pip and virtualenv on a freshly installed max.. (**run once** on newly installed max)
* a small script that setups Venv inside the Project folder you want to work with.. (**run every time you create a new project**)	
* and a handly/lazy script that activates the Venv BEFORE starting 3dsmax.. to make sure it is active.. All the packages you install in your virtual-env is available in max.. **This is run, everytime I start 3dsmax**

--------
## **[!] Before running any scripts, *UPDATE maxversion.txt* to the version you are targeting. All scripts will read this file to get the version num** 

Just type the version id directly in the **maxversion.txt** file.. nothing else.. ex:
```
2026
```


##  **InstallPipAndVirtualenv.ps1**

**Usage:**
*You need to update the **$maxName** variable to the version of max you are using and you need to update the **$3dsmaxPythonVersion** if that has changed. You see the name of the folder for python, inside the program folder for max. <br><br>
This is done on a freshly installed 3dsmax. **You do not need to run this again after it is installed**, only if you want to update pip after the initial installation*

```
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



This script should:
1. find venv folder in the folder this is run from
2. activate the venv
3. start 3dsMax from this terminal with venv activated
4. this makes everything you install in this virtual-environment accessable to 3dsmax, to import, as well

### **[my page with other learnings and findings in this Python & Max endevour](/MaxPythonTipsnTricks)**


