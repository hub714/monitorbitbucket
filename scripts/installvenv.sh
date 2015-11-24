#!/bin/bash

cd listener_root
virtualenv venv
source venv/bin/activate
pip install flask awscli

