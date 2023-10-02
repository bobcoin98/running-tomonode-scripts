# Run TomoChain full node

## ⚙️ Configuration
- Update environment variable in .env
```bash
cp .env.sample.mainnet .env
```

There are 2 options: using binary or docker

## Getting started 
### Using tomo binary (run in systemd)

- Run this script 
```bash
bash runTomoMasternode.sh
```

### 🐳 Using docker

- Run 
```bash
    docker-compose up -d
```

## Download backup chaindata

- Stop tomo node
- Go to https://tomotools.com
- Download chaindata and tomox data
- For `chaindata`, extract data to $DATADIR/tomo
```bash
cd $DATADIR/tomo
rm -rf chaindata
tar block_chain_data.tar.gz -xvf -C $DATADIR/tomo
```
- For `tomox data`, extract data to $DATADIR
```bash
cd $DATADIR
rm -rf tomox
tar tomox_chain_data.tar.gz -xvf -C $DATADIR/
```

- Restart tomo node


## ⚖ Load Balancing

We can run multiple nodes independently but using same coinbase address

## ⚠️ Important note

Coinbase address is used to sign block and system transactions. Please create a new address to run a node, DONOT use existing address which have fund

We advise for security measures to use a fresh new account for your Masternode or 'coinbase address'. This is not the account that will receive the rewards. The rewards are sent to the account that will make the 50,000 TOMO initial deposit.