# Radicle

[Radicle][radicle] is an open source, peer-to-peer code collaboration stack
built on Git. In other words, it is a decentralized alternative to GitHub,
GitLab etc. As such, the HAL team felt that it is relevant to the objectives
of its Proof-of-provenance (PoP) project, as well as consistent with the
values and objectives of the Cardano Foundation and blockchains in general.

The HAL team set out to evaluate Radicle.

## Evaluation

The evaluation started on 2025-05-19.

Two active repositories were used for the evaluation:

- antithesis
- mpfs

After one month, the team felt that:

- they liked the concept
- it is usable, with many very positive things and some lacunae
- the difficult question is whether to be radical or stay mainstream

As a result, the trial period is extended and the team will try to see whether
others in the Cardano Foundation would support such a transition.

See below for more detailed, personal, impressions.

### First checkpoint

On 2025-06-18, after one month of use, the HAL team expressed the following
first impressions, and decided whether and how to continue the evaluation.


#### @paweljakubas

* really loves the idea, full decentralisation
* likes the CLI, overall decomposition of workflow makes sense, maps naturally
  to "real work" and everything needed
* it works (!)
* feels the CLI was very well designed
* enthusiastic because it maps closely with what the team is focused on
  (supporting decentralized OSS developement)
* could be perfected but good enough to continue working with
* tutorial (eg. [user guide](https://radicle.xyz/guides/user)) well written
* loves the roadmap, seems like a serious competitor for GH in the future

#### @notunrandom

* happy to adopt it to support decentralization and independence
* not that familiar with GitHub so same effort for him to learn Radicle
* questions whether our best policy would be to stay on GitHub to be more
  visible and easier to adopt, or move to Radicle to pave the way for Web3
* does not want to jump back and forth between two platforms, would rather
  we make a clear choice either way
* a few unexpected or missing features but good enough
* when you are not a delegate you cannot see names of authors, just did's

#### @anviking

* likes CLI a lot
* fine working on a small project, would have missed comments on PRs if working
  on a larger project
* fears we might isolate ourselves outside of GH
* cognitive overhead working w/ Rad and switching GH
* ssh forward agents on GH is a nicer UX than having multiple identities on
  multiple machines

#### @abailly

* likes the concept, and would love to push it for "political" reasons
* CLI is well polished, provides all you need work comfortably
* working in a team feels a bit more awkward
  * it's hard to review/comment on patches, or rather it's hard to have a good
    overview
  * UX is better on the app but then you lose the nice CLI workflow
* the team is very responsive on their Zulip chat (but again, not mainstream)
* the workflow needs to be very different than the usual PR based workflow
  * using patches as PRs is probably not the right way to do it
  * might be better for fully OSS projects
  * might not even be suited for TBD

#### @paolino

* protocol is fine, information is there but UI is not there
* review process does not allow reviewing specific line
  * possible with an app but does not work when working remotely
* wants to have the freedom to use the CLI
* doesn't like GH so it solves the problem of not using GH
* different opinion about GitLab
* we don't need this type of platform, perhaps it's a matter of making Radicle
  better?
* working on a decentralised protocol (Cardano) aligns nicely with the
  philosophy of Radicle
* one positive aspect: hosting of the projects' code is much less
  centralised and removes the ambiguity of having the code "owned" by
  individuals vs. organisation (eg. CF org in GH can be at odds with
  how people work and other organisation)

### Outcome

#### Proposal 1

* Stop using it for now to avoid isolating ourselves and complicating things
* share our findings with the rest of the engineering team
* Adopt it if there is support

#### Proposal 2

* Keep using Radicle but only for antithesis CLI as there's a good possibility
  both could work well together
* Provide feedback to Radicle team (and possibly contribute?)
* Adopt it later if pain points are removed

#### Decision

1. We prepare a demo to the Engineering department on 2025-07-02
1. We keep using Radicle in the meantime on the 2 current repositories
1. We take a final decision after that



[radicle]: https://radicle.xyz

