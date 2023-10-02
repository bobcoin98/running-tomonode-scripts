#!/bin/bash

# This file configure to run tomo masternode in systemd

# injecting env from .env file
export $(cat .env | xargs)

if [ -z "${DATADIR}" ]; then 
    DATADIR=$(pwd)
else 
    DATADIR=${DATADIR}
fi

DATADIR=$(echo "$DATADIR" | sed 's_/_\\/_g')

sudo cp ./systemd.sample.service /etc/systemd/system/tomochain.service

sudo sed -i "s/DATADIR/${DATADIR}/g" ./systemd.sample.service

sudo systemctl start tomochain
sudo systemctl enable tomochain
