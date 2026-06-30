#!/usr/bin/env perl
# ==============================================================================
# DESIGN PATTERN: NO-PIPE MULTIPLEXER (ADVANCED BINARY GATE & ROUTING)
# ORIGINAL CONCEPT & LOGIC : jpfr(jpfrx)
# COMMENT & PRESENTATION : AI Assistant (Google Gemini)
# LICENSE: MIT License (c) 2026 jpfrx - Full terms in root LICENSE file
# ==============================================================================
use strict;
use warnings;
use re 'eval';
#use re 'debug';

# ARGV[0] (M) : Input file to parse
# ARGV[1] (M) : Output file name (contains remnant of the parsed file)
# ARGV[2] (M) : Selected Router/Multiplexer version (see bellow)
# ARGV[3] (M) : Y/N



# Selected Router/Multiplexer version : 
# ======================================

# --- REGEX ASSEMBLY ---
# FL-LI     flawed_router_li             flawed_multiplexer_li
# FL-IM     flawed_router_im             flawed_multiplexer_li
# ACFL-LI   actuallyflawed_router_li     actuallyflawed_multiplexer_li
# ACFL-IM   actuallyflawed_router_im     actuallyflawed_multiplexer_im
# JPFRX-LI  jpfrx_router_li              jpfrx_multiplexer_li
# JPFRX-IM  jpfrx_router_im              jpfrx_multiplexer_im
# ADVG-LI   jprfx_advgate_router_li      jprfx_advgate_multiplexer_li
# ADVG-IM   jprfx_advgate_router_im      jprfx_advgate_multiplexer_im
# NADVG-IM  jprfx_nestadvgate_router_im  jprfx_nestadvgate_multiplexer_im


# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl small_test.txt small_result.txt FL-LI N 2>FL-LI-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl small_test.txt small_result.txt FL-IM N 2>FL-IM-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl small_test.txt small_result.txt ACFL-LI N 2>ACFL-LI-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl small_test.txt small_result.txt ACFL-IM N 2>ACFL-IM-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl small_test.txt small_result.txt JPFRX-LI N 2>JPFRX-LI-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl small_test.txt small_result.txt JPFRX-IM N 2>JPFRX-JPFRX-IM-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl small_test.txt small_result.txt ADVG-LI N 2>ADVG-LI-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl small_test.txt small_result.txt ADVG-IM N 2>ADVG-IM-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl small_test.txt small_result.txt NADVG-IM N 2>NADVG-IM-debug.txt

# reset ; /usr/bin/time -v perl benchmark-monolythique.pl small_test.txt small_result.txt FL-LI N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl small_test.txt small_result.txt FL-IM N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl small_test.txt small_result.txt ACFL-LI N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl small_test.txt small_result.txt ACFL-IM N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl small_test.txt small_result.txt JPFRX-LI N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl small_test.txt small_result.txt JPFRX-IM N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl small_test.txt small_result.txt ADVG-LI N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl small_test.txt small_result.txt ADVG-IM N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl small_test.txt small_result.txt NADVG-IM N



# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl moderate_test.txt moderate_result.txt FL-LI N 2>FL-LI-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl moderate_test.txt moderate_result.txt FL-IM N 2>FL-IM-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl moderate_test.txt moderate_result.txt ACFL-LI N 2>ACFL-LI-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl moderate_test.txt moderate_result.txt ACFL-IM N 2>ACFL-IM-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl moderate_test.txt moderate_result.txt JPFRX-LI N 2>JPFRX-LI-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl moderate_test.txt moderate_result.txt JPFRX-IM N 2>JPFRX-JPFRX-IM-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl moderate_test.txt moderate_result.txt ADVG-LI N 2>ADVG-LI-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl moderate_test.txt moderate_result.txt ADVG-IM N 2>ADVG-IM-debug.txt
# reset ; /usr/bin/time -v perl -Mre=debug benchmark-monolythique.pl moderate_test.txt moderate_result.txt NADVG-IM N 2>NADVG-IM-debug.txt

# reset ; /usr/bin/time -v perl benchmark-monolythique.pl moderate_test.txt moderate_result.txt FL-LI N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl moderate_test.txt moderate_result.txt FL-IM N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl moderate_test.txt moderate_result.txt ACFL-LI N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl moderate_test.txt moderate_result.txt ACFL-IM N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl moderate_test.txt moderate_result.txt JPFRX-LI N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl moderate_test.txt moderate_result.txt JPFRX-IM N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl moderate_test.txt moderate_result.txt ADVG-LI N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl moderate_test.txt moderate_result.txt ADVG-IM N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl moderate_test.txt moderate_result.txt NADVG-IM N



# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt FL-LI N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt FL-IM N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt ACFL-LI N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt ACFL-IM N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt JPFRX-LI N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt JPFRX-IM N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt ADVG-LI N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt ADVG-IM N
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt NADVG-IM N




# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt FL-LI Y
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt FL-IM Y
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt ACFL-LI Y
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt ACFL-IM Y
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt JPFRX-LI Y
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt JPFRX-IM Y
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt ADVG-LI Y
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt ADVG-IM Y
# reset ; /usr/bin/time -v perl benchmark-monolythique.pl huge_test.txt huge_result.txt NADVG-IM Y

# perl -Mre=Debug,COMPILE,EXTRA 

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





my(${opt_flag})=$ARGV[3];
my(${opt})='';

# Disable Perl regex optimization
if(${opt_flag} eq "N"){
	${opt}='(?{})';
}
elsif(${opt_flag} eq "Y"){
	${opt}='';
}
else{
	${opt}='';
}


################################################################################################################################
#####  FLAWED MULTIPLEXER - LINEAR
################################################################################################################################
my(${flawed_router_li})=
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
my(${flawed_multiplexer_li})=
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
#####  FLAWED MULTIPLEXER - IMBRICATED
################################################################################################################################
my(${flawed_router_im})=
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
my(${flawed_multiplexer_im})=
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
#####  ACTUALLY FLAWED MULTIPLEXER - LINEAR
################################################################################################################################
my(${actuallyflawed_router_li})=
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
		'(?<integer_radix16>(?<!(?&pp))(?i:'.${opt}.'hexadecimal|'.${opt}.'integer_radix16)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix15>(?<!(?&pp))(?i:'.${opt}.'pentadecimal|'.${opt}.'integer_radix15)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix14>(?<!(?&pp))(?i:'.${opt}.'tetradecimal|'.${opt}.'integer_radix14)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix13>(?<!(?&pp))(?i:'.${opt}.'tridecimal|'.${opt}.'integer_radix13)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix12>(?<!(?&pp))(?i:'.${opt}.'dozenal|'.${opt}.'duodecimal|'.${opt}.'integer_radix12)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix11>(?<!(?&pp))(?i:'.${opt}.'undecimal|'.${opt}.'integer_radix11)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix10>(?<!(?&pp))(?i:'.${opt}.'decimal|'.${opt}.'integer_radix10)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix9>(?<!(?&pp))(?i:'.${opt}.'nonary|'.${opt}.'integer_radix9)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix8>(?<!(?&pp))(?i:'.${opt}.'octal|'.${opt}.'integer_radix8)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix7>(?<!(?&pp))(?i:'.${opt}.'septenary|'.${opt}.'integer_radix7)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix6>(?<!(?&pp))(?i:'.${opt}.'senary|'.${opt}.'integer_radix6)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix5>(?<!(?&pp))(?i:'.${opt}.'quinary|'.${opt}.'integer_radix5)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix4>(?<!(?&pp))(?i:'.${opt}.'quaternary|'.${opt}.'integer_radix4)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix3>(?<!(?&pp))(?i:'.${opt}.'ternary|'.${opt}.'integer_radix3)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix2>(?<!(?&pp))(?i:'.${opt}.'binary|'.${opt}.'integer_radix2)(?!(?&pp)))'.
		'|'.
		'(?<real_decimal>(?<!(?&pp))(?i:'.${opt}.'real)(?!(?&pp)))'.
		'|'.
		'(?<string>(?<!(?&pp))(?i:'.${opt}.'text|'.${opt}.'default|'.${opt}.'[^:\n]+)(?!(?&pp)))'. # global else condition
	')';
my(${actuallyflawed_multiplexer_li})=
	'(?<m>'.

		'(?(<date_yyyymmdd_dash>)'.${opt}.'\d{4,4}-\d{1,2}-\d{1,2})'.
		'|'.
		'(?(<date_yyyymmdd_slash>)'.${opt}.'\d{4,4}/\d{1,2}/\d{1,2})'.
		'|'.
		'(?(<date_ddmmyyyy_dash>)'.${opt}.'\d{1,2}-\d{1,2}-\d{4,4})'.
		'|'.
		'(?(<date_ddmmyyyy_slash>)'.${opt}.'\d{1,2}/\d{1,2}/\d{4,4})'.
		'|'.
		'(?(<integer_radix16>)'.${opt}.'[0-9a-fA-F]+)'.
		'|'.
		'(?(<integer_radix15>)'.${opt}.'[0-9a-eA-E]+)'.
		'|'.
		'(?(<integer_radix14>)'.${opt}.'[0-9a-dA-D]+)'.
		'|'.
		'(?(<integer_radix13>)'.${opt}.'[0-9a-cA-C]+)'.
		'|'.
		'(?(<integer_radix12>)'.${opt}.'[0-9a-bA-B]+)'.
		'|'.
		'(?(<integer_radix11>)'.${opt}.'[0-9aA]+)'.
		'|'.
		'(?(<integer_radix10>)'.${opt}.'[0-9]+)'.
		'|'.
		'(?(<integer_radix9>)'.${opt}.'[0-8]+)'.
		'|'.
		'(?(<integer_radix8>)'.${opt}.'[0-7]+)'.
		'|'.
		'(?(<integer_radix7>)'.${opt}.'[0-6]+)'.
		'|'.
		'(?(<integer_radix6>)'.${opt}.'[0-5]+)'.
		'|'.
		'(?(<integer_radix5>)'.${opt}.'[0-4]+)'.
		'|'.
		'(?(<integer_radix4>)'.${opt}.'[0-3]+)'.
		'|'.
		'(?(<integer_radix3>)'.${opt}.'[0-2]+)'.
		'|'.
		'(?(<integer_radix2>)'.${opt}.'[01]+)'.
		'|'.
		'(?(<real_decimal>)(?:'.${opt}.'[0-9]*\.[0-9]+|'.${opt}.'[0-9]+\.[0-9]*))'.
		'|'.
		'(?(<string>)'.${opt}.'[\d\w_\s]+)'. 
	')';

################################################################################################################################
#####  ACTUALLY FLAWED MULTIPLEXER - IMBRICATED
################################################################################################################################
my(${actuallyflawed_router_im})=
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
		'(?<integer_radix16>(?<!(?&pp))(?i:'.${opt}.'hexadecimal|'.${opt}.'integer_radix16)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix15>(?<!(?&pp))(?i:'.${opt}.'pentadecimal|'.${opt}.'integer_radix15)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix14>(?<!(?&pp))(?i:'.${opt}.'tetradecimal|'.${opt}.'integer_radix14)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix13>(?<!(?&pp))(?i:'.${opt}.'tridecimal|'.${opt}.'integer_radix13)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix12>(?<!(?&pp))(?i:'.${opt}.'dozenal|'.${opt}.'duodecimal|'.${opt}.'integer_radix12)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix11>(?<!(?&pp))(?i:'.${opt}.'undecimal|'.${opt}.'integer_radix11)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix10>(?<!(?&pp))(?i:'.${opt}.'decimal|'.${opt}.'integer_radix10)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix9>(?<!(?&pp))(?i:'.${opt}.'nonary|'.${opt}.'integer_radix9)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix8>(?<!(?&pp))(?i:'.${opt}.'octal|'.${opt}.'integer_radix8)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix7>(?<!(?&pp))(?i:'.${opt}.'septenary|'.${opt}.'integer_radix7)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix6>(?<!(?&pp))(?i:'.${opt}.'senary|'.${opt}.'integer_radix6)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix5>(?<!(?&pp))(?i:'.${opt}.'quinary|'.${opt}.'integer_radix5)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix4>(?<!(?&pp))(?i:'.${opt}.'quaternary|'.${opt}.'integer_radix4)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix3>(?<!(?&pp))(?i:'.${opt}.'ternary|'.${opt}.'integer_radix3)(?!(?&pp)))'.
		'|'.
		'(?<integer_radix2>(?<!(?&pp))(?i:'.${opt}.'binary|'.${opt}.'integer_radix2)(?!(?&pp)))'.
		'|'.
		'(?<real_decimal>(?<!(?&pp))(?i:'.${opt}.'real)(?!(?&pp)))'.
		'|'.
		'(?<string>(?<!(?&pp))(?i:'.${opt}.'text|'.${opt}.'default|'.${opt}.'[^:\n]+)(?!(?&pp)))'. # global else condition
	')';
my(${actuallyflawed_multiplexer_im})=
	'(?<m>'.

		'(?(<date_yyyymmdd_dash>)'.${opt}.'\d{4,4}-\d{1,2}-\d{1,2}|'.
		'(?(<date_yyyymmdd_slash>)'.${opt}.'\d{4,4}/\d{1,2}/\d{1,2}|'.
		'(?(<date_ddmmyyyy_dash>)'.${opt}.'\d{1,2}-\d{1,2}-\d{4,4}|'.
		'(?(<date_ddmmyyyy_slash>)'.${opt}.'\d{1,2}/\d{1,2}/\d{4,4}|'.
		'(?(<integer_radix16>)'.${opt}.'[0-9a-fA-F]+|'.
		'(?(<integer_radix15>)'.${opt}.'[0-9a-eA-E]+|'.
		'(?(<integer_radix14>)'.${opt}.'[0-9a-dA-D]+|'.
		'(?(<integer_radix13>)'.${opt}.'[0-9a-cA-C]+|'.
		'(?(<integer_radix12>)'.${opt}.'[0-9a-bA-B]+|'.
		'(?(<integer_radix11>)'.${opt}.'[0-9aA]+|'.
		'(?(<integer_radix10>)'.${opt}.'[0-9]+|'.
		'(?(<integer_radix9>)'.${opt}.'[0-8]+|'.
		'(?(<integer_radix8>)'.${opt}.'[0-7]+|'.
		'(?(<integer_radix7>)'.${opt}.'[0-6]+|'.
		'(?(<integer_radix6>)'.${opt}.'[0-5]+|'.
		'(?(<integer_radix5>)'.${opt}.'[0-4]+|'.
		'(?(<integer_radix4>)'.${opt}.'[0-3]+|'.
		'(?(<integer_radix3>)'.${opt}.'[0-2]+|'.
		'(?(<integer_radix2>)'.${opt}.'[01]+|'.
		'(?(<real_decimal>)(?:'.${opt}.'[0-9]*\.[0-9]+|'.${opt}.'[0-9]+\.[0-9]*)|'.
		'(?(<string>)'.${opt}.'[\d\w_\s]+)))))))))))))))))))))'. 
	')';

################################################################################################################################
#####  JPFRX MULTIPLEXER - LINEAR
################################################################################################################################
my(${jpfrx_router_li})=
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
my(${jpfrx_multiplexer_li})=
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
#####  JPFRX MULTIPLEXER - IMBRICATED
################################################################################################################################
my(${jpfrx_router_im})=
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
my(${jpfrx_multiplexer_im})=
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
##### JPFRX ADVANCED GATE - LINEAR
################################################################################################################################
my(${jprfx_advgate_router_li})=
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
		'(?i:'.${opt}.'text|'.${opt}.'default|'.${opt}.'[^:\n]++)'. # global else condition
	')';
my(${jprfx_advgate_multiplexer_li})=
	'(?<m>'.

		'(?(<type>)'. # classic (?(patter)yes|no) form
			'(?(<date_yyyymmdd_dash>)'.${opt}.'\d{4,4}+-\d{1,2}+-\d{1,2}+)'.
			'(?(<date_yyyymmdd_slash>)'.${opt}.'\d{4,4}+/\d{1,2}+/\d{1,2}+)'.
			'(?(<date_ddmmyyyy_dash>)'.${opt}.'\d{1,2}+-\d{1,2}+-\d{4,4}+)'.
			'(?(<date_ddmmyyyy_slash>)'.${opt}.'\d{1,2}+/\d{1,2}+/\d{4,4}+)'.
			'(?(<integer_radix2>)'.${opt}.'[01]++)'.
			'(?(<integer_radix3>)'.${opt}.'[0-2]++)'.
			'(?(<integer_radix4>)'.${opt}.'[0-3]++)'.
			'(?(<integer_radix5>)'.${opt}.'[0-4]++)'.
			'(?(<integer_radix6>)'.${opt}.'[0-5]++)'.
			'(?(<integer_radix7>)'.${opt}.'[0-6]++)'.
			'(?(<integer_radix8>)'.${opt}.'[0-7]++)'.
			'(?(<integer_radix9>)'.${opt}.'[0-8]++)'.
			'(?(<integer_radix10>)'.${opt}.'[0-9]++)'.
			'(?(<integer_radix11>)'.${opt}.'[0-9aA]++)'.
			'(?(<integer_radix12>)'.${opt}.'[0-9a-bA-B]++)'.
			'(?(<integer_radix13>)'.${opt}.'[0-9a-cA-C]++)'.
			'(?(<integer_radix14>)'.${opt}.'[0-9a-dA-D]++)'.
			'(?(<integer_radix15>)'.${opt}.'[0-9a-eA-E]++)'.
			'(?(<integer_radix16>)'.${opt}.'[0-9a-fA-F]++)'.
			'(?(<real_decimal>)(?>'.${opt}.'[0-9]++\.[0-9]*+|'.${opt}.'[0-9]*+\.[0-9]++))'.
			'|'.
			''.${opt}.'[\d\w_\s]++'. # else (allowing whatever you define)
		')'.
	')';

################################################################################################################################
##### JPFRX ADVANCED GATE - IMBRICATED
################################################################################################################################
my(${jprfx_advgate_router_im})=
	'(?>'.
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
my(${jprfx_advgate_multiplexer_im})=
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
##### JPFRX NESTED ADVANCED GATE - IMBRICATED
################################################################################################################################
my(${jprfx_nestadvgate_router_im})=
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
		'(?i:'.${opt}.'text|'.${opt}.'default|'.${opt}.'[^:\n]++)'. # global else condition
	')';
my(${jprfx_nestadvgate_multiplexer_im})=
	'(?<m>'.
		'(?(<date>)'. # classic (?(patter)yes|no) form
			'(?(<date_yyyymmdd_dash>)'.${opt}.'\d{4,4}+-\d{1,2}+-\d{1,2}+|'.
			'(?(<date_yyyymmdd_slash>)'.${opt}.'\d{4,4}+/\d{1,2}+/\d{1,2}+|'.
			'(?(<date_ddmmyyyy_dash>)'.${opt}.'\d{1,2}+-\d{1,2}+-\d{4,4}+|'.
			'(?(<date_ddmmyyyy_slash>)'.${opt}.'\d{1,2}+/\d{1,2}+/\d{4,4}+))))'.

			'|'.

			'(?(<integer>)'.
				'(?(<integer_digit>)'.
					'(?(<integer_radix2>)'.${opt}.'[01]++|'.
					'(?(<integer_radix3>)'.${opt}.'[0-2]++|'.
					'(?(<integer_radix4>)'.${opt}.'[0-3]++|'.
					'(?(<integer_radix5>)'.${opt}.'[0-4]++|'.
					'(?(<integer_radix6>)'.${opt}.'[0-5]++|'.
					'(?(<integer_radix7>)'.${opt}.'[0-6]++|'.
					'(?(<integer_radix8>)'.${opt}.'[0-7]++|'.
					'(?(<integer_radix9>)'.${opt}.'[0-8]++|'.
					'(?(<integer_radix10>)'.${opt}.'[0-9]++)))))))))'.
					'|'.
					'(?(<integer_word>)'.
						'(?(<integer_radix11>)'.${opt}.'[0-9aA]++|'.
						'(?(<integer_radix12>)'.${opt}.'[0-9a-bA-B]++|'.
						'(?(<integer_radix13>)'.${opt}.'[0-9a-cA-C]++|'.
						'(?(<integer_radix14>)'.${opt}.'[0-9a-dA-D]++|'.
						'(?(<integer_radix15>)'.${opt}.'[0-9a-eA-E]++|'.
						'(?(<integer_radix16>)'.${opt}.'[0-9a-fA-F]++))))))'.
#						'|'.
#						'(?(<default_integer>)[0-9]+)'.
					')'.
				')'.
				'|'.
				'(?(<real>)'.
					#'(?(<real_decimal>)[0-9]*\.[0-9]+|[0-9]+\.[0-9]*)'.
					'(?(<real_decimal>)(?:'.${opt}.'[0-9]++\.[0-9]*+|'.${opt}.'[0-9]*+\.[0-9]++))'.
					'|'.
					''.${opt}.'[\d\w_\s]++'. # else (allowing whatever you define)
				')'.
			')'.
		')'.
	')';




my(${inputfile})=$ARGV[0];
my(${outputfile})=$ARGV[1];

my(${test})=read_from_file(${inputfile});




# --- REGEX ASSEMBLY ---
# FL-LI     flawed_router_li             flawed_multiplexer_li
# FL-IM     flawed_router_im             flawed_multiplexer_li
# ACFL-LI   actuallyflawed_router_li     actuallyflawed_multiplexer_li
# ACFL-IM   actuallyflawed_router_im     actuallyflawed_multiplexer_im
# JPFRX-LI  jpfrx_router_li              jpfrx_multiplexer_li
# JPFRX-IM  jpfrx_router_im              jpfrx_multiplexer_im
# ADVG-LI   jprfx_advgate_router_li      jprfx_advgate_multiplexer_li
# ADVG-IM   jprfx_advgate_router_im      jprfx_advgate_multiplexer_im
# NADVG-IM  jprfx_nestadvgate_router_im  jprfx_nestadvgate_multiplexer_im
my(${router})='';
my(${multiplexer})='';
my(${selected_romu})=$ARGV[2];
if(${selected_romu} eq "FL-LI"){
	${router}=${flawed_router_li};
	${multiplexer}=${flawed_multiplexer_li};
}
elsif(${selected_romu} eq "FL-IM"){
	${router}=${flawed_router_im};
	${multiplexer}=${flawed_multiplexer_li};
}
elsif(${selected_romu} eq "ACFL-LI"){
	${router}=${actuallyflawed_router_li};
	${multiplexer}=${actuallyflawed_multiplexer_li};
}
elsif(${selected_romu} eq "ACFL-IM"){
	${router}=${actuallyflawed_router_im};
	${multiplexer}=${actuallyflawed_multiplexer_li};
}
elsif(${selected_romu} eq "JPFRX-LI"){
	${router}=${jpfrx_router_li};
	${multiplexer}=${jpfrx_multiplexer_li};
}
elsif(${selected_romu} eq "JPFRX-IM"){
	${router}=${jpfrx_router_im};
	${multiplexer}=${jpfrx_multiplexer_im};
}
elsif(${selected_romu} eq "ADVG-LI"){
	${router}=${jprfx_advgate_router_li};
	${multiplexer}=${jprfx_advgate_multiplexer_li};
}
elsif(${selected_romu} eq "ADVG-IM"){
	${router}=${jprfx_advgate_router_im};
	${multiplexer}=${jprfx_advgate_multiplexer_im};
}
elsif(${selected_romu} eq "NADVG-IM"){
	${router}=${jprfx_nestadvgate_router_im};
	${multiplexer}=${jprfx_nestadvgate_multiplexer_im};
}
else{
	${router}='UNKNOWN_ROUTER';
	${multiplexer}='UNKNOWN_MULTIPLEXER';
}
my(${regex})=
	'(?s:'.
#	'('.
#		'(?m:^)\s*+TYPE\('.${router}.'\):\s*+(?:#[^\n]*+)?\n'.
		'\h*+TYPE\('.${router}.'\):\h*+(?:#[^\n]*+)?\n'.
		'(?:'.
#			'\s*+'.${multiplexer}.'\s*+(?>,\s*+'.${multiplexer}.'\s*+)*+(?>#[^\n]*+)?\n'.
			'\h*+'.${multiplexer}.'\h*+(?:,\h*+'.${multiplexer}.'\h*+)*+(?>#[^\n]*+)?\n'.
#			'|'.
#			'(?>[^\n#]*+)(?>#[^\n]*+)?\n'.
		')++'.
	')++'
	;




# --- EXECUTION ---
print "=== RUNNING PARAMETERS ===\n";
print "===  - Input file : ".${inputfile}."\n";
print "===  - Output file : ".${outputfile}."\n";
print "===  - Pattern type : ".${selected_romu}."\n";
print "===  - Optimization flag : ".${opt_flag}." ${opt}\n";

${test}=~s/(?s:${regex})/[GOTIT]\n/s;

#print "--------------------\n";
#print "ROUTER: ${router}\n";
#print "MULTIPLEXER: ${multiplexer}\n";
#print "REGEX: ${regex}\n";

write_into_file(${selected_romu}."_".${outputfile},${test});
