# 🚨 The Flawed Multiplexer: State Leakage & Backtracking Traps

This directory contains reference implementations of the multiplexer concept that contain fundamental structural flaws. These examples are preserved to demonstrate why traditional monolithic regular expressions fail under iterative global parsing loops (`/g`).

---

## 🔍 The Anatomy of the Flaw

The scripts in this directory (`flawed-multiplexer-conditional_perl.pl` and `flawed-multiplexer-linear_perl.pl`) attempt to build a monolithic conditional structure where state definition and data matching are tightly coupled inside a single expression. 

This architecture introduces two severe vulnerabilities to the NFA engine:

### 1. Global Capture Retention (The Ghost State)
In both the linear and conditional variants, a master type token matches once at the header boundary, setting named capture flags globally (e.g., `(?<date_yyyymmdd_dash>)`). 

Because it is a single monolithic match processing via quantifiers (`(...)+`), **the NFA engine does not implicitly reset or clear these capture slots to `undef` when it moves to subsequent lines.** The captures remain locked in a `TRUE` state across thousands of rows of data.

### 2. The Backtracking Wormhole
Because old state flags stick around, the engine doesn't adapt to structural changes or corrupted lines. 

When a row encounters a corrupted token or a trailing comment block, the engine enters a massive backtracking loop. It tries to force the characters into the wrong, stale capture flag state, working through 22 layers of conditional checks on every single step.

---

## 📊 Empirical Diagnostic Impact

When exposed to corrupted data boundaries or trailing noise rows under stress-testing, these flawed architectures display a complete collapse in processing and system metrics:

* **Massive Log Explosion**: Generating trace files via `-Mre=debug` results in **10.6 MiB** of redundant state tracking steps due to the engine blindly checking dead branches.
* **CPU & Thread Hogs**: In unanchored tests, the linear and conditional flaws cause the script to run for up to **23 minutes**, maxing out a single core thread on redundant search cycles.
* **Kernel Resource Churn**: They trigger high counts of involuntary context switches, demonstrating severe hardware pipeline stalls and cache thrashing as the NFA stack balloons on the heap.

---

## 💡 The Solution

To see how to fix this structural state-leakage vulnerability, navigate to the parent directory and examine the **No-Pipe Multiplexer** patterns. 

By separating the logic into an independent **Router** and an isolated **Multiplexer** wrapped in an atomic type reset gate, you eliminate state persistence across line iterations, cutting the trace footprint down to just `1.6 MiB` and stabilizing the CPU execution line.

