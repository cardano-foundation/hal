# High-Assurance Lab Team

This repository contains documentation, reports, plans, roadmaps, and more generally all kind of artifacts related to the _High Assurance Lab_ team at the [Cardano Foundation](https://cardano.org) which are cutting across other projects boundaries.

## Links

* [Roadmap](https://github.com/orgs/cardano-foundation/projects/27/views/1)
* [Weekly meetings](docs/weekly)
* [Handbook](docs/handbook.md)
* [Cryptography prerequisites for ZKP](docs/crypto/gitbook.md)

## Projects

For projects' specific items (code, issues, patches, etc...), refer to the following repositories.
Each project's status is identified by an icon:

* 🔒 : Project is in maintenance mode, no new feature will be developed
* 💀: Project is not maintained nor developed
* 🚧 : Project is actively being developed but not ready for widespread usage yet
* 🚢 : Project is live and actively being developed
* 📢 : Project is gathering feedback
* 💡 : Project is at ideation stage


| Project                   | Comment                                                                 | Status | Version                                                                                      | URL                                                                     |
|---------------------------|-------------------------------------------------------------------------|--------|----------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| `cardano-wallet`          | Historically the main focus of the team                                 | 🔒     | [v2025-03-31](https://github.com/cardano-foundation/cardano-wallet/releases/tag/v2025-03-31) | [github](https://github.com/cardano-foundation/cardano-wallet)          |
| `cardano-wallet-agda`     | Formal specification for some wallet features                           | 🔒     |                                                                                              | [github](https://github.com/cardano-foundation/cardano-wallet-agda)     |
| `cardano-addresses`       | CLI tool for addresses and mnemonic manipulation & derivations          | 🚢     | [4.0.1](https://github.com/IntersectMBO/cardano-addresses/releases/tag/4.0.1)                | [github](https://github.com/IntersectMBO/cardano-addresses)             |
| `cardano-crypto`          | Library for low-level crypto                                            | 🔒     |                                                                                              | [github](https://github.com/IntersectMBO/cardano-crypto)                |
| `moog`                    | Antithesis CLI client  for Cardano ecosystem                            | 🚢     | [v0.4.1.1](https://github.com/cardano-foundation/moog/releases/tag/v0.4.1.1)                 | [github](https://github.com/cardano-foundation/moog)                    |
| `mpfs`                    | Merkle-Patricia-Forestry generic service                                | 🚧     |                                                                                              | [github](https://github.com/cardano-foundation/mpfs)                    |
| `cardano-deposit-wallet`  | Safer and faster experimental wallet                                    | 💀     |                                                                                              | [github](https://github.com/cardano-foundation/cardano-deposit-wallet)  |
| `pop`                     | Track software lifecycle on Cardano, related to `mpfs` and `antithesis` | 💡     |                                                                                              | [github](https://github.com/cardano-scaling/pop)                        |
| `vrf`                     | Library for VRF crypto                                                  | 🚧     |                                                                                              | [github](https://github.com/txpipe/vrf)                                 |
| `kes`                     | Library for KES crypto                                                  | 🚧     |                                                                                              | [github](https://github.com/txpipe/kes)                                 |
| `cardano-wallet-client`   |                                                                         | 💀     |                                                                                              | [github](https://github.com/cardano-foundation/cardano-wallet-client)   |
| `amaru`                   | Rust Cardano node                                                       | 🚧     |                                                                                              | [github](https://github.com/pragma-org/amaru)                           |
| `cardano-node-antithesis` | Testing the Haskell cardano node                                        | 🚧     |                                                                                              | [github](https://github.com/cardano-foundation/cardano-node-antithesis) |
