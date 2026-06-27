#!/usr/bin/env perl
# ==============================================================================
# DESIGN PATTERN: NO-PIPE MULTIPLEXER (ADVANCED BINARY GATE & ROUTING)
# ORIGINAL CONCEPT & LOGIC : jpfr
# LICENSE: MIT License (c) 2026 jpfregex - Full terms in root LICENSE file
# ==============================================================================
use strict;
use warnings;

# --- MODULE A: The Input Router with Binary State Fork ---
# If a [0-2] digit is found, the (?<i>...) group is successfully initialized.
# If a [3-9] digit is found (expected else), the engine forks, bypassing and leaving <i> empty.

my(${input_nopipe})=
	'(?:'.
		'(?<![0-2])'. # prevents empty <i> (deterministic)
		'(?<i>'.
			'(?<i0>(?<!\d)0(?!\d))?'.
			'(?<i1>(?<!\d)1(?!\d))?'.
			'(?<i2>(?<!\d)2(?!\d))?'.
		')'.
		'(?<=[0-2])'. # deterministic garantee <i> pattern captured or return false
		'|'.
		'[3-9]'. # else condition with <i> false
	')';

# --- MODULE B: The Conditional Multiplexer with Global Else ---
# If <i> is active, it executes the linear no-pipe sequential multiplexer.
# If <i> is empty, it instantly jumps to the global row-fallback branch.
my(${multiplexer_nopipe})=
	'(?<m>'.
		'(?(<i>)'. # classic (?(patter)yes|no) form
			'(?(<i0>)0+)'.
			'(?(<i1>)1+)'.
			'(?(<i2>)2+)'.
			'|'.
			'[0-9]+'. # else (allowing whatever you define)
		')'.
	')';

# --- TEST DATASETS ---
my(${test_ko})='
INPUT(3): 31 # should be refused
INPUT(5): 54 # should be accepted (else condition with <i> false)
INPUT(9): 0123456789 # should be accepted (else condition with <i> false)
INPUT(2): 25 # should be refused
INPUT(1): 16 # should be refused
';

my(${test_ok})='
INPUT(3): 33 # should be accepted
INPUT(5): 55 # should be accepted
INPUT(9): 0123456789 # should be accepted (else condition with <i> false)
INPUT(2): 22 # should be accepted
INPUT(1): 11 # should be accepted
';

# --- REGEX ASSEMBLY ---
my(${regex})=
	'(?:'.
		'\h*INPUT\('.${input_nopipe}.'\):'.
		'\s*'.${multiplexer_nopipe}.'\s*# [^\n]*\n'.
	')';

# --- EXECUTION ---
print "=== RUNNING SHORT ADVANCED GATE MULTIPLEXER TEST ===\n";

${test_ko}=~s/${regex}/[GOTIT]\n/gs;
print "regex_ko : ${test_ko}\n";
print "--------------------\n";
${test_ok}=~s/(?s:${regex})/[GOTIT]\n/gs;
print "regex_ok : ${test_ok}\n";
print "--------------------\n";
print "INPUT: ${input_nopipe}\n";
print "MULTIPLEXER: ${multiplexer_nopipe}\n";
