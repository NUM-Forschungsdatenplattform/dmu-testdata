import os
import shutil
import json
import sys

filepath = os.path.abspath(__file__)
structure_def_path = os.path.dirname(os.path.dirname(filepath)) + '/StructureDefinitions/'

# create coverage file
# get files in StuctureDefinitions
files = os.listdir(structure_def_path)

for file in files:
    # load json file
    with open(structure_def_path + file) as f:
        pass
        