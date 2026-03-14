# MPFS Deployment

This directory contains the necessary files and instructions to deploy an MPFS system in preprod.

## Fresh setup

To set up a fresh MPFS deployment, follow these steps:
1. SSH into the mpfs server.
2. Install git.
3. Clone the repository to `/opt/hal` and run from there.
4. Source the bootstrap script to set up the node database with mithril snapshots.

```bash
apt install git -y
git clone https://github.com/cardano-foundation/hal.git /opt/hal
cd /opt/hal/infrastructure/mpfs
source bootstrap.sh
```

**Always deploy from `/opt/hal/infrastructure/mpfs/`.** Docker Compose resolves `./configs` relative to the working directory — running from any other location will cause containers to mount non-existent paths and crash on restart.

## Starting services

```bash
cd /opt/hal/infrastructure/mpfs
docker compose up -d
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