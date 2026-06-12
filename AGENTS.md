# Repository Agent Guide

## What this repo is

The team repository of the High Assurance Lab (HAL) at the Cardano Foundation. It holds cross-project artifacts — the team handbook and process documents, weekly/monthly meeting notes, ZKP learning material, a README template — and the Docker Compose configuration for the team's preprod infrastructure (MPFS stack, Moog agent and oracle, Gatus monitoring). Product code lives in the project repositories listed in the [README](README.md#projects), not here.

## How to work here

- There is nothing to build or test: the repository is markdown plus deployment configuration. No CI runs on it.
- Changes follow the [handbook Git workflow](docs/handbook.md#git-workflow): short-lived branch off `main`, PR, review. Documentation-only changes may be committed directly to `main`.
- The compose files under `infrastructure/` are deployed on CF hosts from `/opt/hal`; do not run them locally — they mount host paths and secret files that only exist on those hosts.
- When verifying claims about the deployments, read the compose files (`infrastructure/*/docker-compose.y*ml`), not only the READMEs.

## Skills

Activatable procedures live under `skills/`. Load the one whose description matches your task:

- `skills/hal-guide/` — repository map, infrastructure layout, and where answers live; load it when asked anything about this repo, the HAL team, or its preprod deployments.
