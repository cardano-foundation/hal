## Building service images

To build the docker images, the supported way involve nix. Luckily the builder machines are nix-cached already

Add to .ssh/config
```
Host builder
  User <username>
  HostName 10.1.21.12
  IdentityFile ~/.ssh/ed25519
  ProxyJump jumpbox-dev
  ForwardAgent yes

Host mac-builder
  User <username>
  HostName 10.1.21.14
  IdentityFile ~/.ssh/ed25519
  ProxyJump jumpbox-dev
  ForwardAgent yes
```

- on your machine
  - fix the bugs
  - commit
  - bump the release in cabal v0.3.1.1 i.e.
  - update the CHNAGELOG
  - commit
  - push rad , push origin

- on builder
  - clone/pull the repo 
  - `just push-docker-images v0.3.1.1`
  - `CI/release.sh v0.3.1.1 linux64`

- on mac-builder
  - `clone/pull the repo`
  - `CI/release.sh v0.3.1.1 darwin64`

- on github, cleanup the release notes and release

## Deploying

Agent and Oracle processes are running on CF infrastructure. Here is how to get there

Add stanzas to your `.ssh/config`
```txt
Host colo1-jumpbox-dev
  User <username>
  IdentityFile ~/.ssh/ed25519
  HostName dev.colo1.cf-systems.org

Host oracle
  User <username>
  HostName 10.1.21.19
  IdentityFile ~/.ssh/ed25519
  ProxyJump colo1-jumpbox-dev

Host agent
  User <username>
  HostName 10.1.21.20
  IdentityFile ~/.ssh/ed25519
  ProxyJump colo1-jumpbox-dev
```
- on agent
  - `cd /opt/agent`
  - `ANTI_VERSION=v0.3.1.1 docker compose up -d`

- on oracle
  - `cd /opt/oracle`
  - `ANTI_VERSION=v0.3.1.1 docker compose up -d`

## Logging 

```bash
docker compose logs -tf
```

 
