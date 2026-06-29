#!/usr/bin/env perl
# ==============================================================================
# DESIGN PATTERN: NO-PIPE MULTIPLEXER (ADVANCED BINARY GATE & ROUTING)
# ORIGINAL CONCEPT & LOGIC : jpfr(jpfrx)
# COMMENT & PRESENTATION : AI Assistant (Google Gemini)
# LICENSE: MIT License (c) 2026 jpfrx - Full terms in root LICENSE file
# ==============================================================================
use strict;
use warnings;
use re 'debug';

# --- MODULE A: The Input Router with Binary State Fork ---
# If a [0-2] digit is found, the (?<i>...) group is successfully initialized.
# If an unknown token is found, the engine forks, bypassing and leaving <i> empty.
#
# NOTE ON DETERMINISM: 
# The fallback branch below uses '[3-9]', but it could mathematically be replaced 
# by '.', '\d+', or even '[0-9a-zA-Z]+'. Because the [0-2] capture is strictly 
# constrained by assertions, any other pattern here acts as a passive pass-through 
# that guarantees <i> remains false without interfering with the multiplexer's integrity.

# --- THEORETICAL INSIGHT: SCOPE & SET CONTAINMENT ---
# The Router's else branch controls the global acceptance matrix (the Scope).
#
# Case 1 (Permissive Scope): If the router's else is '.', the system accepts 
# INPUT(a) or INPUT(9), delegating token validation entirely to Module B.
#
# Case 2 (Strict Scope): By restricting the router's else to '(?<!\d)[3-9](?!\d)', 
# or even '(?<!\d)[0-9](?!\d)', '(?<!\d)[0-9]+(?!\d)', 
# you mathematically restrict the language's alphabet at the gate. 
# Even if Module B's multiplexer else allows '[0-9]+', an input like 'INPUT(a)' 
# will fail immediately at Module A. 
#
# This demonstrates how the No-Pipe architecture allows developers to maintain 
# absolute, multi-layered constraint scopes without structural coupling.

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


# --- MODULE B - O(N): The Conditional Multiplexer with Global Else ---
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

# --- MODULE B - O(logN): The Conditional Multiplexer with Global Else ---
# If <i> is active, it executes the linear no-pipe sequential multiplexer.
# If <i> is empty, it instantly jumps to the global row-fallback branch.
my(${multiplexer_nopipe})=
	'(?<m>'.
		'(?(<i>)'. # classic (?(patter)yes|no) form
			'(?(<i0>)0+|'.
			'(?(<i1>)1+|'.
			'(?(<i2>)2+)))'.
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
