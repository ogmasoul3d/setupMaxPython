## **important thing**
For 3dsmax to really function you need to create a `virtual-environment` using
```
python -m virtual venv
```
IF you just do `python -m venv venv`, then it **DOES NOT WORK** with 3dsmax. Venv is a subset to virtualenv and for this to function you need some more complex operations included in virtualenv.

## **When installing a local package**
<div style="padding-left: 10px;">

1. go to the folder where the package, setup.py is
2. run pip install . to install the local package
3. add the *-e* option to make the package *editable* 

```powershell

python -m pip install -e .
```
---------
</div>

## **In 3dsmax do this to update the module/library/package**

<div style="padding-left: 10px;">
1. use the importlib module to handle updating the packages,
*if you do not do this you need to restart 3dsmax to get the changes*

```python
import importlib
importlib.reload('theNameOfTheModuleThatShouldReload')

# when developing I add this to the top of the script
# so it easier gets the updates from the package I am developing
```
</div>
---------

## **pip installing packages from github, instead of pypi**

<div style="padding-left: 10px;">

**USING GIT**

*tip from this [page](https://uoftcoders.github.io/studyGroup/lessons/python/packages/lesson/)*

This is my preferred way of sharing/storing/installing packages. Simply create a git repo of the project directory, and put it somewhere. Then, use pip to install it from that repo directly
```powershell
pip install git+https://github.com/jladan/package_demo.git#egg=measurements
```
An advantage of this is that you can also install to particular branches, tags, and commits. A common practice is add a tag for the version release git tag v0.1. Users of the library can then lock into that particular version,
```powershell
pip install git+https://github.com/jladan/package_demo.git@v0.1#egg=measurements
```

there seems to be an issue with dependency-links.. if you have a package that are dependant on other packages also hosted on github..

using the **install_requires** in your setup instead is "more correct"
https://stackoverflow.com/a/54216163

```json
setup(
    name='yourpackage',
    version='1.7.5',
    packages=[],
    url='',
    license='',
    author='',
    author_email='',
    description='',
    install_requires=[
        'somepackage==1.2.0',
        'repo @ https://github.com/user/archive/master.zip#egg=repo-1.0.0',
        'anotherpackage==4.2.1'
    ],
)
```



**From a Git repository, [better docs for this:](
https://docs.readthedocs.io/en/stable/guides/private-python-packages.html)**

Pip supports installing packages from a Git repository using the URI form:

```python
git+https://gitprovider.com/user/project.git@{version
```

Or if your repository is private:
```python
git+https://{token}@gitprovider.com/user/project.git@{version}
```

Where `version` can be a tag, a branch, or a commit. And `token` is a personal access token ***with read only permissions*** from your provider.

To install the package, you need to add the URI in your requirements file. Pip will automatically expand environment variables in your URI, so you don’t have to hard code the token in the URI. See using environment variables in Read the Docs for more information.

---------
</div>

## **Nice tutorial about python packing**
<div style="padding-left: 10px;">
https://python-packaging.readthedocs.io/en/latest/minimal.html
</div>

