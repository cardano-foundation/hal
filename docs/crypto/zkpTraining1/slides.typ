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

  #show raw: it => block(
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 5pt,
    text(fill: rgb("#a2aabc"), it)
  )

  #show raw.where(block: true): set text(1em / 1.5)

  #only((1))[
  ```j
addition mod 8      multiplication mod 8
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
addition mod 8      multiplication mod 8               Let's solve the eq in mod 8:
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7                      9(2x + 7) − 6 ≡ 2x + 6
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
addition mod 8      multiplication mod 8               Let's solve the eq in mod 8:
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7                      9(2x + 7) − 6 ≡ 2x + 6
1 2 3 4 5 6 7 0     2 4 6 0 2 4 6                      19*2x + 19*7 - 6 ≡ 2x + 6
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
addition mod 8      multiplication mod 8               Let's solve the eq in mod 8:
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7                      9(2x + 7) − 6 ≡ 2x + 6
1 2 3 4 5 6 7 0     2 4 6 0 2 4 6                      19*2x + 19*7 - 6 ≡ 2x + 6
2 3 4 5 6 7 0 1     3 6 1 4 7 2 5                      38x + 133 - 6 ≡ 2x + 6  # 133 mod 8 = 5
3 4 5 6 7 0 1 2     4 0 4 0 4 0 4
4 5 6 7 0 1 2 3     5 2 7 4 1 6 3
5 6 7 0 1 2 3 4     6 4 2 0 6 4 2
6 7 0 1 2 3 4 5     7 6 5 4 3 2 1
7 0 1 2 3 4 5 6
  ```
  ]

  #only((5))[
  ```j
addition mod 8      multiplication mod 8               Let's solve the eq in mod 8:
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7                      9(2x + 7) − 6 ≡ 2x + 6
1 2 3 4 5 6 7 0     2 4 6 0 2 4 6                      19*2x + 19*7 - 6 ≡ 2x + 6
2 3 4 5 6 7 0 1     3 6 1 4 7 2 5                      38x + 133 - 6 ≡ 2x + 6  # 133 mod 8 = 5
3 4 5 6 7 0 1 2     4 0 4 0 4 0 4                      6x + 5 - 6 ≡ 2x + 6
4 5 6 7 0 1 2 3     5 2 7 4 1 6 3
5 6 7 0 1 2 3 4     6 4 2 0 6 4 2
6 7 0 1 2 3 4 5     7 6 5 4 3 2 1
7 0 1 2 3 4 5 6
  ```
  ]

  #only((6))[
  ```j
addition mod 8      multiplication mod 8               Let's solve the eq in mod 8:
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7                      9(2x + 7) − 6 ≡ 2x + 6
1 2 3 4 5 6 7 0     2 4 6 0 2 4 6                      19*2x + 19*7 - 6 ≡ 2x + 6
2 3 4 5 6 7 0 1     3 6 1 4 7 2 5                      38x + 133 - 6 ≡ 2x + 6  # 133 mod 8 = 5
3 4 5 6 7 0 1 2     4 0 4 0 4 0 4                      6x + 5 - 6 ≡ 2x + 6
4 5 6 7 0 1 2 3     5 2 7 4 1 6 3                      6x + 5 - 6 + 6 ≡ 2x + 6 + 6
5 6 7 0 1 2 3 4     6 4 2 0 6 4 2
6 7 0 1 2 3 4 5     7 6 5 4 3 2 1
7 0 1 2 3 4 5 6
  ```
  ]

  #only((7))[
  ```j
addition mod 8      multiplication mod 8               Let's solve the eq in mod 8:
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7                      9(2x + 7) − 6 ≡ 2x + 6
1 2 3 4 5 6 7 0     2 4 6 0 2 4 6                      19*2x + 19*7 - 6 ≡ 2x + 6
2 3 4 5 6 7 0 1     3 6 1 4 7 2 5                      38x + 133 - 6 ≡ 2x + 6  # 133 mod 8 = 5
3 4 5 6 7 0 1 2     4 0 4 0 4 0 4                      6x + 5 - 6 ≡ 2x + 6
4 5 6 7 0 1 2 3     5 2 7 4 1 6 3                      6x + 5 - 6 + 6 ≡ 2x + 6 + 6
5 6 7 0 1 2 3 4     6 4 2 0 6 4 2                      6x + 5 ≡ 2x + 4  # 12 mod 8 = 4
6 7 0 1 2 3 4 5     7 6 5 4 3 2 1                      6x - 2x + 5 - 5 ≡ 2x - 2x + 4 - 5
7 0 1 2 3 4 5 6
  ```
  ]

  #only((8))[
  ```j
addition mod 8      multiplication mod 8               Let's solve the eq in mod 8:
0 1 2 3 4 5 6 7     1 2 3 4 5 6 7                      9(2x + 7) − 6 ≡ 2x + 6
1 2 3 4 5 6 7 0     2 4 6 0 2 4 6                      19*2x + 19*7 - 6 ≡ 2x + 6
2 3 4 5 6 7 0 1     3 6 1 4 7 2 5                      38x + 133 - 6 ≡ 2x + 6  # 133 mod 8 = 5
3 4 5 6 7 0 1 2     4 0 4 0 4 0 4                      6x + 5 - 6 ≡ 2x + 6
4 5 6 7 0 1 2 3     5 2 7 4 1 6 3                      6x + 5 - 6 + 6 ≡ 2x + 6 + 6
5 6 7 0 1 2 3 4     6 4 2 0 6 4 2                      6x + 5 ≡ 2x + 4  # 12 mod 8 = 4
6 7 0 1 2 3 4 5     7 6 5 4 3 2 1                      6x - 2x + 5 - 5 ≡ 2x - 2x + 4 - 5
7 0 1 2 3 4 5 6                                        4x ≡ 7  # -1 mod 8 = 7
  ```

#align(center)[#text(blue, size: 20pt)[
   Now we do *NOT have multiplication inverse* for 4, ie. we cannot divide by 4 in modulo 8, ie. solve this equation
   We have only multiplication inverse for 1 which is 1; 3 which is 3; 5 which is 5, and 7 which is 7.]
  ]
  ]
]

#slide[
  = *Modular arithmetics (3)*

  #show raw: it => block(
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 5pt,
    text(fill: rgb("#a2aabc"), it)
  )

  #show raw.where(block: true): set text(1em / 1.5)

  #only((1))[
  ```j
addition mod 11                                    multiplication mod 11
 0  1  2  3  4  5  6  7  8  9 10                   1  2  3  4  5  6  7  8  9 10
 1  2  3  4  5  6  7  8  9 10  0                   2  4  6  8 10  1  3  5  7  9
 2  3  4  5  6  7  8  9 10  0  1                   3  6  9  1  4  7 10  2  5  8
 3  4  5  6  7  8  9 10  0  1  2                   4  8  1  5  9  2  6 10  3  7
 4  5  6  7  8  9 10  0  1  2  3                   5 10  4  9  3  8  2  7  1  6
 5  6  7  8  9 10  0  1  2  3  4                   6  1  7  2  8  3  9  4 10  5
 6  7  8  9 10  0  1  2  3  4  5                   7  3 10  6  2  9  5  1  8  4
 7  8  9 10  0  1  2  3  4  5  6                   8  5  2 10  7  4  1  9  6  3
 8  9 10  0  1  2  3  4  5  6  7                   9  7  5  3  1 10  8  6  4  2
 9 10  0  1  2  3  4  5  6  7  8                   10  9  8  7  6  5  4  3  2  1
10  0  1  2  3  4  5  6  7  8  9
  ```
  ]

  #only((2))[
  ```j
addition mod 11                                    multiplication mod 11                Let's solve in mod 11:
 0  1  2  3  4  5  6  7  8  9 10                   1  2  3  4  5  6  7  8  9 10         19(2x + 7) − 6 ≡ 2x + 6
 1  2  3  4  5  6  7  8  9 10  0                   2  4  6  8 10  1  3  5  7  9
 2  3  4  5  6  7  8  9 10  0  1                   3  6  9  1  4  7 10  2  5  8
 3  4  5  6  7  8  9 10  0  1  2                   4  8  1  5  9  2  6 10  3  7
 4  5  6  7  8  9 10  0  1  2  3                   5 10  4  9  3  8  2  7  1  6
 5  6  7  8  9 10  0  1  2  3  4                   6  1  7  2  8  3  9  4 10  5
 6  7  8  9 10  0  1  2  3  4  5                   7  3 10  6  2  9  5  1  8  4
 7  8  9 10  0  1  2  3  4  5  6                   8  5  2 10  7  4  1  9  6  3
 8  9 10  0  1  2  3  4  5  6  7                   9  7  5  3  1 10  8  6  4  2
 9 10  0  1  2  3  4  5  6  7  8                   10  9  8  7  6  5  4  3  2  1
10  0  1  2  3  4  5  6  7  8  9
  ```
  ]

  #only((3))[
  ```j
addition mod 11                                    multiplication mod 11                Let's solve in mod 11:
 0  1  2  3  4  5  6  7  8  9 10                   1  2  3  4  5  6  7  8  9 10         19(2x + 7) − 6 ≡ 2x + 6
 1  2  3  4  5  6  7  8  9 10  0                   2  4  6  8 10  1  3  5  7  9         19*2x + 19*7 - 6 ≡ 2x + 6
 2  3  4  5  6  7  8  9 10  0  1                   3  6  9  1  4  7 10  2  5  8
 3  4  5  6  7  8  9 10  0  1  2                   4  8  1  5  9  2  6 10  3  7
 4  5  6  7  8  9 10  0  1  2  3                   5 10  4  9  3  8  2  7  1  6
 5  6  7  8  9 10  0  1  2  3  4                   6  1  7  2  8  3  9  4 10  5
 6  7  8  9 10  0  1  2  3  4  5                   7  3 10  6  2  9  5  1  8  4
 7  8  9 10  0  1  2  3  4  5  6                   8  5  2 10  7  4  1  9  6  3
 8  9 10  0  1  2  3  4  5  6  7                   9  7  5  3  1 10  8  6  4  2
 9 10  0  1  2  3  4  5  6  7  8                   10  9  8  7  6  5  4  3  2  1
10  0  1  2  3  4  5  6  7  8  9
  ```
  ]

  #only((4))[
  ```j
addition mod 11                                    multiplication mod 11                Let's solve in mod 11:
 0  1  2  3  4  5  6  7  8  9 10                   1  2  3  4  5  6  7  8  9 10         19(2x + 7) − 6 ≡ 2x + 6
 1  2  3  4  5  6  7  8  9 10  0                   2  4  6  8 10  1  3  5  7  9         19*2x + 19*7 - 6 ≡ 2x + 6
 2  3  4  5  6  7  8  9 10  0  1                   3  6  9  1  4  7 10  2  5  8         5x + 1 - 6 ≡ 2x + 6
 3  4  5  6  7  8  9 10  0  1  2                   4  8  1  5  9  2  6 10  3  7
 4  5  6  7  8  9 10  0  1  2  3                   5 10  4  9  3  8  2  7  1  6
 5  6  7  8  9 10  0  1  2  3  4                   6  1  7  2  8  3  9  4 10  5
 6  7  8  9 10  0  1  2  3  4  5                   7  3 10  6  2  9  5  1  8  4
 7  8  9 10  0  1  2  3  4  5  6                   8  5  2 10  7  4  1  9  6  3
 8  9 10  0  1  2  3  4  5  6  7                   9  7  5  3  1 10  8  6  4  2
 9 10  0  1  2  3  4  5  6  7  8                   10  9  8  7  6  5  4  3  2  1
10  0  1  2  3  4  5  6  7  8  9
  ```
  ]

  #only((5))[
  ```j
addition mod 11                                    multiplication mod 11                Let's solve in mod 11:
 0  1  2  3  4  5  6  7  8  9 10                   1  2  3  4  5  6  7  8  9 10         19(2x + 7) − 6 ≡ 2x + 6
 1  2  3  4  5  6  7  8  9 10  0                   2  4  6  8 10  1  3  5  7  9         19*2x + 19*7 - 6 ≡ 2x + 6
 2  3  4  5  6  7  8  9 10  0  1                   3  6  9  1  4  7 10  2  5  8         5x + 1 - 6 ≡ 2x + 6
 3  4  5  6  7  8  9 10  0  1  2                   4  8  1  5  9  2  6 10  3  7         5x + 1 - 6 + 6 ≡ 2x + 6 + 6
 4  5  6  7  8  9 10  0  1  2  3                   5 10  4  9  3  8  2  7  1  6
 5  6  7  8  9 10  0  1  2  3  4                   6  1  7  2  8  3  9  4 10  5
 6  7  8  9 10  0  1  2  3  4  5                   7  3 10  6  2  9  5  1  8  4
 7  8  9 10  0  1  2  3  4  5  6                   8  5  2 10  7  4  1  9  6  3
 8  9 10  0  1  2  3  4  5  6  7                   9  7  5  3  1 10  8  6  4  2
 9 10  0  1  2  3  4  5  6  7  8                   10  9  8  7  6  5  4  3  2  1
10  0  1  2  3  4  5  6  7  8  9
  ```
  ]

  #only((6))[
  ```j
addition mod 11                                    multiplication mod 11                Let's solve in mod 11:
 0  1  2  3  4  5  6  7  8  9 10                   1  2  3  4  5  6  7  8  9 10         19(2x + 7) − 6 ≡ 2x + 6
 1  2  3  4  5  6  7  8  9 10  0                   2  4  6  8 10  1  3  5  7  9         19*2x + 19*7 - 6 ≡ 2x + 6
 2  3  4  5  6  7  8  9 10  0  1                   3  6  9  1  4  7 10  2  5  8         5x + 1 - 6 ≡ 2x + 6
 3  4  5  6  7  8  9 10  0  1  2                   4  8  1  5  9  2  6 10  3  7         5x + 1 - 6 + 6 ≡ 2x + 6 + 6
 4  5  6  7  8  9 10  0  1  2  3                   5 10  4  9  3  8  2  7  1  6         5x + 1 ≡ 2x + 1
 5  6  7  8  9 10  0  1  2  3  4                   6  1  7  2  8  3  9  4 10  5
 6  7  8  9 10  0  1  2  3  4  5                   7  3 10  6  2  9  5  1  8  4
 7  8  9 10  0  1  2  3  4  5  6                   8  5  2 10  7  4  1  9  6  3
 8  9 10  0  1  2  3  4  5  6  7                   9  7  5  3  1 10  8  6  4  2
 9 10  0  1  2  3  4  5  6  7  8                   10  9  8  7  6  5  4  3  2  1
10  0  1  2  3  4  5  6  7  8  9
  ```
  ]

  #only((7))[
  ```j
addition mod 11                                    multiplication mod 11                Let's solve in mod 11:
 0  1  2  3  4  5  6  7  8  9 10                   1  2  3  4  5  6  7  8  9 10         19(2x + 7) − 6 ≡ 2x + 6
 1  2  3  4  5  6  7  8  9 10  0                   2  4  6  8 10  1  3  5  7  9         19*2x + 19*7 - 6 ≡ 2x + 6
 2  3  4  5  6  7  8  9 10  0  1                   3  6  9  1  4  7 10  2  5  8         5x + 1 - 6 ≡ 2x + 6
 3  4  5  6  7  8  9 10  0  1  2                   4  8  1  5  9  2  6 10  3  7         5x + 1 - 6 + 6 ≡ 2x + 6 + 6
 4  5  6  7  8  9 10  0  1  2  3                   5 10  4  9  3  8  2  7  1  6         5x + 1 ≡ 2x + 1
 5  6  7  8  9 10  0  1  2  3  4                   6  1  7  2  8  3  9  4 10  5         x ≡ 0
 6  7  8  9 10  0  1  2  3  4  5                   7  3 10  6  2  9  5  1  8  4
 7  8  9 10  0  1  2  3  4  5  6                   8  5  2 10  7  4  1  9  6  3
 8  9 10  0  1  2  3  4  5  6  7                   9  7  5  3  1 10  8  6  4  2
 9 10  0  1  2  3  4  5  6  7  8                   10  9  8  7  6  5  4  3  2  1
10  0  1  2  3  4  5  6  7  8  9
  ```

#align(center)[#text(blue, size: 15pt)[
   We have solution: *{.., -22, -11, 0, 11, 22, ...}*
   As in each row of mult table there is 1 we have inverse for each congruence group!
  ]]
  ]
]

#slide[
  = *Modular arithmetics (4)*

  #show raw: it => block(
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 5pt,
    text(fill: rgb("#a2aabc"), it)
  )

  #show raw.where(block: true): set text(1em / 1.5)

  #only((1))[
      #grid(
      columns: (2fr, 1fr),
      rows: (auto),
      gutter: 3pt,
  ```j
addition mod 13                                    multiplication mod 13
 0  1  2  3  4  5  6  7  8  9 10 11 12            1  2  3  4  5  6  7  8  9 10 11 12
 1  2  3  4  5  6  7  8  9 10 11 12  0            2  4  6  8 10 12  1  3  5  7  9 11
 2  3  4  5  6  7  8  9 10 11 12  0  1            3  6  9 12  2  5  8 11  1  4  7 10
 3  4  5  6  7  8  9 10 11 12  0  1  2            4  8 12  3  7 11  2  6 10  1  5  9
 4  5  6  7  8  9 10 11 12  0  1  2  3            5 10  2  7 12  4  9  1  6 11  3  8
 5  6  7  8  9 10 11 12  0  1  2  3  4            6 12  5 11  4 10  3  9  2  8  1  7
 6  7  8  9 10 11 12  0  1  2  3  4  5            7  1  8  2  9  3 10  4 11  5 12  6
 7  8  9 10 11 12  0  1  2  3  4  5  6            8  3 11  6  1  9  4 12  7  2 10  5
 8  9 10 11 12  0  1  2  3  4  5  6  7            9  5  1 10  6  2 11  7  3 12  8  4
 9 10 11 12  0  1  2  3  4  5  6  7  8            10  7  4  1 11  8  5  2 12  9  6  3
10 11 12  0  1  2  3  4  5  6  7  8  9            11  9  7  5  3  1 12 10  8  6  4  2
11 12  0  1  2  3  4  5  6  7  8  9 10            12 11 10  9  8  7  6  5  4  3  2  1
12  0  1  2  3  4  5  6  7  8  9 10 11
  ```
        , text(blue)[As in each row of mult table there is 1 we have inverse for each congruence group! => we want to work with mod *PRIME* as we want inverses!]
    )
  ]

  #only((2))[
      #grid(
      columns: (2fr, 1fr),
      rows: (auto),
      gutter: 3pt,
  ```j
addition mod 13                                    multiplication mod 13
 0  1  2  3  4  5  6  7  8  9 10 11 12            1  2  3  4  5  6  7  8  9 10 11 12
 1  2  3  4  5  6  7  8  9 10 11 12  0            2  4  6  8 10 12  1  3  5  7  9 11
 2  3  4  5  6  7  8  9 10 11 12  0  1            3  6  9 12  2  5  8 11  1  4  7 10
 3  4  5  6  7  8  9 10 11 12  0  1  2            4  8 12  3  7 11  2  6 10  1  5  9
 4  5  6  7  8  9 10 11 12  0  1  2  3            5 10  2  7 12  4  9  1  6 11  3  8
 5  6  7  8  9 10 11 12  0  1  2  3  4            6 12  5 11  4 10  3  9  2  8  1  7
 6  7  8  9 10 11 12  0  1  2  3  4  5            7  1  8  2  9  3 10  4 11  5 12  6
 7  8  9 10 11 12  0  1  2  3  4  5  6            8  3 11  6  1  9  4 12  7  2 10  5
 8  9 10 11 12  0  1  2  3  4  5  6  7            9  5  1 10  6  2 11  7  3 12  8  4
 9 10 11 12  0  1  2  3  4  5  6  7  8            10  7  4  1 11  8  5  2 12  9  6  3
10 11 12  0  1  2  3  4  5  6  7  8  9            11  9  7  5  3  1 12 10  8  6  4  2
11 12  0  1  2  3  4  5  6  7  8  9 10            12 11 10  9  8  7  6  5  4  3  2  1
12  0  1  2  3  4  5  6  7  8  9 10 11
  ```
        , text(blue)[
          ```
          diagonal:  1 2 3 4 5  6  7  8  9 10 11 12
          val:           1 4 9 3 12 10 10 12 3 9  4  1
          ```
          - not always square is possible within modulus
          - `1, 3, 4, 9, 10, 12` are *quadratic residues*
          ]
    )
  ]
]

#slide[
  = *Elliptic curves (1)*

  #show raw: it => block(
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 5pt,
    text(fill: rgb("#a2aabc"), it)
  )

  #show raw.where(block: true): set text(1em / 1.5)

  #only((1))[
      #grid(
      columns: (1fr, 2fr),
      rows: (auto),
      gutter: 3pt,
  ```sagemath
  sage: # Let's plot the following elliptic curve in R
  sage: # y^2 == x^3 + 2x + 4 in R

  sage: E = EllipticCurve([2,4]);
  sage: P = E.plot()
  sage: P.save("ellipticR.png")
  ```
     , image("assets/ellipticR.png")
    )
  ]
]

#slide[
  = *Elliptic curves (2)*

  #show raw: it => block(
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 5pt,
    text(fill: rgb("#a2aabc"), it)
  )

  #show raw.where(block: true): set text(1em / 1.7)

  #only((1))[
      #grid(
      columns: (auto),
      rows: (3fr, 1fr),
      gutter: 3pt,
  ```pen
y^2 == x^3 + 2x + 4 in mod 13

x=0, y^2= 4 => (0,2) and (0,11) -> two points
x=1, y^2= 1 + 2 + 4 = 7 -> no point
x=2, y^2= 8 + 4 + 4 = 16 mod 13 = 3 -> (2,4) and (2,9)
x=3, y^2= 1 + 6 + 4 = 11 -> no point
x=4, y^2= 12 + 8 + 4 = 24 mod 13 = 11 -> no point
x=5, y^2= 8 + 10 + 4 = 9 -> (5,3) and (5,10)
x=6, y^2= 8 + 12 + 4 = 24 mod 13 = 11 -> no point
x=7, y^2= 5 + 14 + 4 = 23 mod 13 = 10 -> (7,6) and (7,7)
x=8, y^2= 5 + 16 + 4 = 25 mod 13 = 12 -> (8,5) and (8,8)
x=9, y^2= 1 + 18 + 4 = 23 mod 13 = 10 -> (9,6) and (9,7)
x=10, y^2= 12 + 20 + 4 = 36 mod 13 = 10 -> (10,6) and (10,7)
x=11, y^2= 5 + 22 + 4 = 31 mod 13 = 5 -> no point
x=12, y^2= 12 + 24 + 4 = 40 mod 13 = 1 -> (12,1) and (12,12)
  ```
  , text(blue)[For some x there are no solutions when we have mod 13, for the rest we have two!]
    )
  ]
]

#slide[
  = *Elliptic curves (3)*

  #show raw: it => block(
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 5pt,
    text(fill: rgb("#a2aabc"), it)
  )

  #show raw.where(block: true): set text(1em / 1.7)

  #only((1))[
      #grid(
      columns: (2fr, 2fr),
      rows: (auto),
      gutter: 3pt,
  ```sagemath
sage: F13=GF(13)
sage: a = F13(2)
sage: b = F13(4)
sage: # discriminant obeys condition
sage: F13(6)*(F13(4)*a^3+F13(27)*b^2) != F13(0)
True
sage: E = EllipticCurve(F13,[a,b]) # y^2 == x^3 + 2x + 4
sage: P = E(0,2) # 2^2 == 0^3 + 2*0 + 4 mod 13
sage: P.xy()
(0, 2)
sage: INF=E(0)
sage: try:
....:     INF.xy()
....: except ZeroDivisionError:
....:     pass
....:
sage: P = E.plot()
sage: P.save("elliptic13.png")
  ```
     , image("assets/elliptic13.png")
    )
  ]
]

#slide[
  = *Modular arithmetics (5)*

  #show raw: it => block(
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 5pt,
    text(fill: rgb("#a2aabc"), it)
  )

  #show raw.where(block: true): set text(1em / 1.5)

  #only((1))[
      #grid(
      columns: (2fr, 3fr),
      rows: (auto),
      gutter: 3pt,
  ```j
addition mod 13
 0  1  2  3  4  5  6  7  8  9 10 11 12
 1  2  3  4  5  6  7  8  9 10 11 12  0
 2  3  4  5  6  7  8  9 10 11 12  0  1
 3  4  5  6  7  8  9 10 11 12  0  1  2
 4  5  6  7  8  9 10 11 12  0  1  2  3
 5  6  7  8  9 10 11 12  0  1  2  3  4
 6  7  8  9 10 11 12  0  1  2  3  4  5
 7  8  9 10 11 12  0  1  2  3  4  5  6
 8  9 10 11 12  0  1  2  3  4  5  6  7
 9 10 11 12  0  1  2  3  4  5  6  7  8
10 11 12  0  1  2  3  4  5  6  7  8  9
11 12  0  1  2  3  4  5  6  7  8  9 10
12  0  1  2  3  4  5  6  7  8  9 10 11
  ```
        , text(blue)[
        Addition forms a *group* as
        - 0 is identity element
        - addition is associative op
        - addition is closed op
        - each element has the inverse
        ]
    )
  ]
]

#slide[
  = *Modular arithmetics (5)*

  #show raw: it => block(
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 5pt,
    text(fill: rgb("#a2aabc"), it)
  )

  #show raw.where(block: true): set text(1em / 1.5)

  #only((1))[
      #grid(
      columns: (2fr, 3fr),
      rows: (auto),
      gutter: 3pt,
  ```j
  multiplication mod 13
1  2  3  4  5  6  7  8  9 10 11 12
2  4  6  8 10 12  1  3  5  7  9 11
3  6  9 12  2  5  8 11  1  4  7 10
4  8 12  3  7 11  2  6 10  1  5  9
5 10  2  7 12  4  9  1  6 11  3  8
6 12  5 11  4 10  3  9  2  8  1  7
7  1  8  2  9  3 10  4 11  5 12  6
8  3 11  6  1  9  4 12  7  2 10  5
9  5  1 10  6  2 11  7  3 12  8  4
10  7  4  1 11  8  5  2 12  9  6  3
11  9  7  5  3  1 12 10  8  6  4  2
12 11 10  9  8  7  6  5  4  3  2  1
  ```
        , text(blue)[
        Mult forms a *group* as
        - 1 is identity element
        - mult is associative op
        - mult is closed op
        - each element has the inverse (thanks to p being prime)
        ]
    )
  ]

  #only((2))[
      #grid(
      columns: (2fr, 2fr),
      rows: (auto),
      gutter: 3pt,
  ```j
  multiplication mod 13
1  2  3  4  5  6  7  8  9 10 11 12
2  4  6  8 10 12  1  3  5  7  9 11
3  6  9 12  2  5  8 11  1  4  7 10
4  8 12  3  7 11  2  6 10  1  5  9
5 10  2  7 12  4  9  1  6 11  3  8
6 12  5 11  4 10  3  9  2  8  1  7
7  1  8  2  9  3 10  4 11  5 12  6
8  3 11  6  1  9  4 12  7  2 10  5
9  5  1 10  6  2 11  7  3 12  8  4
10  7  4  1 11  8  5  2 12  9  6  3
11  9  7  5  3  1 12 10  8  6  4  2
12 11 10  9  8  7  6  5  4  3  2  1
  ```
        , text(blue)[
        - 3 . 3 = 9
        - 3 . 3 . 3 = 1
        - 3 . 3 . 3 . 3 = 3
        we can NOT generate EACH element -> 3 is not generator
        ]
    )
  ]

  #only((3))[
      #grid(
      columns: (2fr, 2fr),
      rows: (auto),
      gutter: 3pt,
  ```j
  multiplication mod 13
1  2  3  4  5  6  7  8  9 10 11 12
2  4  6  8 10 12  1  3  5  7  9 11
3  6  9 12  2  5  8 11  1  4  7 10
4  8 12  3  7 11  2  6 10  1  5  9
5 10  2  7 12  4  9  1  6 11  3  8
6 12  5 11  4 10  3  9  2  8  1  7
7  1  8  2  9  3 10  4 11  5 12  6
8  3 11  6  1  9  4 12  7  2 10  5
9  5  1 10  6  2 11  7  3 12  8  4
10  7  4  1 11  8  5  2 12  9  6  3
11  9  7  5  3  1 12 10  8  6  4  2
12 11 10  9  8  7  6  5  4  3  2  1
  ```
        , text(blue)[
        - 8 . 8 = 12
        - 8 . 8 . 8 = 5
        - 8 . 8 . 8 . 8 = 1
        we can NOT generate EACH element -> 8 is not generator
        ]
    )
  ]

  #only((4))[
      #grid(
      columns: (1fr, 1fr),
      rows: (auto),
      gutter: 3pt,
  ```j
  multiplication mod 13
1  2  3  4  5  6  7  8  9 10 11 12
2  4  6  8 10 12  1  3  5  7  9 11
3  6  9 12  2  5  8 11  1  4  7 10
4  8 12  3  7 11  2  6 10  1  5  9
5 10  2  7 12  4  9  1  6 11  3  8
6 12  5 11  4 10  3  9  2  8  1  7
7  1  8  2  9  3 10  4 11  5 12  6
8  3 11  6  1  9  4 12  7  2 10  5
9  5  1 10  6  2 11  7  3 12  8  4
10  7  4  1 11  8  5  2 12  9  6  3
11  9  7  5  3  1 12 10  8  6  4  2
12 11 10  9  8  7  6  5  4  3  2  1
  ```
        , text(blue, size: 15pt)[
        - 2 . 2 = 4
        - 2 . 2 . 2 = 8
        - 2 . 2 . 2 . 2 = 3
        - 2 . 2 . 2 . 2 . 2 = 6
        - 2 . 2 . 2 . 2 . 2 . 2 = 12
        - 2 . 2 . 2 . 2 . 2 . 2 . 2 = 11
        - 2 . 2 . 2 . 2 . 2 . 2 . 2 . 2 = 9
        - 2 . 2 . 2 . 2 . 2 . 2 . 2 . 2 . 2 = 5
        - 2 . 2 . 2 . 2 . 2 . 2 . 2 . 2 . 2 . 2 = 10
        - 2 . 2 . 2 . 2 . 2 . 2 . 2 . 2 . 2 . 2 . 2 = 7
        - 2 . 2 . 2 . 2 . 2 . 2 . 2 . 2 . 2 . 2 . 2 . 2 = 1
        we can generate EVERY element -> 2 is *generator*, group is *cyclic*
        ]
    )
  ]

]

#slide[
  = *Elliptic curves (4)*

  #show raw: it => block(
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 5pt,
    text(fill: rgb("#a2aabc"), it)
  )

  #show raw.where(block: true): set text(1em / 1.5)

  #only((1))[
      #grid(
      columns: (2fr, 0.75fr),
      rows: (auto),
      gutter: 3pt,
      text(blue)[
        Visually addition looks like here for elliptic curves
        with one remark: it is modulo PRIME
      ]
     , image("assets/ellipticAdd.png")
    )
  ]

  #only((2))[
      #grid(
      columns: (2fr, 0.75fr),
      rows: (auto),
      gutter: 3pt,
      text(blue)[
        It is called *chord-and-tangent* rule and visually is looks like below
        $P_1 + P_2 = P_3$
      ]
     , image("assets/ellipticAdd.png")
    )
  ]

  #only((3))[
      #grid(
      columns: (auto),
      rows: (0.3fr, 1fr),
      gutter: 3pt,
      text(blue)[
        *y=INF* is identity element, and because of that
        $P^(-1)_1 = P_2 $
        $Q^(-1)_1 = Q_2 $
      ]
     , image("assets/ellipticInv.png")
    )
  ]

  #only((4))[
      #grid(
      columns: (auto),
      rows: (0.2fr, 0.65fr, 0.65fr),
      gutter: 3pt,
      text(blue)[
        *chord-and-tangent* rule algebraically is following
      ]
     , image("assets/ellipticTangent.png")
     , image("assets/ellipticChord.png")
    )
  ]
]

#slide[
  = *Elliptic curves (5) (mod 13)*

  #only((1))[
    #image("assets/elliptic13.png")
  ]

  #only((2))[
    #image("assets/elliptic13.png")

    #place(
      top + left,
      line(start: (12%, 15%), end: (12%, 85%),  stroke: (paint: red, thickness: 3pt, dash: "dashed")),
    )
  ]

  #only((3))[
    #image("assets/elliptic13.png")

    #place(
      top + left,
        line(end: (58%, 35%), start: (24%, 85%),  stroke: (paint: red, thickness: 3pt, dash: "dashed")),
    )

    #place(
      top + left,
        line(end: (47%, 52%), start: (47%, 57%),  stroke: (paint: red, thickness: 3pt, dash: "dashed")),
    )

  ]
]

#slide[
  = *Elliptic curves (6) (mod 13)*

  #show raw: it => block(
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 5pt,
    text(fill: rgb("#a2aabc"), it)
  )

  #show raw.where(block: true): set text(1em / 1.5)

  ```sagemath
sage: F13 = GF(13)
sage: a = F13(2)
sage: b = F13(4)
sage: E = EllipticCurve(F13,[a,b]) # y^2 == x^3 + 2x + 4
sage: INF=E(0)
sage: E(2,4) + E(2,9) == INF
True
sage: E(8,5) + E(9,6) == E(10,7)
False
sage: E(8,5) + E(9,6) == E(10,6)
True
  ```
]

#slide[
  = *Elliptic curves (7)*

  #show raw: it => block(
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 5pt,
    text(fill: rgb("#a2aabc"), it)
  )

  #show raw.where(block: true): set text(1em / 1.5)

```sagemath
sage: # Bitcoin’s secp256k1 curve
sage: # p = 2^256-2^32-977
sage: p =115792089237316195423570985008687907853269984665640564039457584007908834671663
sage: p.is_prime()
True
sage: p.nbits()
256
sage: Fp = GF(p)
sage: secp256k1 = EllipticCurve(Fp,[0,7])
sage: # Base point
sage: gx= 55066263022277343669578718895168534326250603453777594175500187360389116729240L
sage: gy= 32670510020758816978083085130507043184471273380659243275938904335757337482424L
sage: G = secp256k1(Fp(gx), Fp(gy))
```
]

#slide[
  = *Elliptic curves (8)*

  #show raw: it => block(
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 5pt,
    text(fill: rgb("#a2aabc"), it)
  )

  #show raw.where(block: true): set text(1em / 1.5)

  #only((1))[
```sagemath
sage: # we have x + y = 9 to solve
sage: # PROVER provided a solution (x=2, y=7) and has the proof for it
sage: #
sage: xHidden = 2*G
sage: yHidden = 7*G
sage:
sage: # VERIFIER knows 9 which is public knowledge and gets solution hidden in POINTS
sage: rhsPoint = 9*G
sage: rhsPoint == xHidden + yHidden
True

sage: xHidden
(89565891926547004231252920425935692360644145829622209833684329913297188986597 : 12158399299693830322967808612713398636155367887041628176798871954788371653930 : 1)
```
]

  #only((2,3,4))[
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

  #only((3,4))[
    #align(left)[
      #text(blue, size: 20pt)[x=2, y=7 and sends xG and yG]
    ]
    #align(right)[
      #text(blue, size: 20pt)[can check *xG + yG = 9G*, but cannot retrieve x and y]
    ]
  ]

  #only((4))[
    #align(center)[
      #text(red, size: 25pt)[!homomorphic encryption preserves operations!]
    ]
  ]
]

#slide[
  = *Elliptic curves (9)*

  #only((1,2))[
      #text(blue, size: 20pt)[
            At this moment we can solve problems that are linear, meaning \
            can be expressed as set of linear expressions:
            $ a_11 * x_1 + a_12 * x_2 + ... = b_1 $
            $ a_21 * x_1 + a_22 * x_2 + ... = b_2 $
            $ ... $
            $ a_"n1" * x_1 + a_"n2" * x_2 + ... = b_"n" $
            but we cannot solve:
            ]
      #align(center)[
        #text(red, size: 25pt)[
              *xy = 9*
              ]
      ]
  ]

  #only((2))[
      #align(center)[
        #text(red)[=> *pairings*]
      ]
  ]
]

#slide[
  = *Pairings of elliptic curves (1)*

      #text(blue, size: 20pt)[
            We are going to use TWO groups together \
            $(G_1, G_2) = G_T$ \
            $G_1$ elliptic curve point => 2 numbers \
            $G_2$ elliptic curve point over an extended field in the form of \
            polynomials *aw + b*  and   *a'w + b'*  => 4 numbers
            ]
      #align(center)[
        #text(red, size: 25pt)[
              For $A in G_1$, $B in G_2$ and $C in G_T$ \
              \
              $G_T$ is multiplicative \
              e(A,B)=C => e($A^x$, $B^y$)= $C^"xy"$
              ]
      ]
]

#slide[
  = *Pairings of elliptic curves (2)*

      #text(blue, size: 20pt)[
            $G_1$ has generator A\
            $G_2$ has generator B\
            C is pairing e($G_1$, $G_2$)=g \
            xy=12 \
            x=4 and y=3 \
            e(4A, 3B)=$C^12$
            ]
      #align(center)[
        #text(red, size: 25pt)[
                $G_1$ and $G_2$ are elliptic groups \
                $G_T$ is multiplicative group of an extensive field \
                \
                $G_1$ = $G_2$ symmetric \
                $G_1 eq.not G_2$ antisymmetric (used in production due to performance)
              ]
      ]
]

#slide[
  = *Pairings of elliptic curves (3)*

  #only((1))[
      #grid(
      columns: (1fr, 1fr),
      rows: (auto),
      gutter: 3pt,
      text(blue, size: 25pt)[
            Every elliptic curve gives rise to a pairing map\
            *BUT* \
            not every such pairing can be efficiently computed\
            \
            =>\
                        *embedding degree of a curve*
              ],
      image("assets/elliptic13.png")
      )
  ]

  #only((2))[
      #grid(
      columns: (1fr, 1fr),
      rows: (auto),
      gutter: 3pt,
      text(blue, size: 20pt)[
                   embedding degree of a curve *k*\
                   8 pairs + identity (INF) = 17\
                   => \
                        order r = 17\
                        p = 13\
                   \
                   $r | p^k - 1$],
      image("assets/elliptic13.png")
      )
  ]

  #only((3))[
      #grid(
      columns: (1fr, 1fr),
      rows: (auto),
      gutter: 3pt,
      text(blue, size: 20pt)[
                   embedding degree of a curve *k*\
                   8 pairs + identity (INF) = 17\
                   => \
                        order r = 17\
                        p = 13\
                   \
                   $r | p^k - 1$\
                   $17 | 13^1 -1$ <=> 17|13 NO ],
      image("assets/elliptic13.png")
      )
  ]

  #only((4))[
      #grid(
      columns: (1fr, 1fr),
      rows: (auto),
      gutter: 3pt,
      text(blue, size: 20pt)[
                   embedding degree of a curve *k*\
                   8 pairs + identity (INF) = 17\
                   => \
                        order r = 17\
                        p = 13\
                   \
                   $r | p^k - 1$\
                   $17 | 13^1 -1$ <=> 17|13 NO\
                   $17 | 13^2 -1$ <=> 17|168 NO ],
      image("assets/elliptic13.png")
      )
  ]

  #only((5))[
      #grid(
      columns: (1fr, 1fr),
      rows: (auto),
      gutter: 3pt,
      text(blue, size: 20pt)[
                   embedding degree of a curve *k*\
                   8 pairs + identity (INF) = 17\
                   => \
                        order r = 17\
                        p = 13\
                   \
                   $r | p^k - 1$\
                   $17 | 13^1 -1$ <=> 17|13 NO\
                   $17 | 13^2 -1$ <=> 17|168 NO\
                   $17 | 13^3 -1$ <=> 17|2196 NO ],
      image("assets/elliptic13.png")
      )
  ]

  #only((6))[
      #grid(
      columns: (1fr, 1fr),
      rows: (auto),
      gutter: 3pt,
      text(blue, size: 20pt)[
                   embedding degree of a curve *k*\
                   8 pairs + identity (INF) = 17\
                   => \
                        order r = 17\
                        p = 13\
                   \
                   $r | p^k - 1$\
                   $17 | 13^1 -1$ <=> 17|13 NO\
                   $17 | 13^2 -1$ <=> 17|168 NO\
                   $17 | 13^3 -1$ <=> 17|2196 NO\
                   $17 | 13^4 -1$ <=> 17|28560 YES\
                   \
                   *k=4*],
      image("assets/elliptic13.png")
      )
  ]

  #show raw: it => block(
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 5pt,
    text(fill: rgb("#a2aabc"), it)
  )

  #show raw.where(block: true): set text(1em / 1.5)

  #only((7))[
```sagemath
sage: p=13
sage: F13=GF(p)
sage: a = F13(2)
sage: b = F13(4)
sage: E = EllipticCurve(F13,[a,b])
sage: r= E.order()
17
sage: k = 1
sage: while True:
....:     # Check if the order r divides (p^k - 1)
....:     if (p**k - 1) % r == 0:
....:         print(f"The embedding degree k is: {k}")
....:         break
....:     k += 1
....:
The embedding degree k is: 4
```
  ]
]

#slide[
  = *Pairings of elliptic curves (4)*

  #show raw: it => block(
    fill: rgb("#1d2433"),
    inset: 8pt,
    radius: 5pt,
    text(fill: rgb("#a2aabc"), it)
  )

  #show raw.where(block: true): set text(1em / 1.5)

```sagemath
sage: # Now again secp256k1
sage: p =115792089237316195423570985008687907853269984665640564039457584007908834671663
sage: Fp = GF(p)
sage: secp256k1 = EllipticCurve(Fp,[0,7])
sage: r= secp256k1.order()
sage: r
115792089237316195423570985008687907852837564279074904382605163141518161494337
sage: k = 1
sage: while k < 1000:
....:     if (p^k-1)%r == 0:
....:         break
....:     k=k+1
....:
sage: k
1000

sage: # in fact it very large
sage: # k =192986815395526992372618308347813175472927379845817397100860523586360249056
```
]

#slide[
  = *Pairings of elliptic curves (5)*

   #only((1))[
    #text(blue, size: 20pt)[
          *secp256k1* is a curve that has large k\
          As extension field is built over $p^k$ it means the extension field is here extremely big.
          => *secp256k1* NEEDS k-many entries, each of them 256 bits\
          => well not enough atoms in the observable universe out there
      ]
   ]

   #only((2))[
    #text(blue, size: 20pt)[
          *secp256k1* is a curve that has large k\
          As extension field is built over $p^k$ it means the extension field is here extremely big.
          => *secp256k1* NEEDS k-many entries, each of them 256 bits\
          => well not enough atoms in the observable universe out there\
          \
      ]
    #text(red, size: 20pt)[
          *secp256k1* is not pairing-friendly\
          we want curves with low embedding degree:\
          BN128 -> 12 \
          Jubjub\
          BLS\
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
