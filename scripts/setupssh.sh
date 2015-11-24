#!/bin/bash
source /listener_root/config/ENV_VAR
mkdir /root/.ssh

cd listener_root
virtualenv venv
source venv/bin/activate

aws s3 cp s3://$KEY_BUCKET/$KEY_PREFIX/$KEY_NAME /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa

touch /root/.ssh/known_hosts
ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts
