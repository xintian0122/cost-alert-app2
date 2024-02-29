#!/bin/bash
set -eo pipefail  #This line sets some options for the shell.
                  #the script will exit immediately if any command fails.
                  #if any command in a pipeline fails, the whole pipeline will fail, rather than just the last command.
# Debugging
pipenv --version

rm -rf package #This command recursively removes the package directory
pipenv lock -r > requirements.txt  #This generates a requirements.txt file from the Pipfile.lock using Pipenv. 
                                   #This file contains a list of all Python packages required for the project and their versions.
pip install  --target ./package/python -r requirements.txt
# cd package && zip -r layer.zip ./python
cd package && zip -r ${VERSION}.zip ./python
aws s3 cp ${VERSION}.zip s3://$1/layers/