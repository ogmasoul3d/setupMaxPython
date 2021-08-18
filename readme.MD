Some small script to simplify the setup of python in 3dsmax the current ones that install and setup tools like PIP for the version of python inside 3dsmax.

This does not use gitbash SH scripting. Instead I use Powershell since this is more available on the renderfarm.

This script should:
1. find the install location of your 3dsmax..
2. using the python version inside 3dsmax install the correct pip version and virtualEnv
3. it also updates pip if you already have it installed