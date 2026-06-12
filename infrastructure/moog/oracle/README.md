# Moog Oracle Deployment

Runs the [Moog](https://github.com/cardano-foundation/moog) oracle against the team's preprod MPFS instance (`http://10.1.21.21:3000`).

## Setup

```bash
git clone https://github.com/cardano-foundation/hal.git /opt/hal
cd /opt/hal/infrastructure/moog/oracle
docker compose up -d
```

**Always deploy from `/opt/hal/infrastructure/moog/oracle/`.** Running from a different directory will cause Docker to resolve relative paths incorrectly, leading to failures after reboot.

## Secrets

Download all assets from 1Password: [assets](https://start.1password.com/open/i?a=TYQQQLKUDBAFVHQ4P7XKFCUVYM&v=fhipthmhnufti4q2kky6d7336u&i=zcv5aijxrq3obq23ozzustghta&h=cardanofoundation.1password.com)

The compose file expects them at:

- `/home/paolino/secrets/moog/oracle/oracle.json` — the oracle wallet
- `/home/paolino/secrets/moog/oracle/secrets.yaml` — oracle secrets
