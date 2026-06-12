# Moog Agent Deployment

Runs the [Moog](https://github.com/cardano-foundation/moog) agent against the team's preprod MPFS instance (`http://10.1.21.21:3000`). The agent mounts the host Docker socket and authenticates to the Antithesis registry with the credentials in `docker-config.json`.

## Setup

```bash
git clone https://github.com/cardano-foundation/hal.git /opt/hal
cd /opt/hal/infrastructure/moog/agent
docker compose up -d
```

**Always deploy from `/opt/hal/infrastructure/moog/agent/`.** Running from a different directory will cause Docker to resolve relative paths incorrectly, leading to failures after reboot.

## Secrets

Download all assets from 1Password: [assets](https://start.1password.com/open/i?a=TYQQQLKUDBAFVHQ4P7XKFCUVYM&v=fhipthmhnufti4q2kky6d7336u&i=pa22ff5xcxlusp7g4jhvvitnlq&h=cardanofoundation.1password.com)

The compose file expects them at:

- `/home/paolino/secrets/moog/agent/agent.json` — the agent wallet
- `/home/paolino/secrets/moog/agent/secrets.yaml` — agent secrets (the expected keys are documented in the comments at the bottom of [docker-compose.yaml](docker-compose.yaml))
- `/home/paolino/secrets/moog/agent/docker-config.json` — Docker registry credentials
