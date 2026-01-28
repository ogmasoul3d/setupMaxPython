# **Some small scripts to simplify the setup and usage of python in 3dsmax development**

 **Note.** *This does not use gitbash/bash SH scripting. Instead I use Powershell, since this is more available on the renderfarm.*

## installation and usage of this..
1. create a new folder for the python project that you want to work with inside 3dsmax. This folder can be where you want it to be.
```
cd d:\myProjects\
mkdir awsome_3dsmax_python_script
cd awsome_3dsmax_python_script
```
2. clone this repository down into your folder..
```
git clone https://github.com/ogmasoul3d/setupMaxPython
```

3. make sure to update the **maxversion.txt** to the version of 3dsmax you want to use. You open the file and edit to the version you use. If you are using max 2025 then change to ```2025```


4. now run this command in the powershell terminal, this will setup your max and things in your environment
```
.\setupMaxPython\InstallPipAndVirtualenv.ps1
```

5. now it is time to run the setupVenvInCurrentFolder command.. 
  - This makes a virtual environment using the python installed in 3dsmax.
  - it also creates a shortcut and places that on your desktop with the name of the folder you run it from, in this case"awsome_3dsmax_python_script"
  - it also creates a small splash screen bitmap that contains the name of the project.. so you see that when you double-click / run the short cut. (when you start to have more than one.. it can be good to know what project it is running)

```
.\setupMaxPython\setupVenvInCurrentFolder.ps1
```

To start 3dsmax with this virtual python environment active.. I recommend running the **startMaxLocal.ps1** from the terminal to start max
this makes it so you can install things (like pip packages) in the terminal efter max is started and you can reference them without restarting max.
```
.\setupMaxPython\startMaxLocal.ps1
```

---------
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








