#!/usr/bin/env perl
# ==============================================================================
# Script Name : generate_stress_test.pl
# Description : Highly customizable randomized data generator for benchmarking
#               and stress-testing lexical parsers against structural boundaries.
# Author      : Google AI
# Date        : June 2026
# License     : MIT License (https://opensource.org)
# ==============================================================================
# This script generates realistic, randomized text blocks across 22 data types
# (including varied date formats, numerical radices from base 2 to 16, reals,
# and text strings). It includes deliberate, injection-controlled corrupted rows 
# to empirically stress-test parser termination boundaries and backtracking limits.
# Examples : 
# perl generate_stress_test.pl --blocks=3 --valid=5 --after=5 --output=small_test.txt
# perl generate_stress_test.pl --blocks=150 --valid=4000 --after=1000 --output=medium_test.txt
# perl generate_stress_test.pl --blocks=400 --valid=10000 --after=5000 --output=huge_stress_test.txt
# ==============================================================================

use strict;
use warnings;
use Getopt::Long;


# --- Default Parameters (Overridable via Command Line) ---
my $num_blocks  = 5;       # Total number of type definition blocks
my $lines_valid = 1000;    # Number of valid data lines per block before an error
my $lines_after = 500;     # Number of lines generated AFTER an error (should be ignored)
my $min_items   = 3;       # Minimum data items per line
my $max_items   = 10;      # Maximum data items per line
my $output_file = "stress_test_data.txt";

GetOptions(
    'blocks=i'      => \$num_blocks,
    'valid=i'       => \$lines_valid,
    'after=i'       => \$lines_after,
    'min-items=i'   => \$min_items,
    'max-items=i'   => \$max_items,
    'output=s'      => \$output_file,
) or die "Error in command line arguments\n";

# --- Define Type Enums and Generators ---
my %types = (
    # Dates
    'yyyy-mm-dd'      => sub { sprintf("%04d-%02d-%02d", 1970+int(rand(60)), 1+int(rand(12)), 1+int(rand(28))) },
    'dd-mm-yyyy'      => sub { sprintf("%02d-%02d-%04d", 1+int(rand(28)), 1+int(rand(12)), 1970+int(rand(60))) },
    'yyyy/mm/dd'      => sub { sprintf("%04d/%02d/%02d", 1970+int(rand(60)), 1+int(rand(12)), 1+int(rand(28))) },
    'dd/mm/yyyy'      => sub { sprintf("%02d/%02d/%04d", 1+int(rand(28)), 1+int(rand(12)), 1970+int(rand(60))) },
    
    # Radix Integers (Dynamic creation using map)
    (map { 
        my $r = $_; 
        my @chars = (0..9, 'a'..'f', 'A'..'F')[0..$r-1];
        "integer_radix$r" => sub { join('', map { $chars[rand(@chars)] } 1..(2+int(rand(8)))) }
    } 2..16),
    
    # Radix Aliases
    'binary'          => sub { join('', map { (0,1)[rand(2)] } 1..(4+int(rand(12)))) },
    'ternary'         => sub { join('', map { (0..2)[rand(3)] } 1..(4+int(rand(12)))) },
    'quaternary'      => sub { join('', map { (0..3)[rand(4)] } 1..(4+int(rand(12)))) },
    'quinary'         => sub { join('', map { (0..4)[rand(5)] } 1..(4+int(rand(12)))) },
    'senary'          => sub { join('', map { (0..5)[rand(6)] } 1..(4+int(rand(12)))) },
    'septenary'       => sub { join('', map { (0..6)[rand(7)] } 1..(4+int(rand(12)))) },
    'octal'           => sub { join('', map { (0..7)[rand(8)] } 1..(4+int(rand(12)))) },
    'nonary'          => sub { join('', map { (0..8)[rand(9)] } 1..(4+int(rand(12)))) },
    'decimal'         => sub { int(rand(1000000)) },
    'undecimal'       => sub { join('', map { (0..9,'a','A')[rand(12)] } 1..6) },
    'duodecimal'      => sub { join('', map { (0..9,'a'..'b','A'..'B')[rand(14)] } 1..6) },
    'dozenal'         => sub { join('', map { (0..9,'a'..'b','A'..'B')[rand(14)] } 1..6) },
    'tridecimal'      => sub { join('', map { (0..9,'a'..'c','A'..'C')[rand(16)] } 1..6) },
    'tetradecimal'    => sub { join('', map { (0..9,'a'..'d','A'..'D')[rand(18)] } 1..6) },
    'pentadecimal'    => sub { join('', map { (0..9,'a'..'e','A'..'E')[rand(20)] } 1..6) },
    'hexadecimal'     => sub { join('', map { (0..9,'a'..'f','A'..'F')[rand(22)] } 1..6) },
    
    # Reals
    'real'            => sub { 
        my $type = int(rand(3));
        return sprintf("%d.%d", int(rand(100)), int(rand(100))) if $type == 0;
        return sprintf(".%d", int(rand(100))+1)                 if $type == 1;
        return sprintf("%d.", int(rand(100)))                   if $type == 2;
    },
    
    # Strings
    'text'            => sub { generate_text() },
    'default'         => sub { generate_text() },
);

# --- Broken/Invalid Data Generators ---
my %broken_generators = (
    'yyyy-mm-dd'   => sub { "2026/03/15" }, # Uses slashes instead of dashes
    'dd-mm-yyyy'   => sub { "15/03/2026" }, 
    'yyyy/mm/dd'   => sub { "2026-03-15" }, 
    'dd/mm/yyyy'   => sub { "15-03-2026" }, 
    'real'         => sub { "." },          # Standalone dot is invalid
    'text'         => sub { "broken text - birthdate 2000-03-31" }, # Has disallowed hyphens
    'default'      => sub { "broken text - birthdate 2000-03-31" },
    # Radix fallbacks: generate a character explicitly higher than the allowed base
    'DEFAULT'      => sub { my $type = shift; return $type =~ /radix(\d+)/ && $1 < 16 ? "99F" : "XYZ" }
);

# Helper for valid text blocks
sub generate_text {
    my @words = qw(valid text words sample data string token field column entry block item value);
    return join(' ', map { $words[rand(@words)] } 1..(2+int(rand(3))));
}

# --- Main Generation Logic ---
open my $out, '>', $output_file or die "Cannot open $output_file: $!";
print "Generating structural stress data into '$output_file'...\n";

my @available_types = keys %types;

for (1 .. $num_blocks) {
    # Pick a random type header
    my $current_type = $available_types[rand(@available_types)];
    
    # Write the header block with an optional comment
    my $header_comment = (rand() > 0.3) ? " # Type tracking block " . int(rand(100)) : "";
    print $out "TYPE($current_type):$header_comment\n";
    
    # 1. Generate strictly VALID lines
    for (1 .. $lines_valid) {
        my $num_cols = $min_items + int(rand($max_items - $min_items + 1));
        my @row = map { $types{$current_type}->() } 1 .. $num_cols;
        my $line_comment = (rand() > 0.5) ? " # Should be captured" : "";
        print $out "\t" . join(" , ", @row) . "$line_comment\n";
    }
    
    # 2. Generate the REJECTED/POISONED line (Triggers your parser stop condition)
    my $num_cols = $min_items + int(rand($max_items - $min_items + 1));
    my @row = map { $types{$current_type}->() } 1 .. ($num_cols - 1);
    
    # Insert the broken item at a random position in the row
    my $broken_item = exists $broken_generators{$current_type} 
                      ? $broken_generators{$current_type}->() 
                      : $broken_generators{'DEFAULT'}->($current_type);
    splice(@row, int(rand(@row + 1)), 0, $broken_item);
    
    print $out "\t" . join(" , ", @row) . " # Should NOT be captured ($broken_item rejected)\n";
    
    # 3. Generate IGNORED lines (Lines trailing after the error)
    for (1 .. $lines_after) {
        my $num_cols = $min_items + int(rand($max_items - $min_items + 1));
        my @row = map { $types{$current_type}->() } 1 .. $num_cols;
        print $out "\t" . join(" , ", @row) . " # Should be ignored (previous line rejected)\n";
    }
}

close $out;
print "Generation complete! Total blocks: $num_blocks. Check '$output_file'.\n";

