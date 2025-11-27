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
  slides-url: "https://github.com/cardano-foundation/hal/tree/main/docs/crypto/zkpTraining1/slides.pdf", // use `none` to disable
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

#slide[
  = *Modular arithmetics (1)*

  #only((1,2))[
     It is about integers.
  ]

  #only((2))[
    Let's assume we arithmetics *mod 8*. It means the possible
    values are 0,1,2,3,4,5,6,7. if we move below or above we need to wrap up.
  ]

  #only((3,4))[
    $ 3 + 3 mod 8 = 6 mod 8 $
    $ 10 mod 8 = 2 mod 8 $
    $ 5 + 5 mod 8 = 2 mod 8 $
    $ 5 dot 5 mod 8 = 25 mod 8 = (3 dot 8 + 1) mod 8 = 1 mod 8 $
  ]

  #only((4))[
    #align(center)[#text(blue, size: 22pt)[congruent groups]]
 ]
]

#slide[
  = *Modular arithmetics (2)*

  #only((1))[
  ```j
addition mod 8    multiplication mod 8
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7
1 2 3 4 5 6 7 0     2 4 6 0 2 4 6
2 3 4 5 6 7 0 1     3 6 1 4 7 2 5
3 4 5 6 7 0 1 2     4 0 4 0 4 0 4
4 5 6 7 0 1 2 3     5 2 7 4 1 6 3
5 6 7 0 1 2 3 4     6 4 2 0 6 4 2
6 7 0 1 2 3 4 5     7 6 5 4 3 2 1
7 0 1 2 3 4 5 6
  ```
  ]

  #only((2))[
  ```j
addition mod 8    multiplication mod 8       Let's solve the eq in mod 8:
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7            9(2x + 7) − 6 ≡ 2x + 6
1 2 3 4 5 6 7 0     2 4 6 0 2 4 6
2 3 4 5 6 7 0 1     3 6 1 4 7 2 5
3 4 5 6 7 0 1 2     4 0 4 0 4 0 4
4 5 6 7 0 1 2 3     5 2 7 4 1 6 3
5 6 7 0 1 2 3 4     6 4 2 0 6 4 2
6 7 0 1 2 3 4 5     7 6 5 4 3 2 1
7 0 1 2 3 4 5 6
  ```
  ]

  #only((3))[
  ```j
addition mod 8    multiplication mod 8       Let's solve the eq in mod 8:
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7            9(2x + 7) − 6 ≡ 2x + 6
1 2 3 4 5 6 7 0     2 4 6 0 2 4 6            19*2x + 19*7 - 6 ≡ 2x + 6
2 3 4 5 6 7 0 1     3 6 1 4 7 2 5
3 4 5 6 7 0 1 2     4 0 4 0 4 0 4
4 5 6 7 0 1 2 3     5 2 7 4 1 6 3
5 6 7 0 1 2 3 4     6 4 2 0 6 4 2
6 7 0 1 2 3 4 5     7 6 5 4 3 2 1
7 0 1 2 3 4 5 6
  ```
  ]

  #only((4))[
  ```j
addition mod 8    multiplication mod 8       Let's solve the eq in mod 8:
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7            9(2x + 7) − 6 ≡ 2x + 6
1 2 3 4 5 6 7 0     2 4 6 0 2 4 6            19*2x + 19*7 - 6 ≡ 2x + 6
2 3 4 5 6 7 0 1     3 6 1 4 7 2 5            38x + 133 - 6 ≡ 2x + 6  # 133 mod 8 = 5
3 4 5 6 7 0 1 2     4 0 4 0 4 0 4
4 5 6 7 0 1 2 3     5 2 7 4 1 6 3
5 6 7 0 1 2 3 4     6 4 2 0 6 4 2
6 7 0 1 2 3 4 5     7 6 5 4 3 2 1
7 0 1 2 3 4 5 6
  ```
  ]

  #only((5))[
  ```j
addition mod 8    multiplication mod 8       Let's solve the eq in mod 8:
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7            9(2x + 7) − 6 ≡ 2x + 6
1 2 3 4 5 6 7 0     2 4 6 0 2 4 6            19*2x + 19*7 - 6 ≡ 2x + 6
2 3 4 5 6 7 0 1     3 6 1 4 7 2 5            38x + 133 - 6 ≡ 2x + 6  # 133 mod 8 = 5
3 4 5 6 7 0 1 2     4 0 4 0 4 0 4            6x + 5 - 6 ≡ 2x + 6
4 5 6 7 0 1 2 3     5 2 7 4 1 6 3
5 6 7 0 1 2 3 4     6 4 2 0 6 4 2
6 7 0 1 2 3 4 5     7 6 5 4 3 2 1
7 0 1 2 3 4 5 6
  ```
  ]

  #only((6))[
  ```j
addition mod 8    multiplication mod 8       Let's solve the eq in mod 8:
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7            9(2x + 7) − 6 ≡ 2x + 6
1 2 3 4 5 6 7 0     2 4 6 0 2 4 6            19*2x + 19*7 - 6 ≡ 2x + 6
2 3 4 5 6 7 0 1     3 6 1 4 7 2 5            38x + 133 - 6 ≡ 2x + 6  # 133 mod 8 = 5
3 4 5 6 7 0 1 2     4 0 4 0 4 0 4            6x + 5 - 6 ≡ 2x + 6
4 5 6 7 0 1 2 3     5 2 7 4 1 6 3            6x + 5 - 6 + 6 ≡ 2x + 6 + 6
5 6 7 0 1 2 3 4     6 4 2 0 6 4 2
6 7 0 1 2 3 4 5     7 6 5 4 3 2 1
7 0 1 2 3 4 5 6
  ```
  ]

  #only((7))[
  ```j
addition mod 8    multiplication mod 8       Let's solve the eq in mod 8:
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7            9(2x + 7) − 6 ≡ 2x + 6
1 2 3 4 5 6 7 0     2 4 6 0 2 4 6            19*2x + 19*7 - 6 ≡ 2x + 6
2 3 4 5 6 7 0 1     3 6 1 4 7 2 5            38x + 133 - 6 ≡ 2x + 6  # 133 mod 8 = 5
3 4 5 6 7 0 1 2     4 0 4 0 4 0 4            6x + 5 - 6 ≡ 2x + 6
4 5 6 7 0 1 2 3     5 2 7 4 1 6 3            6x + 5 - 6 + 6 ≡ 2x + 6 + 6
5 6 7 0 1 2 3 4     6 4 2 0 6 4 2            6x + 5 ≡ 2x + 4  # 12 mod 8 = 4
6 7 0 1 2 3 4 5     7 6 5 4 3 2 1            6x - 2x + 5 - 5 ≡ 2x - 2x + 4 - 5
7 0 1 2 3 4 5 6
  ```
  ]

  #only((8))[
  ```j
addition mod 8    multiplication mod 8       Let's solve the eq in mod 8:
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7            9(2x + 7) − 6 ≡ 2x + 6
1 2 3 4 5 6 7 0     2 4 6 0 2 4 6            19*2x + 19*7 - 6 ≡ 2x + 6
2 3 4 5 6 7 0 1     3 6 1 4 7 2 5            38x + 133 - 6 ≡ 2x + 6  # 133 mod 8 = 5
3 4 5 6 7 0 1 2     4 0 4 0 4 0 4            6x + 5 - 6 ≡ 2x + 6
4 5 6 7 0 1 2 3     5 2 7 4 1 6 3            6x + 5 - 6 + 6 ≡ 2x + 6 + 6
5 6 7 0 1 2 3 4     6 4 2 0 6 4 2            6x + 5 ≡ 2x + 4  # 12 mod 8 = 4
6 7 0 1 2 3 4 5     7 6 5 4 3 2 1            6x - 2x + 5 - 5 ≡ 2x - 2x + 4 - 5
7 0 1 2 3 4 5 6
  ```
  ]

  #only((9))[
  ```j
addition mod 8    multiplication mod 8       Let's solve the eq in mod 8:
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7            9(2x + 7) − 6 ≡ 2x + 6
1 2 3 4 5 6 7 0     2 4 6 0 2 4 6            19*2x + 19*7 - 6 ≡ 2x + 6
2 3 4 5 6 7 0 1     3 6 1 4 7 2 5            38x + 133 - 6 ≡ 2x + 6  # 133 mod 8 = 5
3 4 5 6 7 0 1 2     4 0 4 0 4 0 4            6x + 5 - 6 ≡ 2x + 6
4 5 6 7 0 1 2 3     5 2 7 4 1 6 3            6x + 5 - 6 + 6 ≡ 2x + 6 + 6
5 6 7 0 1 2 3 4     6 4 2 0 6 4 2            6x + 5 ≡ 2x + 4  # 12 mod 8 = 4
6 7 0 1 2 3 4 5     7 6 5 4 3 2 1            6x - 2x + 5 - 5 ≡ 2x - 2x + 4 - 5
7 0 1 2 3 4 5 6                                    4x ≡ 7  # -1 mod 8 = 7
  ```

#align(center)[#text(blue, size: 18pt)[
   Now we do *NOT have multiplication inverse* for 4, ie. we cannot divide by 4 in modulo 8, ie. solve this equation
   We have only multiplication inverse for 1 which is 1; 3 which is 3; 5 which is 5, and 7 which is 7.]
  ]
  ]
]

#friendly.last-slide(
  title: [That's it! More to come in the future],
  project-url: "https://github.com/cardano-foundation/hal/tree/main/docs/crypto/zkpTraining1/slides.pdf",
  qr-caption: text(font: "Excalifont")[My notes on GitHub],
  contact-appeal: [Get in touch #emoji.hand.wave],
  // leave out any of the following if they don't apply to you:
)
