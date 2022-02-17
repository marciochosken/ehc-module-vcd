#!/bin/bash

set -a

read -p 'Org: ' VCD_ORG
read -p 'VDC: ' VCD_VDC
read -p 'VCD URL: ' VCD_URL
read -p 'VCD_ALLOW_UNVERIFIED_SSL : ' VCD_ALLOW_UNVERIFIED_SSL
read -p 'Username: ' VCD_USER
read -rs -p 'Password: ' VCD_PASSWORD

if [ ! -z "$@" ]; then
    if [ $1 == "up" ]; then
        terraform init
        terraform apply
    elif [ $1 == "down" ]; then
        terraform init
        terraform destroy
    else
        echo "inserir argumento up ou down"
    fi
else
    echo "inserir argumento up ou down"
fi

unset VCD_ORG VCD_VDC VCD_URL VCD_ALLOW_UNVERIFIED_SSL VCD_USER VCD_PASSWORD