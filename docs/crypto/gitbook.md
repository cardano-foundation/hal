# Math and cryptographic prerequisites for understanding Zero Knowledge Proofs tech (ZKP)

The current gitbook provides very hands-on documentation of the learning path that hopefully leads to understanding what is under the hood in mainstream ZKP implementations.
Each concept is illustrated using SageMath, Rust and Zig programming languages. Only calculation powered concepts are raised - paraphrazing the quote "What I cannot create, I do not understand" by physicist Richard Feynman - that expresses that true understanding of a concept comes from the ability to reconstruct it from fundamental principles.

# Table of Content
0. [How to run code](#how-to-run-code)
1. [Useful facts from number theory](#useful-facts-from-number-theory)

## How to run code

### Sage

Download the latest image from docker hub and run the image in Linux CLI:
```bash
$ docker image pull sagemath/sagemath:latest
$ docker run -it sagemath/sagemath:latest
┌────────────────────────────────────────────────────────────────────┐
│ SageMath version 10.6, Release Date: 2025-03-31                    │
│ Using Python 3.12.5. Type "help()" for help.                       │
└────────────────────────────────────────────────────────────────────┘
sage: ZZ(1234)
1234
sage: ZZ.random_element(10**10)
4134169080
sage: quit
```

### Rust

Make sure you have the latest Rust toolchain installed (using for example `rustup`). Then have a `rust-script` installed:
```bash
$ cargo install rust-script
$ rust-script --version
rust-script 0.36.0
```

Then you can have an **executable** file like below,
```bash
$ cat rustScript
#!/usr/bin/env rust-script

//! ```cargo
//! [dependencies]
//! curve25519-dalek = "5.0.0-pre.0"
//! ```

use curve25519_dalek::scalar::Scalar;

fn addition_to_bytes(left: u64, right: u64) -> [u8; 32] {
   (Scalar::from(left) + Scalar::from(right)).to_bytes()
}

type CustomizedResult<T> = Result<T, Box<dyn std::error::Error>>;

fn main() -> CustomizedResult<()> {
   print!("{:?}", addition_to_bytes(1u64,10u64));

   Ok(())
}

#[cfg(test)]
mod tests {

    use crate::{addition_to_bytes};

    #[test]
    fn bytes_addition_expected() {
        let bytes = [
            128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0,
        ];
        assert_eq!(bytes, addition_to_bytes(100u64, 28u64));
    }
}
```

Then invoking the main and test suite can be done like below:

```bash
$ rust-script rustScript
[11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

$ rust-script --test rustScript
running 1 test
test tests::bytes_addition_expected ... ok

test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s
```

### Zig

Make sure you have the latest ([master](https://ziglang.org/download/)) version of the Zig language.
And that it is __visibible__ in the command line.
```bash
$ zig version
0.16.0-dev.43+99b2b6151
```

Then you can have an **executable** file like below,
```bash
$ cat zigScript.zig
//usr/bin/env zig run "$0"; exit

pub fn main() void {
    const bytes: [64]u8 = [_]u8{0} ** 63 ++ [_]u8{1};
    const num1: ecc.Scalar = ecc.Scalar.fromBytes64(bytes);
    const num1compressed: ecc.CompressedScalar = ecc.Scalar.toBytes(&num1);
    const num2: ecc.Scalar = ecc.Scalar.random();
    const num2compressed: ecc.CompressedScalar = ecc.Scalar.toBytes(&num2);
    std.debug.print("num1={any} \nnum1={any}\nnum1 compressed={any}\n\nnum2={any}\nnum2 compressed={any}\n", .{num1, bytes, num1compressed, num2, num2compressed});
}

const std = @import("std");
const ecc = std.crypto.ecc.Edwards25519.scalar;
```

In order to run just call:
```bash
$ ./zigScript.zig
num1=.{ .limbs = { 0, 0, 0, 0, 0 } }
num1={ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 }
num1 compressed={ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }

num2=.{ .limbs = { 41927865080831364, 15208988149723144, 26122272616670642, 60268350159292730, 129259051 } }
num2 compressed={ 132, 93, 85, 208, 43, 245, 148, 8, 176, 14, 128, 126, 8, 54, 178, 229, 10, 140, 17, 206, 92, 58, 137, 113, 194, 190, 29, 214, 43, 86, 180, 7 }
```

## Useful facts from number theory
