#!/bin/bash
source /listener_root/config/ENV_VAR

cd /listener_root/

git clone git@bitbucket.org:$1.git temp

cd temp
git checkout $2

zip -r bundle.zip .

source /listener_root/venv/bin/activate

aws s3 cp bundle.zip s3://$BUCKET_NAME/$PREFIX/$3.zip

deactivate

cd /listener_root
rm -rf /listener_root/temp/
