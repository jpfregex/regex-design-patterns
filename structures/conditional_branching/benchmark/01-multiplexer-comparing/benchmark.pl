#!/usr/bin/env perl
# reset ; perl 05-JPRFX-MULTIPLEXER-nestedadvancedgate.pl 2> jpfrx-log.txt
# md5sum file1.txt file2.txt file3.txt
# ==============================================================================
# ORIGINAL CONCEPT & LOGIC : jpfr (jpfrx)
# LICENSE: MIT License (c) 2026 jpfrx - Full terms in root LICENSE file
# NOTE : This program will be properly commented soon
# ==============================================================================
use strict;
use warnings;
use re 'eval';
#use re 'debug';
# reset ; /usr/bin/time -v perl 06-unoptimized-NORMAL-MULTIPLEXER.pl
# reset ; /usr/bin/time -v perl 06-unoptimized-JPRFX-MULTIPLEXER-advancedgate-ON.pl 
# reset ; /usr/bin/time -v perl 06-unoptimized-NORMAL-MULTIPLEXER.pl 2>20260628-16h43-06-normal-debug.txt

#use re qw(Compile); 
# not supported use the commandline instead
#no re 'optimize';  # Disables static optimization passes in newer Perl versions
# /usr/bin/time -v perl -Mre=debug 05-JPRFX-MULTIPLEXER-nestedadvancedgate.pl > /dev/null 2>&1
# /usr/bin/time -v perl -Mre=no,optimize 05-JPRFX-MULTIPLEXER-nestedadvancedgate.pl



# reset ; /usr/bin/time -v perl -Mre=debug 07-BENCHMARK.pl small_test.txt NORM-ON N 2>07-NORM-ON-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug 07-BENCHMARK.pl small_test.txt NORM-OlogN N 2>07-NORM-OlogN-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug 07-BENCHMARK.pl small_test.txt JPFRX-ON N 2>07-JPFRX-ON-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug 07-BENCHMARK.pl small_test.txt JPFRX-OlogN N 2>07-JPFRX-OlogN-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug 07-BENCHMARK.pl small_test.txt ADVG-ON N 2>07-ADVG-ON-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug 07-BENCHMARK.pl small_test.txt ADVG-OlogN N 2>07-ADVG-OlogN-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug 07-BENCHMARK.pl small_test.txt NADVG-OlogsqrtN N 2>07-NADVG-OlogsqrtN-debug.txt

# reset ; /usr/bin/time -v perl 07-BENCHMARK.pl huge_stress_test.txt NORM-ON N
# reset ; /usr/bin/time -v perl 07-BENCHMARK.pl huge_stress_test.txt NORM-OlogN N
# reset ; /usr/bin/time -v perl 07-BENCHMARK.pl huge_stress_test.txt JPFRX-ON N
# reset ; /usr/bin/time -v perl 07-BENCHMARK.pl huge_stress_test.txt JPFRX-OlogN N
# reset ; /usr/bin/time -v perl 07-BENCHMARK.pl huge_stress_test.txt ADVG-ON N
# reset ; /usr/bin/time -v perl 07-BENCHMARK.pl huge_stress_test.txt ADVG-OlogN N
# reset ; /usr/bin/time -v perl 07-BENCHMARK.pl huge_stress_test.txt NADVG-OlogsqrtN N


# --- REGEX ASSEMBLY ---
# NORM-ON         router_mormal_ON             multiplexer_mormal_ON
# NORM-OlogN      router_mormal_OlogN          multiplexer_mormal_OlogN
# JPFRX-ON        router_jpfrx_ON              multiplexer_jpfrx_ON
# JPFRX-OlogN     router_jpfrx_logON           multiplexer_jpfrx_OlogN
# ADVG-ON         router_advgate_ON            multiplexer_advgate_ON
# ADVG-OlogN      router_advgate_OlogN         multiplexer_advgate_OlogN
# NADVG-OlogsqrtN router_nestadvgate_OlogsqrtN multiplexer_nestadvgate_OlogsqrtN




sub write_into_file{
	my ($filename,$content)=@_;
	open (FILEHANDLER,">$filename") || die "WARNING: Unable to open '$filename' (writting mode) \n";
	print FILEHANDLER $content;
	close (FILEHANDLER) || die "WARNING: Unable to close '$filename'\n";
}

sub read_from_file{
	my ($filename)=@_;
	my ($content)="";
	my ($line)='';
	open(FILEHANDLER,"$filename") || die "WARNING: Unable to open '$filename' (reading mode)\n";
	while($line=<FILEHANDLER>){
		$content.=$line;
	}
	close (FILEHANDLER) || die "WARNING: Unable to close '$filename'\n";
	return($content);
}





my(${opt})='';
if($ARGV[2] eq "N"){
	my(${opt})='(?{})';
}
elsif($ARGV[2] eq "Y"){
	my(${opt})='';
}
else{
	my(${opt})='';
}


################################################################################################################################
#####  NORMAL MULTIPLEXER O(N)
################################################################################################################################
my(${router_mormal_ON})=
	'(?:'.
		'(?(DEFINE)'.
			'(?<pp>[/\-_\w\d])'.
		')'.
		'(?<date_yyyymmdd_dash>(?<!(?&pp))(?i:'.${opt}.'yyyy-mm-dd)(?!(?&pp)))'.
		'|'.
		'(?<date_yyyymmdd_slash>(?<!(?&pp))(?i:'.${opt}.'yyyy/mm/dd)(?!(?&pp)))'.
		'|'.
		'(?<date_ddmmyyyy_dash>(?<!(?&pp))(?i:'.${opt}.'dd-mm-yyyy)(?!(?&pp)))'.
		'|'.
		'(?<date_ddmmyyyy_slash>(?<!(?&pp))(?i:'.${opt}.'dd/mm/yyyy)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix2>(?<!(?&pp))(?i:'.${opt}.'binary|'.${opt}.'integer_radix2)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix3>(?<!(?&pp))(?i:'.${opt}.'ternary|'.${opt}.'integer_radix3)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix4>(?<!(?&pp))(?i:'.${opt}.'quaternary|'.${opt}.'integer_radix4)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix5>(?<!(?&pp))(?i:'.${opt}.'quinary|'.${opt}.'integer_radix5)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix6>(?<!(?&pp))(?i:'.${opt}.'senary|'.${opt}.'integer_radix6)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix7>(?<!(?&pp))(?i:'.${opt}.'septenary|'.${opt}.'integer_radix7)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix8>(?<!(?&pp))(?i:'.${opt}.'octal|'.${opt}.'integer_radix8)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix9>(?<!(?&pp))(?i:'.${opt}.'nonary|'.${opt}.'integer_radix9)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix10>(?<!(?&pp))(?i:'.${opt}.'decimal|'.${opt}.'integer_radix10)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix11>(?<!(?&pp))(?i:'.${opt}.'undecimal|'.${opt}.'integer_radix11)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix12>(?<!(?&pp))(?i:'.${opt}.'dozenal|'.${opt}.'duodecimal|'.${opt}.'integer_radix12)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix13>(?<!(?&pp))(?i:'.${opt}.'tridecimal|'.${opt}.'integer_radix13)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix14>(?<!(?&pp))(?i:'.${opt}.'tetradecimal|'.${opt}.'integer_radix14)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix15>(?<!(?&pp))(?i:'.${opt}.'pentadecimal|'.${opt}.'integer_radix15)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix16>(?<!(?&pp))(?i:'.${opt}.'hexadecimal|'.${opt}.'integer_radix16)(?!(?&pp)))'.
		'|'.
		'(?<real_decimal>(?<!(?&pp))(?i:'.${opt}.'real)(?!(?&pp)))'.
		'|'.
		'(?<string>(?<!(?&pp))(?i:'.${opt}.'text|'.${opt}.'default|'.${opt}.'[^:\n]+)(?!(?&pp)))'. # global else condition
	')';
my(${multiplexer_mormal_ON})=
	'(?<m>'.

		'(?(<date_yyyymmdd_dash>)'.${opt}.'\d{4,4}-\d{1,2}-\d{1,2})'.
		'|'.
		'(?(<date_yyyymmdd_slash>)'.${opt}.'\d{4,4}/\d{1,2}/\d{1,2})'.
		'|'.
		'(?(<date_ddmmyyyy_dash>)'.${opt}.'\d{1,2}-\d{1,2}-\d{4,4})'.
		'|'.
		'(?(<date_ddmmyyyy_slash>)'.${opt}.'\d{1,2}/\d{1,2}/\d{4,4})'.
		'|'.
		'(?(<integer_radix2>)'.${opt}.'[01]+)'.
		'|'.
		'(?(<integer_radix3>)'.${opt}.'[0-2]+)'.
		'|'.
		'(?(<integer_radix4>)'.${opt}.'[0-3]+)'.
		'|'.
		'(?(<integer_radix5>)'.${opt}.'[0-4]+)'.
		'|'.
		'(?(<integer_radix6>)'.${opt}.'[0-5]+)'.
		'|'.
		'(?(<integer_radix7>)'.${opt}.'[0-6]+)'.
		'|'.
		'(?(<integer_radix8>)'.${opt}.'[0-7]+)'.
		'|'.
		'(?(<integer_radix9>)'.${opt}.'[0-8]+)'.
		'|'.
		'(?(<integer_radix10>)'.${opt}.'[0-9]+)'.
		'|'.
		'(?(<integer_radix11>)'.${opt}.'[0-9aA]+)'.
		'|'.
		'(?(<integer_radix12>)'.${opt}.'[0-9a-bA-B]+)'.
		'|'.
		'(?(<integer_radix13>)'.${opt}.'[0-9a-cA-C]+)'.
		'|'.
		'(?(<integer_radix14>)'.${opt}.'[0-9a-dA-D]+)'.
		'|'.
		'(?(<integer_radix15>)'.${opt}.'[0-9a-eA-E]+)'.
		'|'.
		'(?(<integer_radix16>)'.${opt}.'[0-9a-fA-F]+)'.
		'|'.
		'(?(<real_decimal>)(?:'.${opt}.'[0-9]*\.[0-9]+|'.${opt}.'[0-9]+\.[0-9]*))'.
		'|'.
		'(?(<string>)'.${opt}.'[\d\w_\s]+)'. 
	')';


################################################################################################################################
#####  NORMAL MULTIPLEXER O(log(N))
################################################################################################################################
my(${router_mormal_OlogN})=
	'(?:'.
		'(?(DEFINE)'.
			'(?<pp>[/\-_\w\d])'.
		')'.
		'(?<date_yyyymmdd_dash>(?<!(?&pp))(?i:'.${opt}.'yyyy-mm-dd)(?!(?&pp)))'.
		'|'.
		'(?<date_yyyymmdd_slash>(?<!(?&pp))(?i:'.${opt}.'yyyy/mm/dd)(?!(?&pp)))'.
		'|'.
		'(?<date_ddmmyyyy_dash>(?<!(?&pp))(?i:'.${opt}.'dd-mm-yyyy)(?!(?&pp)))'.
		'|'.
		'(?<date_ddmmyyyy_slash>(?<!(?&pp))(?i:'.${opt}.'dd/mm/yyyy)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix2>(?<!(?&pp))(?i:'.${opt}.'binary|'.${opt}.'integer_radix2)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix3>(?<!(?&pp))(?i:'.${opt}.'ternary|'.${opt}.'integer_radix3)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix4>(?<!(?&pp))(?i:'.${opt}.'quaternary|'.${opt}.'integer_radix4)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix5>(?<!(?&pp))(?i:'.${opt}.'quinary|'.${opt}.'integer_radix5)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix6>(?<!(?&pp))(?i:'.${opt}.'senary|'.${opt}.'integer_radix6)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix7>(?<!(?&pp))(?i:'.${opt}.'septenary|'.${opt}.'integer_radix7)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix8>(?<!(?&pp))(?i:'.${opt}.'octal|'.${opt}.'integer_radix8)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix9>(?<!(?&pp))(?i:'.${opt}.'nonary|'.${opt}.'integer_radix9)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix10>(?<!(?&pp))(?i:'.${opt}.'decimal|'.${opt}.'integer_radix10)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix11>(?<!(?&pp))(?i:'.${opt}.'undecimal|'.${opt}.'integer_radix11)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix12>(?<!(?&pp))(?i:'.${opt}.'dozenal|'.${opt}.'duodecimal|'.${opt}.'integer_radix12)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix13>(?<!(?&pp))(?i:'.${opt}.'tridecimal|'.${opt}.'integer_radix13)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix14>(?<!(?&pp))(?i:'.${opt}.'tetradecimal|'.${opt}.'integer_radix14)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix15>(?<!(?&pp))(?i:'.${opt}.'pentadecimal|'.${opt}.'integer_radix15)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix16>(?<!(?&pp))(?i:'.${opt}.'hexadecimal|'.${opt}.'integer_radix16)(?!(?&pp)))'.
		'|'.
		'(?<real_decimal>(?<!(?&pp))(?i:'.${opt}.'real)(?!(?&pp)))'.
		'|'.
		'(?<string>(?<!(?&pp))(?i:'.${opt}.'text|'.${opt}.'default|'.${opt}.'[^:\n]+)(?!(?&pp)))'. # global else condition
	')';
my(${multiplexer_mormal_OlogN})=
	'(?<m>'.

		'(?(<date_yyyymmdd_dash>)'.${opt}.'\d{4,4}-\d{1,2}-\d{1,2}|'.
		'(?(<date_yyyymmdd_slash>)'.${opt}.'\d{4,4}/\d{1,2}/\d{1,2}|'.
		'(?(<date_ddmmyyyy_dash>)'.${opt}.'\d{1,2}-\d{1,2}-\d{4,4}|'.
		'(?(<date_ddmmyyyy_slash>)'.${opt}.'\d{1,2}/\d{1,2}/\d{4,4}|'.
		'(?(<integer_radix2>)'.${opt}.'[01]+|'.
		'(?(<integer_radix3>)'.${opt}.'[0-2]+|'.
		'(?(<integer_radix4>)'.${opt}.'[0-3]+|'.
		'(?(<integer_radix5>)'.${opt}.'[0-4]+|'.
		'(?(<integer_radix6>)'.${opt}.'[0-5]+|'.
		'(?(<integer_radix7>)'.${opt}.'[0-6]+|'.
		'(?(<integer_radix8>)'.${opt}.'[0-7]+|'.
		'(?(<integer_radix9>)'.${opt}.'[0-8]+|'.
		'(?(<integer_radix10>)'.${opt}.'[0-9]+|'.
		'(?(<integer_radix11>)'.${opt}.'[0-9aA]+|'.
		'(?(<integer_radix12>)'.${opt}.'[0-9a-bA-B]+|'.
		'(?(<integer_radix13>)'.${opt}.'[0-9a-cA-C]+|'.
		'(?(<integer_radix14>)'.${opt}.'[0-9a-dA-D]+|'.
		'(?(<integer_radix15>)'.${opt}.'[0-9a-eA-E]+|'.
		'(?(<integer_radix16>)'.${opt}.'[0-9a-fA-F]+|'.
		'(?(<real_decimal>)(?:'.${opt}.'[0-9]*\.[0-9]+|'.${opt}.'[0-9]+\.[0-9]*)|'.
		'(?(<string>)'.${opt}.'[\d\w_\s]+)))))))))))))))))))))'. 
	')';

################################################################################################################################
#####  JPFRX MULTIPLEXER O(N)
################################################################################################################################
my(${router_jpfrx_ON})=
	'(?:'.
		'(?(DEFINE)'.
			'(?<pp>[/\-_\w\d])'.
		')'.
		# Dates
		'(?<!(?&pp))'. # prevents empty <i> (deterministic)
		'(?<type>'.
			'(?<date_yyyymmdd_dash>(?<!(?&pp))(?i:'.${opt}.'yyyy-mm-dd)(?!(?&pp)))?'.
			'(?<date_yyyymmdd_slash>(?<!(?&pp))(?i:'.${opt}.'yyyy/mm/dd)(?!(?&pp)))?'.
			'(?<date_ddmmyyyy_dash>(?<!(?&pp))(?i:'.${opt}.'dd-mm-yyyy)(?!(?&pp)))?'.
			'(?<date_ddmmyyyy_slash>(?<!(?&pp))(?i:'.${opt}.'dd/mm/yyyy)(?!(?&pp)))?'.
			'(?<integer_radix2>(?<!(?&pp))(?i:'.${opt}.'binary|'.${opt}.'integer_radix2)(?!(?&pp)))?'.
			'(?<integer_radix3>(?<!(?&pp))(?i:'.${opt}.'ternary|'.${opt}.'integer_radix3)(?!(?&pp)))?'.
			'(?<integer_radix4>(?<!(?&pp))(?i:'.${opt}.'quaternary|'.${opt}.'integer_radix4)(?!(?&pp)))?'.
			'(?<integer_radix5>(?<!(?&pp))(?i:'.${opt}.'quinary|'.${opt}.'integer_radix5)(?!(?&pp)))?'.
			'(?<integer_radix6>(?<!(?&pp))(?i:'.${opt}.'senary|'.${opt}.'integer_radix6)(?!(?&pp)))?'.
			'(?<integer_radix7>(?<!(?&pp))(?i:'.${opt}.'septenary|'.${opt}.'integer_radix7)(?!(?&pp)))?'.
			'(?<integer_radix8>(?<!(?&pp))(?i:'.${opt}.'octal|'.${opt}.'integer_radix8)(?!(?&pp)))?'.
			'(?<integer_radix9>(?<!(?&pp))(?i:'.${opt}.'nonary|'.${opt}.'integer_radix9)(?!(?&pp)))?'.
			'(?<integer_radix10>(?<!(?&pp))(?i:'.${opt}.'decimal|'.${opt}.'integer_radix10)(?!(?&pp)))?'.
			'(?<integer_radix11>(?<!(?&pp))(?i:'.${opt}.'undecimal|'.${opt}.'integer_radix11)(?!(?&pp)))?'.
			'(?<integer_radix12>(?<!(?&pp))(?i:'.${opt}.'dozenal|'.${opt}.'duodecimal|'.${opt}.'integer_radix12)(?!(?&pp)))?'.
			'(?<integer_radix13>(?<!(?&pp))(?i:'.${opt}.'tridecimal|'.${opt}.'integer_radix13)(?!(?&pp)))?'.
			'(?<integer_radix14>(?<!(?&pp))(?i:'.${opt}.'tetradecimal|'.${opt}.'integer_radix14)(?!(?&pp)))?'.
			'(?<integer_radix15>(?<!(?&pp))(?i:'.${opt}.'pentadecimal|'.${opt}.'integer_radix15)(?!(?&pp)))?'.
			'(?<integer_radix16>(?<!(?&pp))(?i:'.${opt}.'hexadecimal|'.${opt}.'integer_radix16)(?!(?&pp)))?'.
			'(?<real_decimal>(?<!(?&pp))(?i:'.${opt}.'real)(?!(?&pp)))?'.
			'(?<string>(?<!(?&pp))(?i:'.${opt}.'text|'.${opt}.'default|'.${opt}.'[^:\n]+)(?!(?&pp)))?'.
			'(?<=(?&pp))'.
		')'.
	')';
my(${multiplexer_jpfrx_ON})=
	'(?<m>'.

		'(?(<type>)'. # classic (?(patter)yes|no) form
			'(?(<date_yyyymmdd_dash>)'.${opt}.'\d{4,4}-\d{1,2}-\d{1,2})'.
			'(?(<date_yyyymmdd_slash>)'.${opt}.'\d{4,4}/\d{1,2}/\d{1,2})'.
			'(?(<date_ddmmyyyy_dash>)'.${opt}.'\d{1,2}-\d{1,2}-\d{4,4})'.
			'(?(<date_ddmmyyyy_slash>)'.${opt}.'\d{1,2}/\d{1,2}/\d{4,4})'.
			'(?(<integer_radix2>)'.${opt}.'[01]+)'.
			'(?(<integer_radix3>)'.${opt}.'[0-2]+)'.
			'(?(<integer_radix4>)'.${opt}.'[0-3]+)'.
			'(?(<integer_radix5>)'.${opt}.'[0-4]+)'.
			'(?(<integer_radix6>)'.${opt}.'[0-5]+)'.
			'(?(<integer_radix7>)'.${opt}.'[0-6]+)'.
			'(?(<integer_radix8>)'.${opt}.'[0-7]+)'.
			'(?(<integer_radix9>)'.${opt}.'[0-8]+)'.
			'(?(<integer_radix10>)'.${opt}.'[0-9]+)'.
			'(?(<integer_radix11>)'.${opt}.'[0-9aA]+)'.
			'(?(<integer_radix12>)'.${opt}.'[0-9a-bA-B]+)'.
			'(?(<integer_radix13>)'.${opt}.'[0-9a-cA-C]+)'.
			'(?(<integer_radix14>)'.${opt}.'[0-9a-dA-D]+)'.
			'(?(<integer_radix15>)'.${opt}.'[0-9a-eA-E]+)'.
			'(?(<integer_radix16>)'.${opt}.'[0-9a-fA-F]+)'.
			'(?(<real_decimal>)(?:'.${opt}.'[0-9]*\.[0-9]+|'.${opt}.'[0-9]+\.[0-9]*))'.
			'(?(<string>)'.${opt}.'[\d\w_\s]+)'.
		')'.
	')';

################################################################################################################################
#####  JPFRX MULTIPLEXER O(log(N))
################################################################################################################################
my(${router_jpfrx_OlogN})=
	'(?:'.
		'(?(DEFINE)'.
			'(?<pp>[/\-_\w\d])'.
		')'.
		# Dates
		'(?<!(?&pp))'. # prevents empty <i> (deterministic)
		'(?<type>'.
			'(?<date_yyyymmdd_dash>(?<!(?&pp))(?i:'.${opt}.'yyyy-mm-dd)(?!(?&pp)))?'.
			'(?<date_yyyymmdd_slash>(?<!(?&pp))(?i:'.${opt}.'yyyy/mm/dd)(?!(?&pp)))?'.
			'(?<date_ddmmyyyy_dash>(?<!(?&pp))(?i:'.${opt}.'dd-mm-yyyy)(?!(?&pp)))?'.
			'(?<date_ddmmyyyy_slash>(?<!(?&pp))(?i:'.${opt}.'dd/mm/yyyy)(?!(?&pp)))?'.
			'(?<integer_radix2>(?<!(?&pp))(?i:'.${opt}.'binary|'.${opt}.'integer_radix2)(?!(?&pp)))?'.
			'(?<integer_radix3>(?<!(?&pp))(?i:'.${opt}.'ternary|'.${opt}.'integer_radix3)(?!(?&pp)))?'.
			'(?<integer_radix4>(?<!(?&pp))(?i:'.${opt}.'quaternary|'.${opt}.'integer_radix4)(?!(?&pp)))?'.
			'(?<integer_radix5>(?<!(?&pp))(?i:'.${opt}.'quinary|'.${opt}.'integer_radix5)(?!(?&pp)))?'.
			'(?<integer_radix6>(?<!(?&pp))(?i:'.${opt}.'senary|'.${opt}.'integer_radix6)(?!(?&pp)))?'.
			'(?<integer_radix7>(?<!(?&pp))(?i:'.${opt}.'septenary|'.${opt}.'integer_radix7)(?!(?&pp)))?'.
			'(?<integer_radix8>(?<!(?&pp))(?i:'.${opt}.'octal|'.${opt}.'integer_radix8)(?!(?&pp)))?'.
			'(?<integer_radix9>(?<!(?&pp))(?i:'.${opt}.'nonary|'.${opt}.'integer_radix9)(?!(?&pp)))?'.
			'(?<integer_radix10>(?<!(?&pp))(?i:'.${opt}.'decimal|'.${opt}.'integer_radix10)(?!(?&pp)))?'.
			'(?<integer_radix11>(?<!(?&pp))(?i:'.${opt}.'undecimal|'.${opt}.'integer_radix11)(?!(?&pp)))?'.
			'(?<integer_radix12>(?<!(?&pp))(?i:'.${opt}.'dozenal|'.${opt}.'duodecimal|'.${opt}.'integer_radix12)(?!(?&pp)))?'.
			'(?<integer_radix13>(?<!(?&pp))(?i:'.${opt}.'tridecimal|'.${opt}.'integer_radix13)(?!(?&pp)))?'.
			'(?<integer_radix14>(?<!(?&pp))(?i:'.${opt}.'tetradecimal|'.${opt}.'integer_radix14)(?!(?&pp)))?'.
			'(?<integer_radix15>(?<!(?&pp))(?i:'.${opt}.'pentadecimal|'.${opt}.'integer_radix15)(?!(?&pp)))?'.
			'(?<integer_radix16>(?<!(?&pp))(?i:'.${opt}.'hexadecimal|'.${opt}.'integer_radix16)(?!(?&pp)))?'.
			'(?<real_decimal>(?<!(?&pp))(?i:'.${opt}.'real)(?!(?&pp)))?'.
			'(?<string>(?<!(?&pp))(?i:'.${opt}.'text|'.${opt}.'default|'.${opt}.'[^:\n]+)(?!(?&pp)))?'.
			'(?<=(?&pp))'.
		')'.
	')';
my(${multiplexer_jpfrx_OlogN})=
	'(?<m>'.

		'(?(<type>)'.
			'(?(<date_yyyymmdd_dash>)'.${opt}.'\d{4,4}-\d{1,2}-\d{1,2}|'.
			'(?(<date_yyyymmdd_slash>)'.${opt}.'\d{4,4}/\d{1,2}/\d{1,2}|'.
			'(?(<date_ddmmyyyy_dash>)'.${opt}.'\d{1,2}-\d{1,2}-\d{4,4}|'.
			'(?(<date_ddmmyyyy_slash>)'.${opt}.'\d{1,2}/\d{1,2}/\d{4,4}|'.
			'(?(<integer_radix2>)'.${opt}.'[01]+|'.
			'(?(<integer_radix3>)'.${opt}.'[0-2]+|'.
			'(?(<integer_radix4>)'.${opt}.'[0-3]+|'.
			'(?(<integer_radix5>)'.${opt}.'[0-4]+|'.
			'(?(<integer_radix6>)'.${opt}.'[0-5]+|'.
			'(?(<integer_radix7>)'.${opt}.'[0-6]+|'.
			'(?(<integer_radix8>)'.${opt}.'[0-7]+|'.
			'(?(<integer_radix9>)'.${opt}.'[0-8]+|'.
			'(?(<integer_radix10>)'.${opt}.'[0-9]+|'.
			'(?(<integer_radix11>)'.${opt}.'[0-9aA]+|'.
			'(?(<integer_radix12>)'.${opt}.'[0-9a-bA-B]+|'.
			'(?(<integer_radix13>)'.${opt}.'[0-9a-cA-C]+|'.
			'(?(<integer_radix14>)'.${opt}.'[0-9a-dA-D]+|'.
			'(?(<integer_radix15>)'.${opt}.'[0-9a-eA-E]+|'.
			'(?(<integer_radix16>)'.${opt}.'[0-9a-fA-F]+|'.
			'(?(<real_decimal>)(?:'.${opt}.'[0-9]*\.[0-9]+|'.${opt}.'[0-9]+\.[0-9]*)|'.
			'(?(<string>)'.${opt}.'[\d\w_\s]+)))))))))))))))))))))'.
		')'.
	')';


################################################################################################################################
#####  JPFRX MULTIPLEXER O(log(sqrt(N)))
################################################################################################################################




################################################################################################################################
##### JPFRX ADVANCED GATE O(N)
################################################################################################################################
my(${router_advgate_ON})=
	'(?:'.
		'(?(DEFINE)'.
			'(?<pp>[/\-_\w\d])'.
		')'.
		# Dates
		'(?<!(?&pp))'. # prevents empty <i> (deterministic)
		'(?<type>'.
			'(?<date_yyyymmdd_dash>(?<!(?&pp))(?i:'.${opt}.'yyyy-mm-dd)(?!(?&pp)))?'.
			'(?<date_yyyymmdd_slash>(?<!(?&pp))(?i:'.${opt}.'yyyy/mm/dd)(?!(?&pp)))?'.
			'(?<date_ddmmyyyy_dash>(?<!(?&pp))(?i:'.${opt}.'dd-mm-yyyy)(?!(?&pp)))?'.
			'(?<date_ddmmyyyy_slash>(?<!(?&pp))(?i:'.${opt}.'dd/mm/yyyy)(?!(?&pp)))?'.
			'(?<integer_radix2>(?<!(?&pp))(?i:'.${opt}.'binary|'.${opt}.'integer_radix2)(?!(?&pp)))?'.
			'(?<integer_radix3>(?<!(?&pp))(?i:'.${opt}.'ternary|'.${opt}.'integer_radix3)(?!(?&pp)))?'.
			'(?<integer_radix4>(?<!(?&pp))(?i:'.${opt}.'quaternary|'.${opt}.'integer_radix4)(?!(?&pp)))?'.
			'(?<integer_radix5>(?<!(?&pp))(?i:'.${opt}.'quinary|'.${opt}.'integer_radix5)(?!(?&pp)))?'.
			'(?<integer_radix6>(?<!(?&pp))(?i:'.${opt}.'senary|'.${opt}.'integer_radix6)(?!(?&pp)))?'.
			'(?<integer_radix7>(?<!(?&pp))(?i:'.${opt}.'septenary|'.${opt}.'integer_radix7)(?!(?&pp)))?'.
			'(?<integer_radix8>(?<!(?&pp))(?i:'.${opt}.'octal|'.${opt}.'integer_radix8)(?!(?&pp)))?'.
			'(?<integer_radix9>(?<!(?&pp))(?i:'.${opt}.'nonary|'.${opt}.'integer_radix9)(?!(?&pp)))?'.
			'(?<integer_radix10>(?<!(?&pp))(?i:'.${opt}.'decimal|'.${opt}.'integer_radix10)(?!(?&pp)))?'.
			'(?<integer_radix11>(?<!(?&pp))(?i:'.${opt}.'undecimal|'.${opt}.'integer_radix11)(?!(?&pp)))?'.
			'(?<integer_radix12>(?<!(?&pp))(?i:'.${opt}.'dozenal|'.${opt}.'duodecimal|'.${opt}.'integer_radix12)(?!(?&pp)))?'.
			'(?<integer_radix13>(?<!(?&pp))(?i:'.${opt}.'tridecimal|'.${opt}.'integer_radix13)(?!(?&pp)))?'.
			'(?<integer_radix14>(?<!(?&pp))(?i:'.${opt}.'tetradecimal|'.${opt}.'integer_radix14)(?!(?&pp)))?'.
			'(?<integer_radix15>(?<!(?&pp))(?i:'.${opt}.'pentadecimal|'.${opt}.'integer_radix15)(?!(?&pp)))?'.
			'(?<integer_radix16>(?<!(?&pp))(?i:'.${opt}.'hexadecimal|'.${opt}.'integer_radix16)(?!(?&pp)))?'.
			'(?<real_decimal>(?<!(?&pp))(?i:'.${opt}.'real)(?!(?&pp)))?'.
			'(?<=(?&pp))'.
		')'.
		'|'.
		'(?i:'.${opt}.'text|'.${opt}.'default|'.${opt}.'[^:\n]+)'. # global else condition
	')';
my(${multiplexer_advgate_ON})=
	'(?<m>'.

		'(?(<type>)'. # classic (?(patter)yes|no) form
			'(?(<date_yyyymmdd_dash>)'.${opt}.'\d{4,4}-\d{1,2}-\d{1,2})'.
			'(?(<date_yyyymmdd_slash>)'.${opt}.'\d{4,4}/\d{1,2}/\d{1,2})'.
			'(?(<date_ddmmyyyy_dash>)'.${opt}.'\d{1,2}-\d{1,2}-\d{4,4})'.
			'(?(<date_ddmmyyyy_slash>)'.${opt}.'\d{1,2}/\d{1,2}/\d{4,4})'.
			'(?(<integer_radix2>)'.${opt}.'[01]+)'.
			'(?(<integer_radix3>)'.${opt}.'[0-2]+)'.
			'(?(<integer_radix4>)'.${opt}.'[0-3]+)'.
			'(?(<integer_radix5>)'.${opt}.'[0-4]+)'.
			'(?(<integer_radix6>)'.${opt}.'[0-5]+)'.
			'(?(<integer_radix7>)'.${opt}.'[0-6]+)'.
			'(?(<integer_radix8>)'.${opt}.'[0-7]+)'.
			'(?(<integer_radix9>)'.${opt}.'[0-8]+)'.
			'(?(<integer_radix10>)'.${opt}.'[0-9]+)'.
			'(?(<integer_radix11>)'.${opt}.'[0-9aA]+)'.
			'(?(<integer_radix12>)'.${opt}.'[0-9a-bA-B]+)'.
			'(?(<integer_radix13>)'.${opt}.'[0-9a-cA-C]+)'.
			'(?(<integer_radix14>)'.${opt}.'[0-9a-dA-D]+)'.
			'(?(<integer_radix15>)'.${opt}.'[0-9a-eA-E]+)'.
			'(?(<integer_radix16>)'.${opt}.'[0-9a-fA-F]+)'.
			'(?(<real_decimal>)(?:'.${opt}.'[0-9]*\.[0-9]+|'.${opt}.'[0-9]+\.[0-9]*))'.
			'|'.
			''.${opt}.'[\d\w_\s]+'. # else (allowing whatever you define)
		')'.
	')';

################################################################################################################################
##### JPFRX ADVANCED GATE O(log(N))
################################################################################################################################
my(${router_advgate_OlogN})=
	'(?:'.
		'(?(DEFINE)'.
			'(?<pp>[/\-_\w\d])'.
		')'.
		# Dates
		'(?<!(?&pp))'. # prevents empty <i> (deterministic)
		'(?<type>'.
			'(?<date_yyyymmdd_dash>(?<!(?&pp))(?i:'.${opt}.'yyyy-mm-dd)(?!(?&pp)))?'.
			'(?<date_yyyymmdd_slash>(?<!(?&pp))(?i:'.${opt}.'yyyy/mm/dd)(?!(?&pp)))?'.
			'(?<date_ddmmyyyy_dash>(?<!(?&pp))(?i:'.${opt}.'dd-mm-yyyy)(?!(?&pp)))?'.
			'(?<date_ddmmyyyy_slash>(?<!(?&pp))(?i:'.${opt}.'dd/mm/yyyy)(?!(?&pp)))?'.
			'(?<integer_radix2>(?<!(?&pp))(?i:'.${opt}.'binary|'.${opt}.'integer_radix2)(?!(?&pp)))?'.
			'(?<integer_radix3>(?<!(?&pp))(?i:'.${opt}.'ternary|'.${opt}.'integer_radix3)(?!(?&pp)))?'.
			'(?<integer_radix4>(?<!(?&pp))(?i:'.${opt}.'quaternary|'.${opt}.'integer_radix4)(?!(?&pp)))?'.
			'(?<integer_radix5>(?<!(?&pp))(?i:'.${opt}.'quinary|'.${opt}.'integer_radix5)(?!(?&pp)))?'.
			'(?<integer_radix6>(?<!(?&pp))(?i:'.${opt}.'senary|'.${opt}.'integer_radix6)(?!(?&pp)))?'.
			'(?<integer_radix7>(?<!(?&pp))(?i:'.${opt}.'septenary|'.${opt}.'integer_radix7)(?!(?&pp)))?'.
			'(?<integer_radix8>(?<!(?&pp))(?i:'.${opt}.'octal|'.${opt}.'integer_radix8)(?!(?&pp)))?'.
			'(?<integer_radix9>(?<!(?&pp))(?i:'.${opt}.'nonary|'.${opt}.'integer_radix9)(?!(?&pp)))?'.
			'(?<integer_radix10>(?<!(?&pp))(?i:'.${opt}.'decimal|'.${opt}.'integer_radix10)(?!(?&pp)))?'.
			'(?<integer_radix11>(?<!(?&pp))(?i:'.${opt}.'undecimal|'.${opt}.'integer_radix11)(?!(?&pp)))?'.
			'(?<integer_radix12>(?<!(?&pp))(?i:'.${opt}.'dozenal|'.${opt}.'duodecimal|'.${opt}.'integer_radix12)(?!(?&pp)))?'.
			'(?<integer_radix13>(?<!(?&pp))(?i:'.${opt}.'tridecimal|'.${opt}.'integer_radix13)(?!(?&pp)))?'.
			'(?<integer_radix14>(?<!(?&pp))(?i:'.${opt}.'tetradecimal|'.${opt}.'integer_radix14)(?!(?&pp)))?'.
			'(?<integer_radix15>(?<!(?&pp))(?i:'.${opt}.'pentadecimal|'.${opt}.'integer_radix15)(?!(?&pp)))?'.
			'(?<integer_radix16>(?<!(?&pp))(?i:'.${opt}.'hexadecimal|'.${opt}.'integer_radix16)(?!(?&pp)))?'.
			'(?<real_decimal>(?<!(?&pp))(?i:'.${opt}.'real)(?!(?&pp)))?'.
			'(?<=(?&pp))'.
		')'.
		'|'.
		'(?i:'.${opt}.'text|'.${opt}.'default|'.${opt}.'[^:\n]+)'. # global else condition
	')';
my(${multiplexer_advgate_OlogN})=
	'(?<m>'.

		'(?(<type>)'. # classic (?(patter)yes|no) form
			'(?(<date_yyyymmdd_dash>)'.${opt}.'\d{4,4}-\d{1,2}-\d{1,2}|'.
			'(?(<date_yyyymmdd_slash>)'.${opt}.'\d{4,4}/\d{1,2}/\d{1,2}|'.
			'(?(<date_ddmmyyyy_dash>)'.${opt}.'\d{1,2}-\d{1,2}-\d{4,4}|'.
			'(?(<date_ddmmyyyy_slash>)'.${opt}.'\d{1,2}/\d{1,2}/\d{4,4}|'.
			'(?(<integer_radix2>)'.${opt}.'[01]+|'.
			'(?(<integer_radix3>)'.${opt}.'[0-2]+|'.
			'(?(<integer_radix4>)'.${opt}.'[0-3]+|'.
			'(?(<integer_radix5>)'.${opt}.'[0-4]+|'.
			'(?(<integer_radix6>)'.${opt}.'[0-5]+|'.
			'(?(<integer_radix7>)'.${opt}.'[0-6]+|'.
			'(?(<integer_radix8>)'.${opt}.'[0-7]+|'.
			'(?(<integer_radix9>)'.${opt}.'[0-8]+|'.
			'(?(<integer_radix10>)'.${opt}.'[0-9]+|'.
			'(?(<integer_radix11>)'.${opt}.'[0-9aA]+|'.
			'(?(<integer_radix12>)'.${opt}.'[0-9a-bA-B]+|'.
			'(?(<integer_radix13>)'.${opt}.'[0-9a-cA-C]+|'.
			'(?(<integer_radix14>)'.${opt}.'[0-9a-dA-D]+|'.
			'(?(<integer_radix15>)'.${opt}.'[0-9a-eA-E]+|'.
			'(?(<integer_radix16>)'.${opt}.'[0-9a-fA-F]+|'.
			'(?(<real_decimal>)(?:'.${opt}.'[0-9]*\.[0-9]+|'.${opt}.'[0-9]+\.[0-9]*)))))))))))))))))))))'.
			'|'.
			''.${opt}.'[\d\w_\s]+'. # else (allowing whatever you define)
		')'.
	')';

################################################################################################################################
##### JPFRX NESTED ADVANCED GATE O(log(sqrt(N))
################################################################################################################################
my(${router_nestadvgate_OlogsqrtN})=
	'(?:'.
		'(?(DEFINE)'.
			'(?<pp>[/\-_\w\d])'.
		')'.
		# Dates
		'(?<!(?&pp))'. # prevents empty <i> (deterministic)
		'(?<date>'.
			'(?<!(?&pp))'.
			'(?<date_yyyymmdd_dash>(?<!(?&pp))(?i:'.${opt}.'yyyy-mm-dd)(?!(?&pp)))?'.
			'(?<date_yyyymmdd_slash>(?<!(?&pp))(?i:'.${opt}.'yyyy/mm/dd)(?!(?&pp)))?'.
			'(?<date_ddmmyyyy_dash>(?<!(?&pp))(?i:'.${opt}.'dd-mm-yyyy)(?!(?&pp)))?'.
			'(?<date_ddmmyyyy_slash>(?<!(?&pp))(?i:'.${opt}.'dd/mm/yyyy)(?!(?&pp)))?'.
			'(?<=(?&pp))'.
		')?'.
		# integer
#		'(?<!(?&pp))'.
		'(?<integer>'.
			'(?<!(?&pp))'.
			'(?<integer_digit>'.
				'(?<!(?&pp))'.
				'(?<integer_radix2>(?<!(?&pp))(?i:'.${opt}.'binary|'.${opt}.'integer_radix2)(?!(?&pp)))?'.
				'(?<integer_radix3>(?<!(?&pp))(?i:'.${opt}.'ternary|'.${opt}.'integer_radix3)(?!(?&pp)))?'.
				'(?<integer_radix4>(?<!(?&pp))(?i:'.${opt}.'quaternary|'.${opt}.'integer_radix4)(?!(?&pp)))?'.
				'(?<integer_radix5>(?<!(?&pp))(?i:'.${opt}.'quinary|'.${opt}.'integer_radix5)(?!(?&pp)))?'.
				'(?<integer_radix6>(?<!(?&pp))(?i:'.${opt}.'senary|'.${opt}.'integer_radix6)(?!(?&pp)))?'.
				'(?<integer_radix7>(?<!(?&pp))(?i:'.${opt}.'septenary|'.${opt}.'integer_radix7)(?!(?&pp)))?'.
				'(?<integer_radix8>(?<!(?&pp))(?i:'.${opt}.'octal|'.${opt}.'integer_radix8)(?!(?&pp)))?'.
				'(?<integer_radix9>(?<!(?&pp))(?i:'.${opt}.'nonary|'.${opt}.'integer_radix9)(?!(?&pp)))?'.
				'(?<integer_radix10>(?<!(?&pp))(?i:'.${opt}.'decimal|'.${opt}.'integer_radix10)(?!(?&pp)))?'.
				'(?<=(?&pp))'.
			')?'.
			'(?<integer_word>'.
				'(?<!(?&pp))'.
				'(?<integer_radix11>(?<!(?&pp))(?i:'.${opt}.'undecimal|'.${opt}.'integer_radix11)(?!(?&pp)))?'.
				'(?<integer_radix12>(?<!(?&pp))(?i:'.${opt}.'dozenal|'.${opt}.'duodecimal|'.${opt}.'integer_radix12)(?!(?&pp)))?'.
				'(?<integer_radix13>(?<!(?&pp))(?i:'.${opt}.'tridecimal|'.${opt}.'integer_radix13)(?!(?&pp)))?'.
				'(?<integer_radix14>(?<!(?&pp))(?i:'.${opt}.'tetradecimal|'.${opt}.'integer_radix14)(?!(?&pp)))?'.
				'(?<integer_radix15>(?<!(?&pp))(?i:'.${opt}.'pentadecimal|'.${opt}.'integer_radix15)(?!(?&pp)))?'.
				'(?<integer_radix16>(?<!(?&pp))(?i:'.${opt}.'hexadecimal|'.${opt}.'integer_radix16)(?!(?&pp)))?'.
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
			'(?<real_decimal>(?<!(?&pp))(?i:'.${opt}.'real)(?!(?&pp)))?'.
			'(?<=(?&pp))'.
		')?'.
		'(?<=(?&pp))'.
		'|'.
		'(?i:'.${opt}.'text|'.${opt}.'default|'.${opt}.'[^:\n]+)'. # global else condition
	')';
my(${multiplexer_nestadvgate_OlogsqrtN})=
	'(?<m>'.

		'(?(<date>)'. # classic (?(patter)yes|no) form
			'(?(<date_yyyymmdd_dash>)'.${opt}.'\d{4,4}-\d{1,2}-\d{1,2}|'.
			'(?(<date_yyyymmdd_slash>)'.${opt}.'\d{4,4}/\d{1,2}/\d{1,2}|'.
			'(?(<date_ddmmyyyy_dash>)'.${opt}.'\d{1,2}-\d{1,2}-\d{4,4}|'.
			'(?(<date_ddmmyyyy_slash>)'.${opt}.'\d{1,2}/\d{1,2}/\d{4,4}))))'.

			'|'.

			'(?(<integer>)'.
				'(?(<integer_digit>)'.
					'(?(<integer_radix2>)'.${opt}.'[01]+|'.
					'(?(<integer_radix3>)'.${opt}.'[0-2]+|'.
					'(?(<integer_radix4>)'.${opt}.'[0-3]+|'.
					'(?(<integer_radix5>)'.${opt}.'[0-4]+|'.
					'(?(<integer_radix6>)'.${opt}.'[0-5]+|'.
					'(?(<integer_radix7>)'.${opt}.'[0-6]+|'.
					'(?(<integer_radix8>)'.${opt}.'[0-7]+|'.
					'(?(<integer_radix9>)'.${opt}.'[0-8]+|'.
					'(?(<integer_radix10>)'.${opt}.'[0-9]+)))))))))'.
					'|'.
					'(?(<integer_word>)'.
						'(?(<integer_radix11>)'.${opt}.'[0-9aA]+|'.
						'(?(<integer_radix12>)'.${opt}.'[0-9a-bA-B]+|'.
						'(?(<integer_radix13>)'.${opt}.'[0-9a-cA-C]+|'.
						'(?(<integer_radix14>)'.${opt}.'[0-9a-dA-D]+|'.
						'(?(<integer_radix15>)'.${opt}.'[0-9a-eA-E]+|'.
						'(?(<integer_radix16>)'.${opt}.'[0-9a-fA-F]+))))))'.
#						'|'.
#						'(?(<default_integer>)[0-9]+)'.
					')'.
				')'.
				'|'.
				'(?(<real>)'.
					#'(?(<real_decimal>)[0-9]*\.[0-9]+|[0-9]+\.[0-9]*)'.
					'(?(<real_decimal>)(?:'.${opt}.'[0-9]*\.[0-9]+|'.${opt}.'[0-9]+\.[0-9]*))'.
					'|'.
					''.${opt}.'[\d\w_\s]+'. # else (allowing whatever you define)
				')'.
			')'.
		')'.
	')';




my(${file})=$ARGV[0];
my(${test})=read_from_file(${file});




# --- REGEX ASSEMBLY ---
# NORM-ON         router_mormal_ON             multiplexer_mormal_ON
# NORM-OlogN      router_mormal_OlogN          multiplexer_mormal_OlogN
# JPFRX-ON        router_jpfrx_ON              multiplexer_jpfrx_ON
# JPFRX-OlogN     router_jpfrx_logON           multiplexer_jpfrx_OlogN
# ADVG-ON         router_advgate_ON            multiplexer_advgate_ON
# ADVG-OlogN      router_advgate_OlogN         multiplexer_advgate_OlogN
# NADVG-OlogsqrtN router_nestadvgate_OlogsqrtN multiplexer_nestadvgate_OlogsqrtN
my(${router})='';
my(${multiplexer})='';
my(${resfile})=$ARGV[0];
if($ARGV[1] eq "NORM-ON"){
	${router}=${router_mormal_ON};
	${multiplexer}=${multiplexer_mormal_ON};
}
elsif($ARGV[1] eq "NORM-OlogN"){
	${router}=${router_mormal_ON};
	${multiplexer}=${multiplexer_mormal_ON};
}
elsif($ARGV[1] eq "JPFRX-ON"){
	${router}=${router_jpfrx_ON};
	${multiplexer}=${multiplexer_jpfrx_ON};
}
elsif($ARGV[1] eq "JPFRX-OlogN"){
	${router}=${router_jpfrx_OlogN};
	${multiplexer}=${multiplexer_jpfrx_OlogN};
}
elsif($ARGV[1] eq "ADVG-ON"){
	${router}=${router_advgate_ON};
	${multiplexer}=${multiplexer_advgate_ON};
}
elsif($ARGV[1] eq "ADVG-OlogN"){
	${router}=${router_advgate_OlogN};
	${multiplexer}=${multiplexer_advgate_OlogN};
}
elsif($ARGV[1] eq "NADVG-OlogsqrtN"){
	${router}=${router_nestadvgate_OlogsqrtN};
	${multiplexer}=${multiplexer_nestadvgate_OlogsqrtN};
}
else{
	${router}='UNKNOWN_ROUTER';
	${multiplexer}='UNKNOWN_MULTIPLEXER';
}
my(${regex})=
	'(?s:'.
		'(?m:^\s*TYPE\()'.${router}.'\):\s*(?:#[^\n]*)?\n'.
		'(?:'.
			'\s*'.${multiplexer}.'(?:\s*,\s*'.${multiplexer}.')*\s*(?:#[^\n]*)?\n'.
		')+'.
	')';




# --- EXECUTION ---
print "=== RUNNING PARAMETERS ===\n";
print "===  - Test file : ".$ARGV[0]."\n";
print "===  - Pattern type : ".$ARGV[1]."\n";
print "===  - Optimization flag : ".$ARGV[2]."\n";

${test}=~s/(?s:${regex})/[GOTIT]\n/gs;
print "--------------------\n";
print "ROUTER: ${router}\n";
print "MULTIPLEXER: ${multiplexer}\n";
print "REGEX: ${regex}\n";

write_into_file(${resfile}."_".$ARGV[1].".txt",${test});

