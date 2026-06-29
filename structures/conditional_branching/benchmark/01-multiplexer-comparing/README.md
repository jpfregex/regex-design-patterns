## 📊 Empirical Benchmarks & Structural Diagnostics

To evaluate the runtime state efficiency of each architecture without hardware cache or single-cycle CPU smoothing effects, the internal Perl regular expression engine's compilation and tracking stream (`-Mre=debug`) was piped directly to disk. 

The resulting file footprints represent the exact volume of physical state transitions, node evaluations, and tracking steps executed by the NFA engine:

| Parser Architecture | Algorithmic Trajectory | Trace Journal Size | State Footprint Reduction |
| :--- | :---: | :---: | :---: |
| **07-NORM-ON-debug.txt** | $O(N)$ | 10.6 MiB | *Baseline* |
| **07-NORM-OlogN-debug.txt** | $O(\log N)$ | 10.6 MiB | *Baseline* |
| **07-JPFRX-ON-debug.txt** | $O(N)$ Sequential | 2.4 MiB | -77.3% |
| **07-ADVG-ON-debug.txt** | $O(N)$ Flat | 2.2 MiB | -79.2% |
| **07-JPFRX-OlogN-debug.txt** | $O(\log N)$ Flat-Nested | 1.8 MiB | -83.0% |
| **07-ADVG-OlogN-debug.txt** | $O(\log N)$ Nested | 1.8 MiB | -83.0% |
| **07-NADVG-OlogsqrtN-debug.txt** | $O(\log \sqrt{N})$ Balanced Tree | **1.6 MiB** | **-84.9%** 🏆 |

### 🔍 Key Takeaways
1. **The State Isolation Victory**: By introducing a hard master reset gate (`<type>`), the advanced gate implementations strip away over 77% of the engine's internal tracking noise, isolating execution variables cleanly across iterative loops.
2. **The $O(\log \sqrt{N})$ Performance Proof**: The **Nested Advanced Gate (NADVG)** compresses the physical node execution trace down to its absolute minimum (1.6 MiB). This confirms that a balanced binary tree successfully eliminates redundant state search paths inside the NFA engine, creating maximum data-routing efficiency.

