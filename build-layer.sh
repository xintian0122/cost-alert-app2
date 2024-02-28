#!/bin/bash
set -eo pipefail
rm -rf package
pipenv lock -r > requirements.txt
pip install  --target ./package/python -r requirements.txt
# cd package && zip -r layer.zip ./python
cd package && zip -r ${VERSION}.zip ./python
aws s3 cp ${VERSION}.zip s3://$1/layers/