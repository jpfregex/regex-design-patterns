# ==============================================================================
# PATTERN    : FLAWED MULTIPLEXER (THE ORIGINAL CONCEPT)
# AUTHOR     : jpfr (jpfrx)
# ENGINE     : Perl / PCRE2 (Requires Extended Mode /x)
# TARGET     : Router and Multiplexer Selector (LISP-style radix implementation as example)
# LICENSE    : MIT License (c) 2026 jpfrx - Full terms in root LICENSE file
# WARNING    : DO NOT USE THIS PATTERN (IT IS FLAWED). Introduced here as the original concept.
# DISCLAIMER : Despite an intensive search, I wasn't able to find this obvious 
#              two-module independent pattern anywhere. I therefore decided to document 
#              it in this repository as a warning (do not use it). However, if you created 
#              this pattern first, please email me with a link to where you published it. 
#              I will gladly credit your name and adapt the license accordingly.
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. COMPONENT-BASED ARCHITECTURE (Decoupled Modules)
# ------------------------------------------------------------------------------
# These two blocks do NOT need to be contiguous. You can place tokens, spaces, 
# or nested expressions between them. The second block passively evaluates 
# based on whichever named group was activated by the first block.
# Evaluates linearly without choice alternations (|). 
# Activates exactly one named group corresponding to the detected radix base.

# ------------------------------------------------------------------------------
# MODULE A: The Radix Router (Capture Group)
# ------------------------------------------------------------------------------

(?x) # Enable extended mode to allow whitespace and comments
(?<radix>
	(?<radix_2>  (?<![0-9]) 2  (?![0-9]) )
	|
	(?<radix_3>  (?<![0-9]) 3  (?![0-9]) )
	|
	(?<radix_4>  (?<![0-9]) 4  (?![0-9]) )
	|
	(?<radix_5>  (?<![0-9]) 5  (?![0-9]) )
	|
	(?<radix_6>  (?<![0-9]) 6  (?![0-9]) )
	|
	(?<radix_7>  (?<![0-9]) 7  (?![0-9]) )
	|
	(?<radix_8>  (?<![0-9]) 8  (?![0-9]) )
	|
	(?<radix_9>  (?<![0-9]) 9  (?![0-9]) )
	|
	(?<radix_10> (?<![0-9]) 10 (?![0-9]) )
	|
	(?<radix_11> (?<![0-9]) 11 (?![0-9]) )
	|
	(?<radix_12> (?<![0-9]) 12 (?![0-9]) )
	|
	(?<radix_13> (?<![0-9]) 13 (?![0-9]) )
	|
	(?<radix_14> (?<![0-9]) 14 (?![0-9]) )
	|
	(?<radix_15> (?<![0-9]) 15 (?![0-9]) )
	|
	(?<radix_16> (?<![0-9]) 16 (?![0-9]) )
	|
	(?<radix_17> (?<![0-9]) 17 (?![0-9]) )
	|
	(?<radix_18> (?<![0-9]) 18 (?![0-9]) )
	|
	(?<radix_19> (?<![0-9]) 19 (?![0-9]) )
	|
	(?<radix_20> (?<![0-9]) 20 (?![0-9]) )
	|
	(?<radix_21> (?<![0-9]) 21 (?![0-9]) )
	|
	(?<radix_22> (?<![0-9]) 22 (?![0-9]) )
	|
	(?<radix_23> (?<![0-9]) 23 (?![0-9]) )
	|
	(?<radix_24> (?<![0-9]) 24 (?![0-9]) )
	|
	(?<radix_25> (?<![0-9]) 25 (?![0-9]) )
	|
	(?<radix_26> (?<![0-9]) 26 (?![0-9]) )
	|
	(?<radix_27> (?<![0-9]) 27 (?![0-9]) )
	|
	(?<radix_28> (?<![0-9]) 28 (?![0-9]) )
	|
	(?<radix_29> (?<![0-9]) 29 (?![0-9]) )
	|
	(?<radix_30> (?<![0-9]) 30 (?![0-9]) )
	|
	(?<radix_31> (?<![0-9]) 31 (?![0-9]) )
	|
	(?<radix_32> (?<![0-9]) 32 (?![0-9]) )
	|
	(?<radix_33> (?<![0-9]) 33 (?![0-9]) )
	|
	(?<radix_34> (?<![0-9]) 34 (?![0-9]) )
	|
	(?<radix_35> (?<![0-9]) 35 (?![0-9]) )
	|
	(?<radix_36> (?<![0-9]) 36 (?![0-9]) )
)

# ------------------------------------------------------------------------------
# MODULE B: The Linear Multiplexer (Passive Evaluator)
# ------------------------------------------------------------------------------
# Uses successive independent conditional structures with explicit "else" blocks for optimisation purpose.

(?x) # Enable extended mode
(?<integer_radix>
	(?(<radix_2>)  [01]+ |
	(?(<radix_3>)  [0-2]+ |
	(?(<radix_4>)  [0-3]+ |
	(?(<radix_5>)  [0-4]+ |
	(?(<radix_6>)  [0-5]+ |
	(?(<radix_7>)  [0-6]+ |
	(?(<radix_8>)  [0-7]+ |
	(?(<radix_9>)  [0-8]+ |
	(?(<radix_10>) [0-9]+ |
	(?(<radix_11>) [0-9Aa]+ |
	(?(<radix_12>) [0-9ABab]+ |
	(?(<radix_13>) [0-9A-Ca-c]+ |
	(?(<radix_14>) [0-9A-Da-d]+ |
	(?(<radix_15>) [0-9A-Ea-e]+ |
	(?(<radix_16>) [0-9A-Fa-f]+ |
	(?(<radix_17>) [0-9A-Ga-g]+ |
	(?(<radix_18>) [0-9A-Ha-h]+ |
	(?(<radix_19>) [0-9A-Ia-i]+ |
	(?(<radix_20>) [0-9A-Ja-j]+ |
	(?(<radix_21>) [0-9A-Ka-k]+ |
	(?(<radix_22>) [0-9A-La-l]+ |
	(?(<radix_23>) [0-9A-Ma-m]+ |
	(?(<radix_24>) [0-9A-Na-n]+ |
	(?(<radix_25>) [0-9A-Oa-o]+ |
	(?(<radix_26>) [0-9A-Pa-p]+ |
	(?(<radix_27>) [0-9A-Qa-q]+ |
	(?(<radix_28>) [0-9A-Ra-r]+ |
	(?(<radix_29>) [0-9A-Sa-s]+ |
	(?(<radix_30>) [0-9A-Ta-t]+ |
	(?(<radix_31>) [0-9A-Ua-u]+ |
	(?(<radix_32>) [0-9A-Va-v]+ |
	(?(<radix_33>) [0-9A-Wa-w]+ |
	(?(<radix_34>) [0-9A-Xa-x]+ |
	(?(<radix_35>) [0-9A-Ya-y]+ |
	(?(<radix_36>) [0-9A-Za-z]+ )))))))))))))))))))))))))))))))))))
)

# ------------------------------------------------------------------------------
# 2. END-TO-END MINIMALIST EXAMPLE (Contiguous Workflow)
# ------------------------------------------------------------------------------
# Below is a simple test layout showing how to catch a "radix: X" header 
# followed by its valid numbers, simulating how a parser bridges the two modules.

# Example Pattern:
# (?: radix:\s+<MODULE_A>\s+<MODULE_B> )

# ------------------------------------------------------------------------------
# 3. THE ISSUE: STATE RETENTION AND SIDE EFFECTS
# ------------------------------------------------------------------------------
# When utilizing the global modifier (/g), multiple successive matches of the 
# Router continuously populate the capture registers. This causes multiple 
# conditional flags—such as (?(<radix_N>))—to remain simultaneously defined 
# across the engine's global state window.
# 
# This concurrent state definition corrupts the Multiplexer's routing logic, 
# leading to severe execution side effects:
#   1. It induces massive combinatorial backtracking as the engine attempts 
#      to resolve conflicting conditional states.
#   2. It may creates non-deterministic routing, causing false-positive matches 
#      and invalid structural compliance.
#
# Concrete test cases demonstrating this failure state will be added to the 
# repository soon.
# ------------------------------------------------------------------------------

