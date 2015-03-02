#!/usr/bin/env perl
## Simple, general tokenizer, where the input has one sentence per line (thus only final period is tokenized)
## By Jon Dehdari, 2011-2015
## Changes this:  They thought, "Is 9.5 or 525,600 my favorite number?"  before seeing Dr. Bob's dog talk.
## To this:       They thought , " Is 9.5 or 525,600 my favorite number ? " before seeing Dr. Bob ' s dog talk .

use v5.8.0;
use strict;
use Getopt::Long;
use utf8;
binmode(STDIN,  ":utf8");
binmode(STDOUT, ":utf8");

## Defaults
my $lower = undef;
my $digit = 0;

my $usage     = <<"END_OF_USAGE";
tok-tok.pl    (c) 2011-2015 Jon Dehdari - Apache License v2

Usage:    perl $0 [options] < text.txt > text.tok.txt

Function: A fast, simple, multilingual tokenizer

Options:
 -h, --help        Print this usage
 -d, --digit <u>   Conflate all digits to <u> . Note that 0 is reserved
 -l, --lower       Lowercase text

END_OF_USAGE

GetOptions(
    'h|help|?'		=> sub { print $usage; exit; },
    'd|digit=i'		=> \$digit,
    'l|lower'		=> \$lower,
) or die $usage;



while (<>) {
  m/^#/ && print && next;	# skip comments

  s/ / /g;					# replace no-break spaces with normal spaces
  s/([،;؛¿!"\])}»›”؟%٪°±©®।॥…])/ $1 /g;

  ## URL-unfriendly characters: [:/?#]
  s{:(?!//)}{ : }g;
  s{\?(?!\S)}{ ? }g;
  m{://} or m{\S+\.\S+/\S+} or s{/}{ / }g; # not exactly right: doesn't tokenize legit slash if on same line as URL
  s{ /}{ / }g;

  s/& /&amp; /g;		# replace problematic character with numeric character reference
  s/\t/ &#9; /g;		# replace problematic character with numeric character reference
  s/\|/ &#124; /g;		# replace problematic character with numeric character reference
  s/(\p{Open_Punctuation})/ $1 /g;
  s/(\p{Close_Punctuation})/ $1 /g;
  s/(,{2,})/ $1 /g;			# Fake German,Czech, etc.: „
  s/(?<!,)([,،])(?![,\d])/ $1 /g;		# don't tokenize 1,000,000
  s/([({\[“‘„‚«‹「『])/ $1 /g;
  s/(['’`])/ $1 /g;		# just tokenize problematic hyphen/single quote, etc.
  s/ ` ` / `` /g;		# stupid quotes
  s/ ' ' / '' /g;		# stupid quotes
  s/(\p{Currency_Symbol})/ $1 /g;
  s/([–—])/ $1 /g;		# En dash and em dash
  s/\s+$/\n/g;			# rm trailing spaces
  s/(-{2,})/ $1 /g;			# Fake en-dash, etc.
  s/(\.{2,})/ $1 /g;	# treat multiple periods as a thing (eg. ellipsis)
  s/(?<!\.)\.$/ ./g;			# don't tokenize period unless it ends the line (and isn't preceded by another period)
  s/(?<!\.)\.\s*(["'’»›”]) *$/ . $1/g;			# don't tokenize period unless it's near the end of the line: eg. " ... stuff."
  s/^ +//g;				# rm leading  spaces
  s/ {2,}/ /g;			# merge duplicate spaces

  $digit and s/\d/$digit/g;

  if ($lower) {
    print lc;
  } else {
    print;
  }
}
