---
name: hal-guide
description: Guide to the cardano-foundation/hal repository — the Cardano Foundation High Assurance Lab (HAL) team repo. Load when asked about the HAL team, its handbook, processes, weekly or monthly meeting notes, the projects table (cardano-wallet, cardano-addresses, moog, mpfs, amaru, vrf, kes, pop), ZKP/cryptography learning material, or the team's preprod infrastructure - the MPFS Docker Compose stack (cardano-node, Ogmios, Yaci Store, PostgreSQL), Moog agent/oracle deployments, Gatus monitoring, Telegram alerting, node-currency-check.sh, bootstrap.sh, Mithril snapshot bootstrap, files under infrastructure/ or docs/, or hosts 10.1.21.19/20/21.
---

# HAL repository guide

## Repository map

| Path | Purpose |
|------|---------|
| `README.md` | Entry point: what the repo is, projects table with statuses and versions, architecture diagram |
| `docs/handbook.md` | How the team works: organisation, stack, git workflow, testing, open improvement topics |
| `docs/weekly/`, `docs/monthly/` | Meeting notes (one file per week) and monthly reports |
| `docs/async.md`, `docs/interviews.md`, `docs/2025-09-team-workshop.md` | Process documents and retrospectives |
| `docs/radicle.md` | Radicle evaluation; ends with the November 2025 decision to stop using it |
| `docs/homebrew.md` | How to add formulae to the team's Homebrew tap (notunrandom/homebrew-cardano) |
| `docs/crypto/` | ZKP learning material: gitbook.md (SageMath/Rust/Zig exercises), journal.md, training slides |
| `docs/deployment/anti-services.md` | Historical: pre-rename Moog ("anti") deployment; superseded by `infrastructure/moog/` |
| `infrastructure/mpfs/` | Preprod MPFS compose stack: cardano-node, Ogmios, Yaci Store + PostgreSQL, MPFS, autoheal |
| `infrastructure/moog/{agent,oracle}/` | Moog agent and oracle compose files, pinned to released images |
| `infrastructure/gatus/{mpfs,agent,oracle}/` | Per-host Gatus monitoring configs with Telegram alerting |
| `infrastructure/scripts/node-currency-check.sh` | Cron script alerting when a running cardano-node image lags the latest release |
| `templates/README.md` | README template for new HAL projects |

## Build, test, run

Nothing builds or runs locally; there is no CI, no flake, no test suite. The only executable content is the deployment configuration, which runs on three CF preprod hosts from a `/opt/hal` checkout:

- MPFS host (10.1.21.21): `cd /opt/hal/infrastructure/mpfs && docker compose up -d` (after the Mithril bootstrap and secret files described in `infrastructure/mpfs/README.md`)
- Agent host (10.1.21.20): `cd /opt/hal/infrastructure/moog/agent && docker compose up -d`
- Oracle host (10.1.21.19): `cd /opt/hal/infrastructure/moog/oracle && docker compose up -d`

Do not run these on a development machine: they mount host paths (`/opt/mpfs/...`) and secret files (`/home/paolino/secrets/...`) that only exist on those hosts.

## Navigating the code

- For deployment facts (image versions, ports, networks, secrets paths), the compose files are the source of truth: `infrastructure/mpfs/docker-compose.yml`, `infrastructure/moog/*/docker-compose.yaml`, `infrastructure/gatus/*/docker-compose.yaml`.
- Yaci Store indexer settings (sync start slot, enabled stores, Ogmios URL) are in `infrastructure/mpfs/application.properties`.
- Monitoring conditions (what fires a Telegram alert) are in `infrastructure/gatus/*/config.yaml`.
- The node config files in `infrastructure/mpfs/configs/` come from book.play.dev.cardano.org; `configs/download.sh` refreshes them.
- Team decisions and their history live in `docs/` (handbook for current practice, weekly/monthly notes for when something changed).

## Using the artifacts

This repo is consumed by reading, not installing. Typical operations:

- Deploy or update a service: follow the README next to its compose file (`infrastructure/{mpfs,moog/agent,moog/oracle}/README.md`); always `docker compose` from the `/opt/hal` checkout directory.
- Bootstrap a fresh MPFS node database: `source infrastructure/mpfs/bootstrap.sh` (requires a local `.env` defining `MPFS_DIR`; downloads a Mithril preprod snapshot).
- Check monitoring: Gatus web UI on the MPFS host listens on port 8090; alerts go to Telegram.
- Test the currency check without sending alerts: `DRY_RUN=1 infrastructure/scripts/node-currency-check.sh <telegram-env-file>`.

## Answering questions

- "What does the HAL team work on?" → the Projects table in `README.md` (status icons + pinned versions; verify versions against GitHub releases before quoting them, they age).
- "How does the team work / what's the process?" → `docs/handbook.md`; open questions are in its WIP section and in `docs/interviews.md`.
- "What runs in preprod / what is deployed where?" → `infrastructure/README.md` (host table + architecture diagram), then the per-service compose files.
- "Why did an alert fire?" → `infrastructure/gatus/*/config.yaml` for the condition; `infrastructure/scripts/node-currency-check.sh` for release-lag warnings.
- "What is MPFS / Moog?" → one-liners in the Projects table; the real docs are in their own repos (cardano-foundation/mpfs, cardano-foundation/moog).
- "Did the team adopt Radicle?" → no; `docs/radicle.md`, November 2025 decision.
