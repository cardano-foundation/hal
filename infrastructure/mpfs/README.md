# MPFS Deployment

This directory contains the necessary files and instructions to deploy an MPFS system in preprod.

## Prerequisites

The compose file and the bootstrap script expect a few files that are not in the repository:

- `.env` in this directory (gitignored), defining `MPFS_DIR` — the directory where the bootstrap script downloads the Mithril snapshot of the node database (the compose file mounts the node database from `/opt/mpfs/preprod/db`).
- `/home/paolino/secrets/mpfs/.env` — environment file for the `yaci-store-preprod` container (database credentials).
- `/home/paolino/secrets/mpfs/db-password` — password file for the `yaci-store-db-preprod` PostgreSQL container.

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

The node configuration files in [configs/](configs) are the preprod environment files from [book.play.dev.cardano.org](https://book.play.dev.cardano.org/environments.html); refresh them with [configs/download.sh](configs/download.sh).

## Starting services

```bash
cd /opt/hal/infrastructure/mpfs
docker compose up -d
```

## Monitoring

A Gatus instance on the same host (see [../gatus/mpfs/](../gatus/mpfs)) checks MPFS sync, Ogmios, Yaci Store and node head freshness, and the cron-driven [node-currency-check.sh](../scripts/node-currency-check.sh) warns when the pinned `cardano-node` image falls behind the latest release.

## Bugs

It seems that MPFS get stuck on

```bash
curl http://localhost:3000/tokens
```

Restarting the service seems to fix the issue:

```bash
docker compose restart mpfs
```
