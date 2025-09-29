# Team Workshop in Toulouse

* Dates: 2025-09-24/25
* Raw document: https://docs.google.com/document/d/17U_ypqv9r6VuMPrLmQhrLXmF5qOn8vS3L9R5wo-25zE/edit?tab=t.0

## Agenda (Tentative)

Here is the tentative agenda the team settled on before the workshop

### Wednesday

| Time  | Topic                                                               |
|-------|---------------------------------------------------------------------|
| 9:30  | Present Crypto work (@paweljakubas)                                 |
|       | Node diversity workshop feedback (@abailly @paolino)                |
| 11:00 | Core protocols intro (@notunrandom)                                 |
| 11:30 | Process discussion (all) on proposed topics following               |
| 12:30 | Lunch break                                                         |
| 14:00 | MPFS Code Walkthrough code (@paolino)                               |
| 15:00 | MPFS - Rust mob programming: Start rewriting MPFS as a Rust service |

### Thursday

| Time  | Topic                                                                                         |
|-------|-----------------------------------------------------------------------------------------------|
| 09:00 | Process definition: Write down decisions and update Team handbook                             |
| 10:30 | coffee break                                                                                  |
| 10:45 | Amaru: Walkthrough the codebase, get a high level look at how to run it, bootstrap node, etc. |
| 12:30 | Lunch break                                                                                   |
| 14:00 | Meet Toulouse CF Crew:  Future collaboration plans                                            |
| 16:00 | Haskell mob programming:  PoP, Anti CLI, something else?                                      |

### Process discussion topics

Process discussion topic selection {#process-discussion-topic-selection}

1. Please read the [handbook](./handbook.md)
2. Choose from the [WIP, clarifications, changes and improvements](./handbook.md#wip-clarifications-changes-and-improvements) section topics you most want to discuss
3. If they are not listed below add them (do not add “Core Protocols” since this is getting its own slot) and add a voting chip (type @ followed by “Vote”)
4. Place your 4 voting chips on existing topics or your added topics

* (❤️ 2) Shouldn't we have real product owners?
* (❤️ 2) Are we keeping Radicle? What about GitHub?
* (❤️ 2) Should nix be (part of?) “official” build instructions?
* (❤️ 1) Why is there little interaction with the rest of the organisation, should this change, and how?
* (❤️ 1) How could the weekly planning meeting be improved?
* (❤️ 2) Is it possible and desirable to simplify our stack, tools, channels etc?
* (❤️ 1) Should design be done more collectively, if so how?

## Minutes

### Crypto work

- Presentation of KES and VRF crypto libraries and CLIs, what are those used for, how they work, why we are using them and what kind of work we are doing.
- Discussed a bit at a higher level how the VRF proof system works and why it matters, also as an aside whether or not we could use those tools for anti cli

### Node diversity Workshop

- @abailly and @paolino attended Node Diversity workshop on Monday and Tuesday
- They gave an overview of what happened during NDWk and why it matters for the team. Overall the feedback was good and we identified some “customers” for Antithesis and anti-cli.

### Core protocols

- Quick presentation of the [Core Protocols](https://thecoreprotocols.org/) and how/why the team would use them

### Roadmap

After lunch, we decided to work on a high-level roadmap for the next 6 months instead of focusing on MPFS details.

Team purpose: Build tools & services **for** Cardano builders **on** Cardano

#### Next half-year goals

We first list a handful of relevant goals for the team to achieve in the next 6 months

1. Run `anti cli` on mainnet by end of Q1 2026

   Stakeholders: Users of `anti cli` and Antithesis
2. Running `anti cli` and Antithesis tests is a mandatory gate for releasing nodes

   Stakeholders: Testers, Release managers, Intersect TSC and Sec Council, Community
3. Handover running `anti` agent & oracle to a dedicated entity

   Stakeholders: Intersect, TSC/SC, CF, PRAGMA
4. (_stretch_) Identify 1-2 stakeholders for PoP

   Stakeholders: Aiken/Smart contracts builders, Cardano Open source community, Haskell Foundation
5. (_stretch_) Use `anti cli` outside of Cardano

   Stakeholders: Antithesis, OSS at large

We then refine each goal into more or less concrete deliverables we think are needed to achieve that goal.

#### Anti CLI on mainnet

* Upgrade/improve [MPFS smart contract](https://app.radicle.xyz/nodes/seed.hydra.bzh/rad:zpZ4szHxvnyVyDiy2acfcVEzxza9/tree/on_chain/validators/cage.ak) to remove shortcuts:
  * allow migrations, refund change-request deposits, track time, improve security, possibly even audit the contract
* Build and share high-quality web site, should have:
  * Good UI and UX
  * Clear instructions/tools on how to get started with `anti cli`
  * Documentation and user guide(s)
  * Live Usage dashboard (eg. [Mithril Explorer](https://mithril.network/explorer/))
  * Clear feedback channel
* Easy installation process
  * Integrate `anti cli` with common package mangers (RPM, Apt, Homebrew) to speedup onboarding
* Antithesis resources allocation API
  * ⚠ heavily reliant on AT's own APIs and capabilities

#### Antithesis gates nodes releases on mainnet

* Easy addition of _properties_ and _drivers_
  * Should be easy to mix/match various [test drivers](https://antithesis.com/docs/test_templates/test_composer_reference/) and [properties](https://antithesis.com/docs/properties_assertions/properties/)
  * Stakeholders: Testers, Node implementors, ...
* Document publicly scenarios and properties
  * Complete [Blueprints](https://github.com/cardano-scaling/cardano-blueprint)
* Complete adversarial node
  > Need to clarify what this means really

#### Handover Agent/Oracle run to a dedicated organisation

* Package oracle service and container to run with wallet and keys
  * Include setup instructions
  * Migration procedure from Preprod to Mainnet

  Stakeholders: Infra team @CF, PRAGMA?
* Package agent as a service
  * Requires handing over keys and pwd access to AT infrastructure
* Allow migration of smart contracts on-chain
  * pre-requisite to any future change

#### OSS/HAL teams collaboration topics

* Build a deployment manager for SCs
  * Not a "package manager" per se but more a "linker" to manage runtime dependencies for SCs to avoid having to repeat code on-chain over and over
  * Could be tied to PoP/MPFS work
* Certify Github data on-chain for use by Cardano txs
  * leverages MPFS + work done on GH integration for AT
  * Use as an oracle to demo validation of Amaru treasury disbursements with SCs
  * Deadline: 2025-11-10, eg. for the Cardano Summit!
* End-to-end ZK proof verification of a Plutus VM computation using Groth16 circuits
  * Pb with ZK proofs is that each circuit requires key exchange and is very specific, having a generic circuit for UPLC would make it possible to generate
* Data analytics-focused chain indexer
  * Index chain data using column DBs, eg. [Parquet files](https://parquet.apache.org), for use by data analytics query engines
  * Could use directly the cardano-node ChainDB instead of syncing through mini-protocols
  * For use by M Piz in dashboards
* Access chain-data on-chain
  * Provide an oracle reflecting chain data on-chain, eg. stake distribution
  * "large" data sets could be provided as a bloom filter assuming imprecisions are ok, eg. check if a DRep is registered or not
* SPO certify computations using Mithril
  * SPOs can put txs on-chain with certficates/signatures for computations
* Tracing Ledger rules execution time
  * Put in place code in Haskell ledger to trace execution time of each rule

### Process Topics

We first had a (meta-)discussion about process triggered by the lack of responses from the team on this topic.
Some issues, more often than not questions, that popped up during the discussion:

* Team members are flexible, they've had experience with diverse kind of processes with mixed successes and failures and having a strongly defined process does not appear to have an impact on success or failure
* Team members trust the team lead to provide direction and colleagues to do the right thing
* There used to be a handbook as part of Adrestia/Cardano-wallet effort but it seems not everyone in the team cared and it did not have a lasting impact
* The goal and purpose of the team is much more important than the actual process
* Having a _Product Owner_ helps to clarify what to do and where to go
* It's unclear how to measure what "success" and "failure" mean
* Perhaps some kind of short  "manifesto" defining values and principles instead of practices would be more helpful?
* Is there a productivity problem w/in the team?

#### Specific topics discussion

We then moved on to discuss more specifically each of the selected topics:

* _Shouldn't we have real product owners?_

  * Also QA is another related role, eg. having some “external” view on the team's work
  * what are the Options:
    1. have an additional person with the competence
    1. Do it internally as a role, with the person playing the role not doing anything else on a particular product, not as a committee
  * How many products do we have?
    1. Anti cli (and Antithesis)
    2. MPFS
    3. “Adversary” (Cardano testing suite)
* Are we keeping Radicle? What about GitHub?
  * We now are using Radicle for 2 projects (really 1 active)
  * There's a complexity involved in managing both GH and Rad, and possibly confusion for end-users
  * Team likes to work with Rad but understand the needs to keep a presence on GH
* Should nix be (part of?) “official” build instructions?
* Why is there little interaction with the rest of the organisation, should this change, and how?
* How could the weekly planning meeting be improved?
* Is it possible and desirable to simplify our stack, tools, channels etc?
* Should design be done more collectively, if so how?

#### Decisions

| Who                    | What                                                                        |
|------------------------|-----------------------------------------------------------------------------|
| @abailly               | Hire an additional person to join team as a PO                              |
| @paweljakubas/@paolino | Define/clarify how Rad interacts with GH in the [handbook](handbook.md)     |
| @abailly               | Provide alternative install/build instructions beside nix for Linux and Mac |
| all                    | Update weekly meeting process to be driven by past and future _issues_      |
|                        |                                                                             |
