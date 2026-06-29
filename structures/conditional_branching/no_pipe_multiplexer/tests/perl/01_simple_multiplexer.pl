#!/usr/bin/env perl
# ==============================================================================
# DESIGN PATTERN: NO-PIPE MULTIPLEXER (SIMPLE VERIFICATION)
# ORIGINAL CONCEPT & LOGIC : jpfr(jpfrx)
# COMMENT & PRESENTATION : AI Assistant (Google Gemini)
# LICENSE: MIT License (c) 2026 jpfrx - Full terms in root LICENSE file
# ==============================================================================
use strict;
use warnings;

# --- MODULE A: The Input Router ---
my $input_nopipe =
	'(?<input>' .
		'(?<one>(?<![0-9])1(?![0-9]))?' .
		'(?<two>(?<![0-9])2(?![0-9]))?' .
		'(?<three>(?<![0-9])3(?![0-9]))?' .
		'(?<else>(?<![0-9])[4-9](?![0-9]))?' .
	')';

# --- MODULE B: The Linear Multiplexer (Passive Evaluator) ---
my $multiplexer_nopipe =
	'(?<multiplexer>' .
		'(?(<one>)1+)' .
		'(?(<two>)2+)' .
		'(?(<three>)3+)' .
		'(?(<else>)[4-9]+)' .
	')';

# --- TEST DATASETS ---
my $test_ok = '
INPUT(3): 33, 3, 3333
INPUT(5): 55, 5, 5555
INPUT(2): 22, 2, 2222
INPUT(1): 11, 1, 1111';

my $test_ko = '
INPUT(3): 33, 4, 3333
INPUT(5): 55, 5, 5155
INPUT(2): 25, 2, 2222
INPUT(1): 11, 6, 1111';

# --- REGEX ASSEMBLY ---
my $regex = qr/(?:
	\s*INPUT\($input_nopipe\):
	\s*$multiplexer_nopipe\s*(?:,\s*$multiplexer_nopipe\s*)*
)/x;

# --- EXECUTION ---
print "=== RUNNING SIMPLE MULTIPLEXER TEST ===\n";

my $clean_ok = $test_ok;
$clean_ok =~ s/$regex/[MATCH]/g;
print "Test OK Output:\n$clean_ok\n";
print "---------------------------------------\n";

my $clean_ko = $test_ko;
$clean_ko =~ s/$regex/[MATCH]/g;
print "Test KO Output (Should preserve failing lines):\n$clean_ko\n";
print "=======================================\n";
