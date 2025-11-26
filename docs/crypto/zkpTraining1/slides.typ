#import "@preview/polylux:0.4.0": *
#import "@preview/pinit:0.2.2": *
#import "@preview/friendly-polylux:0.1.0" as friendly
#import friendly: titled-block

#show: friendly.setup.with(
  short-title: [ZKP - part 1],
  short-speaker: [Pawel Jakubas],
)

#set text(size: 30pt, font: "Andika")
#show raw: set text(font: "Fantasque Sans Mono")
#show math.equation: set text(font: "Lete Sans Math")

#friendly.title-slide(
  title: [Zero-knowledge-proofs - part 1],
  speaker: [Pawel Jakubas],
  conference: [Engineering workshop - Dec 2025 (Ireland)],
  speaker-website: none, // use `none` to disable
  slides-url: "URL to slides", // use `none` to disable
  qr-caption: text(font: "Excalifont")[Get these slides],
  logo: (image("assets/typst.png"), image("assets/Cardano-RGB_Logo-Icon-Blue.png", width: 40%, fit: "contain")).join(),
)

#slide[
  = Plan of the tutorial

  #show: later
  Let's get a little deeper than usual and understand
  what main building blocks of ZKP looks like

  This tutorial will focus on

  #show: later
   1. sketching the landscape
      of what we want to understand during 3-4 parts

  #show: later
   2. cover the first part in some detail
      *elliptic curves*
]

#slide[
  = Verifiable computing vs ZKP (1)

  #show: later
  There is *asymmetry* built into those systems.
  It is much easy to get public key from secret.
  But not the other way

  #only((:))[
    #grid(
      columns: (1fr, 2fr, 1fr),
      rows: (auto),
      gutter: 3pt,
      circle(fill: rgb("e4e5ea"),
            [#set align(center + horizon)
             Prover]),
      grid.cell(simple-arrow(end: (350pt, 0pt)), align: center, inset: 30%),
      circle(fill: rgb("e4e5ea"),
             [#set align(center + horizon)
              Verifier])
      )
  ]

  #only((3))[
    #align(left)[
      #text(blue)[secret -> (easy) -> public]
    ]
  ]

  #only((4))[
    #align(center)[
      #text(blue)[proof + public data shared]
    ]
  ]

  #only((5))[
    #align(right)[
      #text(blue)[public -> (very hard) -> secret]
    ]
  ]

  #only((6))[
    #align(right)[
      #text(blue)[proof verified using public data]
    ]
  ]
]

#slide[
  = Verifiable computing vs ZKP (2)

  There is *asymmetry* built into those systems.
  It is much quicker to verify than prove something.

  #only((:))[
    #grid(
      columns: (1fr, 2fr, 1fr),
      rows: (auto),
      gutter: 3pt,
      circle(fill: rgb("e4e5ea"),
            [#set align(center + horizon)
             Prover]),
      grid.cell(simple-arrow(end: (350pt, 0pt)), align: center, inset: 30%),
      circle(fill: rgb("e4e5ea"),
             [#set align(center + horizon)
              Verifier])
      )
  ]

  #only((beginning: 2))[
    #align(left)[
      #text(blue, size: 22pt)[O(n) off-chain]
    ]
  ]

  #only((3))[
    #align(right)[
      #text(blue, size: 22pt)[O(log n) on-chain]
    ]
  ]
]

#slide[
  = *ZKP* (3)

  Data sent to verifier is compressed, and can be hidden

  #only((:))[
    #grid(
      columns: (1fr, 2fr, 1fr),
      rows: (auto),
      gutter: 3pt,
      circle(fill: rgb("e4e5ea"),
            [#set align(center + horizon)
             Prover]),
      grid.cell(simple-arrow(end: (350pt, 0pt)), align: center, inset: 30%),
      circle(fill: rgb("e4e5ea"),
             [#set align(center + horizon)
              Verifier])
      )
  ]

  #only((beginning: 2))[
    #align(left)[
      #text(blue, size: 22pt)[size: n]
    ]
  ]

  #only((beginning: 3))[
    #align(center)[
      #text(blue, size: 22pt)[size: at least log n]
    ]
  ]

  #only((4))[
    #align(right)[
      #text(blue, size: 22pt)[size: at least log n]
    ]
  ]
]

#friendly.last-slide(
  title: [That's it! More to come in the future],
  project-url: "URL to project",
  qr-caption: text(font: "Excalifont")[My notes on GitHub],
  contact-appeal: [Get in touch #emoji.hand.wave],
  // leave out any of the following if they don't apply to you:
)
