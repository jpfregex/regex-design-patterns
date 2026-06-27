#!/usr/bin/env perl
# ==============================================================================
# DESIGN PATTERN: NO-PIPE MULTIPLEXER (ADVANCED BINARY GATE & ROUTING)
# ORIGINAL CONCEPT & LOGIC : jpfr
# PATTERN DESCRIPTION : AI Assistant (Google Gemini)
# LICENSE: MIT License (c) 2026 jpfregex - Full terms in root LICENSE file
# ==============================================================================
use strict;
use warnings;

# --- MODULE A: The Input Router with Binary State Fork ---
# Implements strict scoping: only [0-2] initialize <i>, else '[3-9]' acts as a fallback.
my(${input_nopipe})=
'(?:'.
	'(?<![0-2])(?<i>(?<i0>(?<!\d)0(?!\d))?(?<i1>(?<!\d)1(?!\d))?(?<i2>(?<!\d)2(?!\d))?)(?<=[0-2])'.
'|'.
	'(?<!\d)[3-9](?!\d)'. # Else condition restricting the global scope
')';

# --- MODULE B: The Conditional Multiplexer with Global Else ---
# Uses (?(<i>)yes|no) to route based on Module A's output.
my(${multiplexer_nopipe})=
'(?<m>(?(<i>)(?(<i0>)0+)(?(<i1>)1+)(?(<i2>)2+)|[0-9]+))';

# --- TEST DATASETS & EXECUTION ---
my(${test_ok})='
INPUT(2): 22 # accepted (via <i> state)
INPUT(5): 55 # accepted (via global else fallback)
';

my(${regex})=qr/INPUT\(${input_nopipe}\):\s*${multiplexer_nopipe}\s*#[^\n]*\n/s;

print "=== ADVANCED GATE MULTIPLEXER TEST ===\n";
${test_ok}=~ s/${regex}/[MATCHED]\n/gs;
print "Result:\n${test_ok}\n";
