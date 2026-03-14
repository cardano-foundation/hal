# Moog Agent Deployment

## Setup

```bash
git clone https://github.com/cardano-foundation/hal.git /opt/hal
cd /opt/hal/infrastructure/moog/agent
docker compose up -d
```

**Always deploy from `/opt/hal/infrastructure/moog/agent/`.** Running from a different directory will cause Docker to resolve relative paths incorrectly, leading to failures after reboot.

## Secrets

Download all assets from 1Password: [assets](https://start.1password.com/open/i?a=TYQQQLKUDBAFVHQ4P7XKFCUVYM&v=fhipthmhnufti4q2kky6d7336u&i=pa22ff5xcxlusp7g4jhvvitnlq&h=cardanofoundation.1password.com)
