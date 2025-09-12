# Math and cryptographic prerequisites for understanding Zero Knowledge Proofs tech (ZKP)

The current gitbook provides very hands-on documentation of the learning path that hopefully leads to understanding what is under the hood in mainstream ZKP implementations.
Each concept is illustrated using SageMath, Rust and Zig programming languages. Only calculation powered concepts are raised - paraphrazing the quote "What I cannot create, I do not understand" by physicist Richard Feynman - that expresses that true understanding of a concept comes from the ability to reconstruct it from fundamental principles.

# Table of Content
0. [How to run code](#how-to-run-code)
1. [Useful facts from number theory](#useful-facts-from-number-theory)

## How to run code

<details>
<summary>SageMath</summary>

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
</details>

<details>
<summary>Rust</summary>

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
</details>


<details>
<summary>Zig</summary>

Make sure you have the latest ([master](https://ziglang.org/download/)) version of the Zig language.
And that it is __visibible__ in the command line.
```bash
$ zig version
0.16.0-dev.43+99b2b6151
```

Then you can have a zig file like below, having both main and test suites,
```bash
$ cat zigScript.zig
const std = @import("std");
const testing = std.testing;
const Managed = std.math.big.int.Managed;
const Limb = std.math.big.Limb;

test "setting a big number from string" {
    var a = try Managed.init(testing.allocator);
    defer a.deinit();

    try a.setString(10, "120317241209124781241290847124");
    try testing.expectEqual(120317241209124781241290847124, try a.toInt(u128));
}

pub fn main() !void {
    var gpa1 = std.heap.GeneralPurposeAllocator(.{}){};
    const allocatorManaged =  gpa1.allocator();

    var a = try Managed.initSet(allocatorManaged, 123456789);
    defer a.deinit();

    std.debug.print("{d}\nlimbs={any}\n\n", .{a, a.limbs});
    try a.pow(&a, 5);
    std.debug.print("{d}\nlimbs={any}\n\n", .{a, a.limbs});
}
```

In order to run anyone just call as follows:
```bash
$ zig run zigScript.zig
123456789
limbs={ 123456789, 12297829382473034410, 12297829382473034410, 12297829382473034410 }

28679718602997181072337614380936720482949
limbs={ 6356712022736044677, 5204158590521663073, 84, 0, 0 }

$ zig test zigScript.zig
All 1 tests passed.
```
</details>


## Useful facts from number theory

From **fundamental number theorem** we know that each natural number, _n_ can be decomposed into multiplying prime numbers, ie., $`n=p_1*p_2*...p_N`$ .
And this decomposition is unequivocal.

<details>
<summary>SageMath</summary>

```sagemath
sage: n = NN(123456789)
sage: factor(n)
3^2 * 3607 * 3803
```
</details>

<details>
<summary>Rust</summary>

```rust
#!/usr/bin/env rust-script

//! ```cargo
//! [dependencies]
//! prime_factorization = "1.0.5"
//! ```

use prime_factorization::Factorization;

type CustomizedResult<T> = Result<T, Box<dyn std::error::Error>>;

fn main() -> CustomizedResult<()> {
   print!("{:?}\n", Factorization::<u32>::run(123456789));

   Ok(())
}
```

```bash
$ rust-script rustScript
Factorization { num: 123456789, is_prime: false, factors: [3, 3, 3607, 3803] }
```
</details>

<details>
<summary>Zig</summary>

The prerequisite is having [Zig-Math-Algorithms](https://github.com/ramsyana/Zig-Math-Algorithms.git)  downloaded.
It works with the latest release only - not with master.

```bash
$ zig version
0.15.0-dev.379+ffd85ffcd
$ git clone https://github.com/ramsyana/Zig-Math-Algorithms.git
$ cd Zig-Math-Algorithms
$ zig run src/algorithm/math/prime_factorization.zig
Enter a positive integer greater than 1: 123456789

The factorization of 123456789 is:
3-3-3607-3803
```
</details>

We also know that having interger number **a**, dividend, and integer number **b**, divisor, we can divide the former by the latter, and have **quotient** and **remainder**.

<details>
<summary>SageMath</summary>

```sagemath
NN(123456789123456789123456789) // NN(1234)  #123456789123456789123456789 is dividend, 1234 is divisor
100046020359365307231326 # quotient
sage: NN(123456789123456789123456789) % NN(1234)
505  # remainder
```
</details>

<details>
<summary>Rust</summary>

For Rust we are going to use big number library specially designed for cryptographic uses [crypto-bigint](https://docs.rs/crypto-bigint/0.6.1/crypto_bigint/index.html).

```rust
#!/usr/bin/env rust-script

//! ```cargo
//! [dependencies]
//! crypto-bigint = "0.6.1"
//! ```

use crypto_bigint::{NonZero, U256};
use std::ops::Div;

type CustomizedResult<T> = Result<T, Box<dyn std::error::Error>>;

fn to_decimal_from_le(m: &[u8]) -> (u128,u32) {
   m.into_iter().fold((0,0), |pair, elem| (pair.0 + 256_u128.pow(pair.1) * (elem.clone() as u128), pair.1 + 1))
}

fn main() -> CustomizedResult<()> {
   let dividend = U256::from_str_radix_vartime("123456789123456789123456789",10).unwrap();
   let divisor = U256::from_str_radix_vartime("1234",10).unwrap();
   let quotient = dividend.div(divisor);
   let remainder = dividend.rem(&NonZero::new(divisor).unwrap());
   print!("quotient: hex={:?} bytes(le)={:?}\n", quotient, quotient.to_le_bytes());
   print!("quotient: decimal={:?}\n", to_decimal_from_le(&quotient.to_le_bytes()).0);
   print!("remainder: hex={:?} bytes(le)={:?}\n", remainder, remainder.to_le_bytes());
   print!("remainder: decimal={:?}\n", to_decimal_from_le(&remainder.to_le_bytes()).0);

   Ok(())
}
```

After running we see, hex, byte (in little-endian encoding) and decimal representation:
```bash
$ rust-script rustScript
quotient: hex=Uint(0x00000000000000000000000000000000000000000000152F81710A4F2B756C5E) bytes(le)=[94, 108, 117, 43, 79, 10, 113, 129, 47, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
quotient: decimal=100046020359365307231326
remainder: hex=Uint(0x00000000000000000000000000000000000000000000000000000000000001F9) bytes(le)=[249, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
remainder: decimal=505
```

One need to notice that the resultant quotient takes 77-bits, so neither `u32` nor `u64` is enough to give a correct result.

</details>

<details>
<summary>Zig</summary>

We are going to use `Managed` arbitrary big int here.

```zig
$ cat zigScript.zig
const std = @import("std");
const Managed = std.math.big.int.Managed;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator1 =  gpa.allocator();
    const allocator2 =  gpa.allocator();
    const allocator3 =  gpa.allocator();
    const allocator4 =  gpa.allocator();

    var a = try Managed.initSet(allocator1, 123456789123456789123456789);
    defer a.deinit();
    var b = try Managed.initSet(allocator2, 1234);
    defer b.deinit();
    var r = try Managed.init(allocator3);
    defer r.deinit();
    var q = try Managed.init(allocator4);
    defer q.deinit();

    //q = a / b (rem r)
    try Managed.divFloor(&q,&r,&a,&b);

    std.debug.print("quotient={d} remainder={d}\n", .{q,r});
}
```

Running the script gives immediately
```bash
$ zig run zigScript.zig
quotient=100046020359365307231326 remainder=505
```
</details>

**Greatest common divisor (GCD)** of integers is useful to establish if two integers are coprime, ie, their gcd is 1.

<details>
<summary>SageMath</summary>

```sagemath
sage: # gcd(a, b) = s · a + t · b
sage: # result of xgcd: (gcd(a,b),s,t)
sage: NN(123456789123456789123456789).xgcd(NN(1234))
(1, -303, 30313944168887688091091902)
sage: NN(123456789123456789123456789).xgcd(NN(123))
(3, 2, -2007427465422061611763525)
```
</details>

<details>
<summary>Rust</summary>

For Rust we are using [crypto-bigint](https://docs.rs/crypto-bigint/0.6.1/crypto_bigint/index.html).

```rust
$ cat rustScript
#!/usr/bin/env rust-script

//! ```cargo
//! [dependencies]
//! crypto-bigint = "0.6.1"
//! ```

use crypto_bigint::U256;

type CustomizedResult<T> = Result<T, Box<dyn std::error::Error>>;

fn to_decimal_from_le(m: &[u8]) -> u128 {
   m.into_iter().fold((0,0), |pair, elem| (pair.0 + 256_u128.pow(pair.1) * (elem.clone() as u128), pair.1 + 1)).0
}

fn main() -> CustomizedResult<()> {
   let a = U256::from_str_radix_vartime("123456789123456789123456789",10).unwrap();
   let b1 = U256::from_str_radix_vartime("1234",10).unwrap();
   let b2 = U256::from_str_radix_vartime("123",10).unwrap();
   let gcd1 = a.gcd(&b1);
   let gcd2 = a.gcd(&b2);
   print!("gcd({:?},{:?})={:?}\n", to_decimal_from_le(&a.to_le_bytes()), to_decimal_from_le(&b1.to_le_bytes()), to_decimal_from_le(&gcd1.to_le_bytes()) );
   print!("gcd({:?},{:?})={:?}\n", to_decimal_from_le(&a.to_le_bytes()), to_decimal_from_le(&b2.to_le_bytes()), to_decimal_from_le(&gcd2.to_le_bytes()) );

   Ok(())
}
```

After running we see we are consistent with SageMath results

```bash
$ rust-script rustScript
gcd(123456789123456789123456789,1234)=1
gcd(123456789123456789123456789,123)=3
```
</details>

<details>
<summary>Zig</summary>

We are going to use `Managed` arbitrary big int here.

```zig
$ cat zigScript.zig
const std = @import("std");
const Managed = std.math.big.int.Managed;


pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator1 =  gpa.allocator();
    const allocator2 =  gpa.allocator();
    const allocator3 =  gpa.allocator();
    const allocator4 =  gpa.allocator();
    const allocator5 =  gpa.allocator();

    var a = try Managed.initSet(allocator1, 123456789123456789123456789);
    defer a.deinit();
    var b1 = try Managed.initSet(allocator2, 1234);
    defer b1.deinit();
    var b2 = try Managed.initSet(allocator3, 123);
    defer b2.deinit();
    var gcd1 = try Managed.init(allocator4);
    defer gcd1.deinit();
    var gcd2 = try Managed.init(allocator5);
    defer gcd2.deinit();

    try Managed.gcd(&gcd1,&a,&b1);
    try Managed.gcd(&gcd2,&a,&b2);

    std.debug.print("gcd({d},{d})={d}\n", .{a,b1,gcd1});
    std.debug.print("gcd({d},{d})={d}\n", .{a,b2,gcd2});
}
```

Running the script gives immediately corrrect results
```bash
$ zig run zigScript.zig
gcd(123456789123456789123456789,1234)=1
gcd(123456789123456789123456789,123)=3
```
</details>
