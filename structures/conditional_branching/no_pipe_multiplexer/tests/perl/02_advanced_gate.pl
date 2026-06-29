#!/usr/bin/env perl
# ==============================================================================
# DESIGN PATTERN: NO-PIPE MULTIPLEXER (ADVANCED BINARY GATE & ROUTING)
# ORIGINAL CONCEPT & LOGIC : jpfr(jpfrx)
# COMMENT & PRESENTATION : AI Assistant (Google Gemini)
# LICENSE: MIT License (c) 2026 jpfrx - Full terms in root LICENSE file
# ==============================================================================
use strict;
use warnings;

# --- MODULE A: The Input Router with Binary State Fork ---
# If a digit is found, the (?<input>...) group is successfully initialized.
# If a letter [a-z] is found, the engine forks, bypassing and leaving <input> empty.
my $input_nopipe =
	'(?:' .
		'(?<input>' .
			'(?<one>(?<![0-9])1(?![0-9]))?' .
			'(?<two>(?<![0-9])2(?![0-9]))?' .
			'(?<three>(?<![0-9])3(?![0-9]))?' .
			'(?<else>(?<![0-9])[4-9](?![0-9]))?' .
		')' .
		'(?<=[0-9])' . # Assertion anchor ensuring input validation
		'|' .
		'[a-z]' .       # Fallback character state fork
	')';

# --- MODULE B: The Conditional Multiplexer with Global Else ---
# If <input> is active, it executes the linear no-pipe sequential multiplexer.
# If <input> is empty, it instantly jumps to the global row-fallback branch.
my $multiplexer_nopipe =
	'(?<multiplexer>' .
		'(?(<input>)' .
			'(?(<one>)1+)' .
			'(?(<two>)2+)' .
			'(?(<three>)3+)' .
			'(?(<else>)[4-9]+)' .
		'|' .
			'[^\n]*' .     # Global fallback if no valid radix was initialized
		')' .
	')';

# --- TEST DATASETS ---
my $test_ok = '
INPUT(3): 33, 3, 3333
INPUT(5): 55, 5, 5555
INPUT(a): CAPTURE ELSE
INPUT(2): 22, 2, 2222
INPUT(1): 11, 1, 1111';

my $test_ko = '
INPUT(3): 33, 4, 3333
INPUT(5): 55, 5, 5155
INPUT(a): CAPTURE ELSE
INPUT(2): 25, 2, 2222
INPUT(1): 11, 6, 1111';

# --- REGEX ASSEMBLY ---
my $regex = qr/(?:
	\s*INPUT\($input_nopipe\):
	\s*$multiplexer_nopipe\s*(?:,\s*$multiplexer_nopipe\s*)*
)/x;

# --- EXECUTION ---
print "=== RUNNING ADVANCED GATE MULTIPLEXER TEST ===\n";

my $clean_ok = $test_ok;
$clean_ok =~ s/$regex/[MATCH]/g;
print "Test OK Output:\n$clean_ok\n";
print "----------------------------------------------\n";

my $clean_ko = $test_ko;
$clean_ko =~ s/$regex/[MATCH]/g;
print "Test KO Output (Failing rows must remain unconsumed):\n$clean_ko\n";
print "==============================================\n";
