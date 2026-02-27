# MPFS Deployment

This directory contains the necessary files and instructions to deploy an MPFS system in preprod.

## Fresh setup

To set up a fresh MPFS deployment, follow these steps:
1. SSH into the mpfs server.
2. Install git.
3. Clone the repository and navigate to the `docs/deployment/mpfs` directory.
4. Edit .env file to set the target directory.
5. Source the bootstrap script to set up the node database with mithril snapshots.

```bash
apt install git -y
git clone https://github.com/cardano-foundation/hal.git
cd docs/deployment/mpfs
# edit .env to set MPFS_DIR
source bootstrap.sh
```

## Starting services

```bash
docker-compose up -d
```

## Bugs

It seems that MPFS get stuck on

```bash
curl http://localhost:3000/tokens
```

Restarting the service seems to fix the issue:

```bash
docker-compose restart mpfs
```