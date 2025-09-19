# Interviews

## Introduction

The aim of these interviews was to get each teammember's view on:

1) how certain things are, in fact, currently done (for the handbook)
2) what could be improved (for continuous improvement)

The interviews were carried out individually during August and September 2025.

In this document, the individual answers have been either merged or
concatenated in a random order.

## Open questions

**Before we start, is there a topic that you think is important ?**

The team's roadmap. The long-term roadmap is not clear. Maybe we could align
with CF's Tactical Implementation Plan? The team leader should define the
roadmap, with input from team members.

How do we know what we need to do and whether we are making progress in the
right direction? This is critical for us because we don't work on clear
products with an obvious direction.

Having time for exploring/research/personal projects (like Google Friday).

**What are the best things about our team, processes, tools, etc?**

- There is a routine and cadence (weekly meetings etc.)
- Pair and mob programming
- Distributed (work from home)
- Many decisions are collegial
- Decent human beings
- No bad feelings
- Good culture of automated testing
- Haskell

**What are the worst things about our team, processes, tools, etc?**

- Team mission and goals not clear
- We don't work in small steps, deliver and gather feedback, including from
  external sources, before continuing (too much goldplating).
- Complexity and profusion (code, tools, channels, repositories...)
- Low productivity
- Feeling of superiority, low curiosity for what others do.
- No product owners
- Lack of interaction with rest of organisation.

## Stack

**Which software stack do you prefer working with?**

- All (5) teammembers like working with Haskell
- 3 think Nix is a good addition but 2 would rather not use Nix
- 3 are also happy to work with Rust

**How do you choose the stack for a project?**

Not clear. I start with something I think right, and it can get challenged by
others.

Depends on what we are trying to do and level of openness wanted. For
executables and not expecting contributions, use Haskell. For libraries and
encouraging external contributions, use Rust.

Sometimes, availability of a particular library can tip the balance. Otherwise,
just stick to favourite stack. I'm open to changing to new languages.

According to the team's skills and preferences.

I don't think we should adapt stacks to projects. The stack should match the
developers's skills and motivations. Excellence is achieved by being familiar
with one stack. I think everything can and should be done in Haskell, and where
necessary, a thin adapter/API provided for compatibility with other ecosystems.

**What OS do you use to develop?**

- 3 use Linux
- 3 use Mac OS

**How could our stack(s) be improved?**

+ Use Zig
+ No JavaScript or TypeScript
+ Remove dependency on Nix and make it optional.
+ Provide other entry points (Dockerfile, Makefile)
+ By being simplified (using fewer layers, tools, languages, libraries...)
+ Add automated, external CI
+ Make it uniform throughout the team

## Design

**How are the products designed ?**

Ad hoc. 

Depends on the product. Have used DDD, formal methods... but nothing is used
consistently. We are always in a rush, and it is not clear what we should
build. 

MPFS/anti-cli were designed by Paolo. On the wallet we used to have "product
people". Collective discussions (mostly inside team) identify ideas for
features. Might consult external people if appropriate.

There is no product owner or formal product design process. Ideas appear either
from within the team or suggested by users or stakeholders.

Ah hoc, undocumented, a person is usually in charge, follow path of least
resistance, without seeking much feedback.

**How is the code designed ?**

Ad hoc (evolves through refactoring after observing problems). Mob programming.
We have the Advise process.

It depends. Try to separate interface and implementation. Try to use monadic
code. Search for a balance and take the team's culture into account, so avoid
type classes for example. There are discussions about design with some team
members.

Ad hoc. Occasional discussions or diagrams. The wallet was poorly designed, for
many reasons including historical.

Ad hoc.

**How could the code be improved ?**

Continue (or increase) mob programming.

+ The design (use cases and architecture) should be better documented before we start to code.
+ Everyone involved should participate.
+ There should be design tickets. 

Start with a high-level plan/design of the product documented and seek feedback
early. Define a minimal journey. Add story mapping.

More use of TDD would be a game changer.

+ Have product owners,
+ write documentation first (start from a user perspective),
+ have a quick team discussion before writing new code,
+ write tests first (this is a design step),
+ more refactoring,
+ establish team conventions.

Start from user experience. Spend more time on formal design. Have a product
owner (with an outside perspective).

## Code

**Which code editor or IDE do you use?**

- 2 Neovim
- 2 Emacs
- 1 VS Code

**Do you follow a personal style or do you follow guidelines?**

Try to stick with whatever guidelines (when they exist) or existing code.

Just follow style of cardano-wallet. Use provided formatting command.

Imitate the wallet's style guide and use fourmolu. Used to have debates during
code reviews and hated it. What I care most about is having operators at
beginning of the line and avoid nested parenthesis. What's paramount is that
it's automated and I don't have to think about it.

Imitate existing code. Happy to adjust.

**Do you use code completion?**

- 3 answered yes
- 1 answered sometimes (to avoid becoming dependent)
- 1 answered no

**Do you use AI? How?**

As much as possible. Wish I could use more but not great for Haskell. Used Code
Pilot. Also use Aider. AI is great for boilerplate.

Not integrated. Sometimes copy/paste from ChatGPT, mostly for scaffolding new
stuff.

Use all warnings, linters etc. Use Code Pilot (integrated in IDE). Sometimes
additionally query an AI to get started on a new tool/language/library.

Experimenting but not yet settled.

No.

**What do you think of the quality of our code?**

It seems unnecessarily complex and verbose, and is neither self-explanatory nor
well-commented.

There is an excessive volume of code. Tendency to write too much unneeded
features and verbose code.

+ Average.
+ Cardano-wallet code is not good: wrong abstractions, too much type trickery, fragile.
+ Over-reliance on integration tests (slow, hard to write+maintain, flaky, too detailed)
+ Good aspects: it is mostly well-tested and typesafe; failures paths clear.

Quite good, but room for improvement, especially module structure. If the
structure is good and there are enough types, reduces need for comments.

Depends on repo. Anti-CLI is high quality. The worst is cardano-wallet (for
historical reasons).

**How could we improve our code?**

+ Use TDD more, and properties.
+ Have team coding guidelines
+ Guidelines should not just be about formatting, it's more important to have
  guidelines about naming, which extensions or features we use, what idioms we
  favour etc.

More code reviews, either asynchronously or mob.

+ Mob programming (better quality and consistency).
* Use more golden tests. Keep things determistic.

Spending more time on refactoring.

+ Have a quick team discussion before writing new code,
+ write tests first,
+ more refactoring,
+ establish team conventions.

## Version control

**Currently, what is your Git workflow?**

Not happy about commit quality. Don't care too much about branches etc.
Often just work on main, use branch if unsure of where I'm going on, might
throw away, or I want someone to review.

+ Start on main then create branch if takes a long time.
+ Commit frequency varies.
+ Commit history varies (sometimes squash, sometimes detailed).
+ Don't see the need to be too pedantic about the history. Prefer simple, squashed history.

I work on a short-lived "feature" branch, rebase often from main, commit often,
and submit to review/merge.

+ Pull from main;
+ create work branch;
+ commit to to the branch (using labelling conventions);
+ rebase from main until ready to merge;
+ avoid long-lived branches;
+ make PR/patch for review;
+ merge as quickly as possible;
+ slight preference for squashing commits when merge to main.

I create a feature branch (from main or other WIP). Push PR/patch to merge.
Branches typically last one day but sometimes more.

**What do you think of TBD?**

Not sure I know what it is.

No strong opinion (not familiar/convinced).

Don't care too much but TBD fits me well.

I'm in favour. We should do it.

I think TBD is the best approach if we want to work collectively.

**What do you think of Radicle?**

I really like it. Requires building a new mental model. Really like flexibility
and the fact that issues/patches are in the same tool. Very friendly community.
Impedance match with Cardano, potential to combine them in interesting ways.

It adds complexity and brings no intrinsic value. I would rather stop using it
unless we actually leave GitHub completely.

Not sure it's a good idea to split off from GitHub. If in doubt stick to
GitHub. But it's cool.

Mostly but not completely sold. Some problems should be solved, e.g. having a
canonical branch.

I like the idea. But I miss GitHub reviews. We should keep GitHub for reviews
and for visibility. Maybe keep a mixture of both, decide according to project.

**How could we improve the way we do version control?**

Reduce lifespan of branches (smaller more frequent).

+ Better quality commits (compiles+formatted) and better commit messages.
+ Use [stgit][StGit].

Use TBD if we want to work collectively. Alternatively, use branches and PR's
if we designate repo owners ([DRI][DRI]), but in that case standardize and
document the workflow.

+ Use TBD.
+ Maybe use (or take inspiration from):
  - [Code Rabbit][CodeRabbit] (this is Github centric)
  - [Gerrit][Gerrit] (best with TBD)

## Testing

**How do you test the software?**

Using properties (QuickCheck) and end-to-end tests. Based on experience. Mostly
automated. Sometimes before the code (TDD), sometimes after experimenting.

It depends. If it's easy will write end-to-end tests first. Important that
tests are readable. Tests should be documentation/specification. Don't always
write unit tests, but will use QuickCheck for algorithmic code. Productivity
more important than having bug-free code. Property tests do not replace unit
tests because unit tests are more explicit about what is broken. Property-based
testing is not good at documenting.

1. Develop with TDD.
2. Try to test *as a user*. I like to deploy and run the software continuously,
   and actually use it.

I practice test-driven-development (TDD), with HSpec and QuickCheck.

+ In Haskell, I use HSpec at least, QuickCheck sometimes.
+ I use "almost end-to-end" golden tests (input and expected output).
+ I mostly write tests after having an initial version working.
+ I might use TDD occasionally if it's clear and specific what I need.

**How could testing be improved?**

We are quite good. But testing might be better if designs were more formalised.

Using free monads and writing DSL's for the tests. Having external independent
QA.

Focus less on complex end-to-end automation and more on using it. This goes
with frequently releasing minimal but usable increments.

Extend TDD to documentation (README's and manuals should be written first and
be executable, e.g. [Cram][Cram]).

## Documentation

**How is documentation written?**

It is often outdated.

Haddock comments if it's a library. Otherwise, not sure how they are written.
Worried that documentation gets out of date and therefore aim to make things
simple enough to not need documentation. Generated documentation is annoying
and duplicated. Manual CLI documentation always out-of-date.

There is no formal process. We mostly seem to write documentation after code
and it's incomplete and out of date.

There is some documentation, but it's only done when the team leader asks for
it. 

**How could documentation be improved?**

A lot of room for improvement.

We should try and engage with users (start with "friendlier" ones).
Documentation is an integral part of the software, so treat it the same way as
the code (write it along with the code, small steps, seek feedback, refine).

1. establish guidelines for what documentation is needed.
2. write documentation first and as an executable specification.

We need to have people (preferably external like QA) reading documentation.
Would be even better to have an antagonist role earlier. Better if external
because internally within team creates tensions.

## Organisation

**What do you think of the current organisation (meetings, planning,
communication)?**

+ I like the current organisation (meeting/planning).
+ We should take care to avoid the situation where only one person has a
  complete understanding of a project.
+ I like occasional pairing sessions but they should be more diversified
+ Sometimes I prefer working alone on some things that need careful thought.

One weekly planning meeting is good. Good that it's lead by Arnaud (not
rotating secretary like before). 

+ I like that it's quite collegial and there is minimal red tape
+ I like that everyone seems to feel free to speak up
+ I think we do not communicate very effectively
+ I feel we lack conventions, guidelines, handbooks, a team culture.
+ I am confused by the profusion of channels we use to communicate and track
  work.

I miss stand-ups. Don't care about all the rest.

I have become wary of daily standups, so I like the fact that we are doing it
asynchronously. I think the weekly planning meeting is good, except when it
degenerates into a status report, or just following the momentum. We have not
quite found the recipe for monthly planning (maybe a quarterly workshop would
be better?)

**What do you think of the asynchronous approach presented by Darren Murph?**

A lot of smart ideas. I would need to refresh my memory about it.

I find it appealing, convincing and I think it would suit me.

Don't remember it. Not sure I buy the idea that anyone can pick up anything
anywhere. Seems opposite to mob programming. But obviously includes some good
advice.

Generally positive, it's a good approach, there are many ideas we could adopt
easiy (e.g. information sharing should be asynchronous)

Not really sold. For example, although some meetings can be a waste of time, it
can also be really productive to have meetings, even if improvised and without
an agenda. Would be worried about the lack of personal contact. Does not fit
the way normal people actually behave.

**Do you have any suggestions about organisation?**

+ Maybe we should adopt some or all of [The Core Protocols][Core] (or even
  organize a boot camp).
+ The team should own the weekly meeting and use it for its needs, and for
  getting feedback, more collective self-reflection.
+ Burden of communicating to outside (on what we are doing, why and our
  progress) could be shared by the team rather than left to team leader.
+ Would love to see a more lively slack channel.
+ Avoid having team members in multiple timezones.
+ Avoid having separate workstreams (at least not one per person, or not all
  the time).
+ Have regular and longer team "residential workshops" (like Albi in 2019),
  e.g. two weeks every quarter.
+ It feels as though we are striving to be more like a colocated team, but we
  are finding it hard. Maybe we should embrace the way successful fully remote
  teams like [GitLab][Async] and [37signals][37sig] work.

[CodeRabbit]: https://www.coderabbit.ai/
[Gerrit]: https://www.gerritcodereview.com/
[Cram]: https://bitheap.org/cram/
[37sig]: https://basecamp.com/handbook/how-we-work
[Async]: https://handbook.gitlab.com/handbook/company/culture/all-remote/non-linear-workday/
[Core]: https://thecoreprotocols.org/
[DRI]: https://handbook.gitlab.com/handbook/people-group/directly-responsible-individuals/
[StGit]: https://stacked-git.github.io/

