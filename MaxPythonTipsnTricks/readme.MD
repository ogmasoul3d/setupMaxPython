## **When installing a local package**

1. go to the folder where the package, setup.py is
2. run pip install . to install the local package
3. add the *-e* option to make the package *editable* 

```
python -m pip install -e .
```

## **In 3dsmax do this to update the module/library/package**
1. use the importlib module to handle updating the packages,
*if you do not do this you need to restart 3dsmax to get the changes*

```
import importlib
importlib.reload('theNameOfTheModuleThatShouldReload')

# when developing I add this to the top of the script so it easier gets the updates from the package I am developing
```

