## **When installing a local package**

1. go to the folder where the package, setup.py is
2. run pip install . to install the local package
3. add the *-e* option to make the package *editable* 

```
python -m pip install -e .
```
---------

## **In 3dsmax do this to update the module/library/package**
1. use the importlib module to handle updating the packages,
*if you do not do this you need to restart 3dsmax to get the changes*

```
import importlib
importlib.reload('theNameOfTheModuleThatShouldReload')

# when developing I add this to the top of the script
# so it easier gets the updates from the package I am developing
```

---------

## **pip installing packages from github, instead of pypi**
*tip from this [page](https://uoftcoders.github.io/studyGroup/lessons/python/packages/lesson/)*

**USING GIT**
This is my preferred way of sharing/storing/installing packages. Simply create a git repo of the project directory, and put it somewhere. Then, use pip to install it from that repo directly
```
pip install git+https://github.com/jladan/package_demo.git#egg=measurements
```
An advantage of this is that you can also install to particular branches, tags, and commits. A common practice is add a tag for the version release git tag v0.1. Users of the library can then lock into that particular version,
```
pip install git+https://github.com/jladan/package_demo.git@v0.1#egg=measurements
```
---------

## **Nice tutorial about python packing**
https://python-packaging.readthedocs.io/en/latest/minimal.html

