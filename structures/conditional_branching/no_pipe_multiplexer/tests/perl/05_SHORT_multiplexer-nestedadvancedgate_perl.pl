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
		'(?(DEFINE)'.
			'(?<pp>[/\-_\w\d])'.
		')'.
		# Dates
		'(?<!(?&pp))'. # prevents empty <i> (deterministic)
		'(?<date>'.
			'(?<date_yyyymmdd_dash>(?<!(?&pp))(?i:yyyy-mm-dd)(?!(?&pp)))?'.
			'(?<date_yyyymmdd_slash>(?<!(?&pp))(?i:yyyy/mm/dd)(?!(?&pp)))?'.
			'(?<date_ddmmyyyy_dash>(?<!(?&pp))(?i:dd-mm-yyyy)(?!(?&pp)))?'.
			'(?<date_ddmmyyyy_slash>(?<!(?&pp))(?i:dd/mm/yyyy)(?!(?&pp)))?'.
			'(?<=(?&pp))'.
		')?'.
		# integer
#		'(?<!(?&pp))'.
		'(?<integer>'.
			'(?<integer_digit>'.
				'(?<!(?&pp))'.
				'(?<integer_radix2>(?<!(?&pp))(?i:binary|integer_radix2)(?!(?&pp)))?'.
				'(?<integer_radix3>(?<!(?&pp))(?i:ternary|integer_radix3)(?!(?&pp)))?'.
				'(?<integer_radix4>(?<!(?&pp))(?i:quaternary|integer_radix4)(?!(?&pp)))?'.
				'(?<integer_radix5>(?<!(?&pp))(?i:quinary|integer_radix5)(?!(?&pp)))?'.
				'(?<integer_radix6>(?<!(?&pp))(?i:senary|integer_radix6)(?!(?&pp)))?'.
				'(?<integer_radix7>(?<!(?&pp))(?i:septenary|integer_radix7)(?!(?&pp)))?'.
				'(?<integer_radix8>(?<!(?&pp))(?i:octal|integer_radix8)(?!(?&pp)))?'.
				'(?<integer_radix9>(?<!(?&pp))(?i:nonary|integer_radix9)(?!(?&pp)))?'.
				'(?<integer_radix10>(?<!(?&pp))(?i:decimal|integer_radix10)(?!(?&pp)))?'.
				'(?<=(?&pp))'.
			')?'.
			'(?<integer_word>'.
				'(?<!(?&pp))'.
				'(?<integer_radix11>(?<!(?&pp))(?i:undecimal|integer_radix11)(?!(?&pp)))?'.
				'(?<integer_radix12>(?<!(?&pp))(?i:dozenal|duodecimal|integer_radix12)(?!(?&pp)))?'.
				'(?<integer_radix13>(?<!(?&pp))(?i:tridecimal|integer_radix13)(?!(?&pp)))?'.
				'(?<integer_radix14>(?<!(?&pp))(?i:tetradecimal|integer_radix14)(?!(?&pp)))?'.
				'(?<integer_radix15>(?<!(?&pp))(?i:pentadecimal|integer_radix15)(?!(?&pp)))?'.
				'(?<integer_radix16>(?<!(?&pp))(?i:hexadecimal|integer_radix16)(?!(?&pp)))?'.
				'(?<=(?&pp))'.
			')?'.

#			'(?<default_integer>'.
#				'(?<!(?&pp))'.
#				'(?<>default_integer)?'.
#				'(?<=(?&pp))'.
#			')?'.
			'(?<=(?&pp))'.
		')?'.
		#'(?<=(?&pp))'.
		# real
		#'(?<!(?&pp))'.
		'(?<real>'.
			'(?<!(?&pp))'.
			'(?<real_decimal>(?<!(?&pp))(?i:real)(?!(?&pp)))?'.
			'(?<=(?&pp))'.
		')?'.
		'(?<=(?&pp))'.
		'|'.
		'(?:text|default|[^:\n]+)'. # global else condition
	')';


# --- MODULE B - O(N): The Conditional Multiplexer with Global Else ---
# If <i> is active, it executes the linear no-pipe sequential multiplexer.
# If <i> is empty, it instantly jumps to the global row-fallback branch.
my(${multiplexer_nopipe_sequential})=
	'(?<m>'.
		'(?(<date>)'. # classic (?(patter)yes|no) form
			'(?(<i0>)0+)'.
			'(?(<i1>)1+)'.
			'(?(<i2>)2+)'.
			'(?(<i3>)3+)'.
			'(?(<i4>)4+)'.
			'(?(<i5>)5+)'.
			'(?(<i6>)6+)'.
			'(?(<i7>)7+)'.
			'(?(<i8>)8+)'.
			'(?(<i9>)9+)'.
			'|'.
			'[a-z]+'. # else (allowing whatever you define)
		')'.
	')';

# --- MODULE B - O(logN): The Conditional Multiplexer with Global Else ---
# If <i> is active, it executes the nested no-pipe sequential multiplexer.
# If <i> is empty, it instantly jumps to the global row-fallback branch.
my(${multiplexer_nopipe_nested})=
	'(?<m>'.

		'(?(<date>)'. # classic (?(patter)yes|no) form
			'(?(<date_yyyymmdd_dash>)\d{4,4}-\d{1,2}-\d{1,2}|'.
			'(?(<date_yyyymmdd_slash>)\d{4,4}/\d{1,2}/\d{1,2}|'.
			'(?(<date_ddmmyyyy_dash>)\d{1,2}-\d{1,2}-\d{4,4}|'.
			'(?(<date_ddmmyyyy_slash>)\d{1,2}/\d{1,2}/\d{4,4}))))'.

			'|'.

			'(?(<integer>)'.
				'(?(<integer_digit>)'.
					'(?(<integer_radix2>)[01]+|'.
					'(?(<integer_radix3>)[0-2]+|'.
					'(?(<integer_radix4>)[0-3]+|'.
					'(?(<integer_radix5>)[0-4]+|'.
					'(?(<integer_radix6>)[0-5]+|'.
					'(?(<integer_radix7>)[0-6]+|'.
					'(?(<integer_radix8>)[0-7]+|'.
					'(?(<integer_radix9>)[0-8]+|'.
					'(?(<integer_radix10>)[0-9]+)))))))))'.
					'|'.
					'(?(<integer_word>)'.
						'(?(<integer_radix11>)[0-9aA]+|'.
						'(?(<integer_radix12>)[0-9a-bA-B]+|'.
						'(?(<integer_radix13>)[0-9a-cA-C]+|'.
						'(?(<integer_radix14>)[0-9a-dA-D]+|'.
						'(?(<integer_radix15>)[0-9a-eA-E]+|'.
						'(?(<integer_radix16>)[0-9a-fA-F]+))))))'.
#						'|'.
#						'(?(<default_integer>)[0-9]+)'.
					')'.
				')'.
				'|'.
				'(?(<real>)'.
					#'(?(<real_decimal>)[0-9]*\.[0-9]+|[0-9]+\.[0-9]*)'.
					'(?(<real_decimal>)(?:[0-9]*\.[0-9]+|[0-9]+\.[0-9]*))'.
					'|'.
					'[\d\w_\s]+'. # else (allowing whatever you define)
				')'.
			')'.
		')'.
	')';

# --- TEST DATASETS ---
my(${test_ko})='


';

my(${test_ok})='
yyyy-mm-dd: # date list
	2025-01-01 , 2025-02-01 , 2025-03-15 # Should be captured
	2026-01-01 , 2026-02-01 , 2026-03-15 # Should be captured
	2027-01-01 , 2027-02-01 , 2027/03/15 # Should not be captured (2026/03/15 rejected)
	2028-01-01 , 2028-02-01 , 2028-03-15 # Should be ignored (previous line rejected)
integer_radix2: #
	010001 , 0100010 , 00010 # Should be captured
	0 , 1 # Should be captured
	010001 , 01002010 , 00010 # Should not be captured (01002010 rejected)
	010001 , 0100010 , 00010 # Should be ignored (previous line rejected)
integer_radix8: #
	5001 , 0107010 , 1340 # Should be captured
	0 , 1 # Should be captured
	010001 , 01002010 , 00010 # Should be captured
	5001 , 0108010 , 1340 # Should not be captured (0108010 rejected)
	5001 , 0107010 , 1340 # Should be ignored (previous line rejected)
binary: #
	010001 , 0100010 , 00010 # Should be captured
	0 , 1 # Should be captured
	010001 , 01002010 , 00010 # Should not be captured (01002010 rejected)
	010001 , 0100010 , 00010 # Should be ignored (previous line rejected)
real:
	0.4 , .5 , 0. # Should be captured
	0.4 , .5 , 0. # Should be captured
	0.4 , . , 0. # Should not be captured (. rejected)
	0.4 , .5 , 0. # Should be ignored (previous line rejected)
text:
	valid text , valid text in second column # Should be captured
	second ligne , 251321 text # Should be captured
	valid text in first column , birthdate 2000-03-31 # Should not be captured (- rejected)
	valid text , valid text in second column # Should be ignored (previous line rejected)
';

my(${test_ok})='
yyyy-mm-dd: # date list
	2025-01-01 , 2025-02-01 , 2025-03-15 # Should be captured
	2026-01-01 , 2026-02-01 , 2026-03-15 # Should be captured
integer_radix2: #
	010001 , 0100010 , 00010 # Should be captured
	0 , 1 # Should be captured
integer_radix8: #
	5001 , 0107010 , 1340 # Should be captured
	0 , 1 # Should be captured
	010001 , 01002010 , 00010 # Should be captured
binary: #
	010001 , 0100010 , 00010 # Should be captured
	0 , 1 # Should be captured
real:
	0.4 , .5 , 0. # Should be captured
	0.4 , .5 , 0. # Should be captured
	0.4 , . , 0. # Should not be captured (. rejected)
	0.4 , .5 , 0. # Should be ignored (previous line rejected)
text:
	valid text , valid text in second column # Should be captured
	second ligne , 251321 text # Should be captured
';

#my(${test_ok})='
#integer_radix2: # binary
#	010001 , 0100010 , 00010
#
#';

# --- REGEX ASSEMBLY ---
my(${regex})=
	'(?s:'.
		${input_nopipe}.':\s*(?:#[^\n]*)?\n'.
		'(?:'.
			'\s*'.${multiplexer_nopipe_nested}.'(?:\s*,\s*'.${multiplexer_nopipe_nested}.')*\s*(?:#[^\n]*)?\n'.
		')+'.
	')';

# --- EXECUTION ---
print "=== RUNNING SHORT ADVANCED GATE MULTIPLEXER TEST ===\n";

#${test_ko}=~s/${regex}/[GOTIT]\n/gs;
#print "regex_ko : ${test_ko}\n";
#print "--------------------\n";
${test_ok}=~s/(?s:${regex})/[GOTIT]\n/gs;
print "regex_ok : ${test_ok}\n";
print "--------------------\n";
print "INPUT: ${input_nopipe}\n";
print "MULTIPLEXER: ${multiplexer_nopipe_nested}\n";
