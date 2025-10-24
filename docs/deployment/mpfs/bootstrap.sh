. .env

# Cardano network
export CARDANO_NETWORK=preprod

# Aggregator API endpoint URL
export AGGREGATOR_ENDPOINT=https://aggregator.release-preprod.api.mithril.network/aggregator

# Genesis verification key
export GENESIS_VERIFICATION_KEY=$(wget -q -O - https://raw.githubusercontent.com/input-output-hk/mithril/main/mithril-infra/configuration/release-preprod/genesis.vkey)

# Ancillary verification key
export ANCILLARY_VERIFICATION_KEY=$(wget -q -O - https://raw.githubusercontent.com/input-output-hk/mithril/main/mithril-infra/configuration/release-preprod/ancillary.vkey)

# Digest of the latest produced cardano db snapshot for convenience of the demo
export SNAPSHOT_DIGEST=latest

export MITHRIL_IMAGE_ID=latest

mkdir -p bin

curl --proto '=https' --tlsv1.2 -sSf \
    https://raw.githubusercontent.com/input-output-hk/mithril/refs/heads/main/mithril-install.sh \
        | sh -s -- -c mithril-client -d latest -p bin

export PATH=$PATH:$(pwd)/bin

cd $MPFS_DIR
mithril-client cardano-db download --include-ancillary $SNAPSHOT_DIGEST
