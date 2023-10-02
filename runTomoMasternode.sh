#!/bin/bash

# This file will start a tomo masternode 

# injecting env from .env file
export $(cat .env | xargs)

if [ -z "${DATADIR}" ]; then 
    DATADIR=$(pwd)
else 
    DATADIR=${DATADIR}
fi


# Download tomo binary if it does not exist
tomo version || curl "${TOMO_BIN_URL}" -o /usr/bin/tomo

rm -rf keystore
wallet=$(tomo account import --password "${DATADIR}/.pwd" --datadir "${DATADIR}" <(echo ${PRIVATE_KEY}) | awk -v FS="({|})" '{print $2}')

# Download genesis
curl "${GENESIS_URL}" -o "${DATADIR}/genesis.json"

if [ ! -d "${DATADIR}/tomo/chaindata" ]
then
  tomo --datadir "${DATADIR}" init "${DATADIR}/genesis.json"
fi

tomo  --datadir "${DATADIR}" --networkid ${CHAINID} --port 30303 \
  --announce-txs --store-reward --gcmode "${GCMODE}" --maxpeers 20 \
  --rpc --rpccorsdomain "*" \
  --ethstats "${NODENAME}:${WS_STATS_SECRET}@${WS_STATS_ENDPOINT}:${WS_STATS_PORT}" \
  --rpcaddr "0.0.0.0" --rpcport 8545 --rpcvhosts "*" \
  --ws --wsaddr "0.0.0.0" --wsport 8546 --wsorigins "*" \
  --rpcapi "admin,db,eth,net,web3,debug,posv,tomox" \
  --tomox.dbengine "leveldb" \
  --unlock "${wallet}" \
  --mine --bootnodes $BOOTNODES \
  --password "${DATADIR}/.pwd" --gasprice 250000000 --targetgaslimit 84000000 --verbosity 3