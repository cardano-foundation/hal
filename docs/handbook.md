# HAL team handbook

HAL is the [Cardano Foundation][CF]'s High Assurance Lab.

This handbook documents the ways in which we work.

## Organisation

The team is geographically distributed.

The team's leader is [Arnaud Bailly][GHAB].

The team holds a [weekly][weekly] planning meeting every Monday morning.

Arnaud holds a weekly one-to-one with each team member.

The team has a private Slack channel for day-to-day collaboration. Daily, every
member of the team writes what they plan to work on (and whether they need
something from other team members).

The team has a [GitHub repository][GHHAL].

## Product management

The team works simultaneously on several products (tools, libraries, ...) which
can be in different lifecycle stages from inception to maintenance.

There are no product owners. Product design is ad hoc. Sometimes, one of the
team members is designated as being "in charge" of a product.

## Code repositories

The code worked on by the team is spread across many Git repositories. We use
[GitHub][GH] to host
the repositories and provide collaboration tools (issues, pull requests etc.)

The list of repositories we work on is in the [README][README]

Often, a new repository is created when a new project is started. The
GitHub organisation to which the repository is attached is often, but not
always, [cardano-foundation][GHCF].

IOHK has a valuable [checklist][RepoChecklist] about whether or not to create a
new repository.

<a id="stack"></a>
## Software stack

The HAL team develops either in Haskell or Rust.

The choice between these options is a team decision based on the following factors:

- does the project require existing libraries, if so in which language are
  these libraries best?
- are we hoping for or expecting external contributions to the project (if so,
  privilege Rust)?
- if the deliverable is an executable system, privilege Haskell
- if the deliverable is a library, privilege Rust
- what the team is most skilled with
- personal preference of whoever is starting the project

In addition, we usually use various tools and libraries from the Cardano ecosystem.

We support both Linux and Mac OS.

### Haskell stack

- GHC
- cabal
- HSpec
- QuickCheck
- hlint
- fourmolu
- Docker
- Docker compose
- Nix
- nixfmt
- just
- make
- jq

### Rust stack

TODO

### Cardano stack

These are our tools and libraries of choice from the Cardano ecosystem:

- cardano-node
- cardano-cli
- Aiken
- yaci-store
- TODO

## Git workflow

Each team member is free to use Git through a tool of their choice.

The Git workflow is usually:

- create a short-lived branch (from main) to carry out work
- during the work, whenever possible, rebase from main, and commit progress
- when the work is ready, create a pull request (GitHub)
- get another team member to review the work as soon as possible
- merge back to main and delete the branch

Occasionally, work might be done on main and committed directly, for example:

- when it is a minor change or documentation only
- when the work was done in pair or mob programming and does not need additional review

## Software Design

There is no consistent, established or formal software design process (i.e.
design is ad hoc).

These are some of the design practices that the team sometimes uses:

- team discussion
- design diagrams
- design documents
- mob programming
- refactoring

## Testing

The HAL team carries out its own testing (there is no external QA). It is
generally up to the developer(s) writing new code to ensure that it is also
tested.

The HAL team generally uses a lot of automated testing (see our [stack](#stack)
for tools).

There is some variation/disagreement about:

- when to write tests (some use TDD more than others)
- how many tests to write (coverage)
- how much automated end-to-end testing to do
- whether or how to use properties (QuickCheck)
- whether or not to use golden tests

It is frowned upon to commit code which breaks any automated tests.

## Code

Team members are free to choose their code editors (currently used are Neovim,
Emacs and VS Code).

We try to pair program or even mob program (more than two). Sometimes we plan
this systematically a couple of times per week, sometimes it is unplanned. We
do it because it enables us to discuss design, share knowledge about the code,
share technical skills, and it results in code that is better quality and
already reviewed, so it can be merged immediately.

For Haskell, the HAL team continues to follow these [coding
standards][HaskellStyle] established by IOHK, with the following exception:
fourmolu is used as a formatter rather than stylish-haskell.

## Documentation

There is a standard [README.md template][ReadmeTemplate].

For the rest, there is no established or formalised list of documentation or
process to produce it.

## Continuous Integration

TODO

## Infrastructure

TODO

## WIP, clarifications, changes and improvements

This section lists open topics, such as elements of our process which could be
discussed, clarified, changed or improved.

### Organisation improvements

- Should we have a clearer long-term roadmap? Maybe a mission statement?
- Should we have time for exploring/research/personal projects?
- Why is there little interaction with rest of the organisation, should this
  change, and how?
- Do we have a low productivity and if so, how can we improve it?
- How could the weekly planning meeting be improved?
- Do we want more "residential workshops"?
- Should we adopt some or all of [The Core Protocols][Core] (or even organize a
  boot camp)?

### Product management improvements

- What does it mean for a team member to be "in charge" of a product?
- Shouldn't every project have a person in charge?
- How do we know what we need to do and/or whether what we have done is good?
- Wouldn't it be beneficial to have smaller, more frequent releases and to
  gather feedback more early, if possible from users?
- Should we add User Stories?
- Should we do [story mapping][newBacklog]?
- Should we have a backlog?
- Shouldn't we have real product owners instead?

### Software stack improvements

- Can we agree on whether to use Nix and if so how?
- Do we want automated, external CI?
- Is it possible and desirable to simplify our stack, tools, channels etc?
- What about TypeScript/JavaScript (including existing MPFS?)
- What about Zig?

### Version control improvements

- Should we adopt TBD?
- Some people want commit conventions, can we define them?
- What about additional tools:
  * [Gerritt][Gerrit]
  * [stgit][StGit]
  * [Code Rabbit][CodeRabbit]

### Design improvements

- Should design be done more collectively, if so how?
- Should we mob program more often or more systematically?
- Should we pair program more often or more systematically?
- Can we improve the *way* we mob/pair program?
- Should we do more upfront design and architecture?
- Should we do more TDD (which includes refactoring)?

<a id="test-imp"></a>
### Testing improvements

- Should we share, discuss and agree on testing practices and guidelines?
- Should we have external QA?
- Would it be possible and beneficial, at least for CLI's, to include the
  documentation (manuals) in the TDD cycle (and CI) using [litterate testing][LitTest]
  (with something like [mdshell][mdsh] and/or [cram][Cram])? This would
  therefore also be a [documentation improvement](#doc-imp)

### Code improvements

- Should we mob program more often or more systematically?
- Should we pair program more often or more systematically?
- Can we improve the *way* we mob/pair program?
- How about using ormolu rather than fourmolu to format Haskell code? There
  would be one less configuration file and it would contribute "standardising".
- For coding standard issues other than formatting which can be automated, how
  about we discuss them regularly (e.g. once a week) until we have a document
  with our chosen guidelines?

<a id="doc-imp"></a>
### Documentation improvements

- How could we improve our documentation and the way we produce it?
- Cf. [testing improvements](#test-imp) for a suggestion on writing automated
  documentation first.



[CF]: https://cardanofoundation.org/
[README]: ../README.md
[ReadmeTemplate]: ../templates/README.md
[weekly]: ./weekly/README.md
[GH]: https://github.com
[GHCF]: https://github.com/cardano-foundation
[GHAB]: https://github.com/abailly
[GHHAL]: https://github.com/cardano-foundation/hal
[HaskellStyle]: https://github.com/input-output-hk/adrestia/blob/master/docs/code/Coding-Standards.md
[RepoChecklist]: https://github.com/input-output-hk/adrestia/blob/master/docs/code/New-Repo-Checklist.md
[newBacklog]: https://jpattonassociates.com/the-new-backlog/
[Gerrit]: https://www.gerritcodereview.com/
[StGit]: https://stacked-git.github.io/
[CodeRabbit]: https://www.coderabbit.ai/
[mdsh]: https://github.com/bashup/mdsh
[LitTest]: https://github.com/bashup/mdsh#literate-testing
[Cram]: https://bitheap.org/cram/
[Core]: https://thecoreprotocols.org/
