#!/usr/bin/env ruby

require "Getopt/Declare"

args = Getopt::Declare.new(<<'EOPARAM', ['-BUILD'])

   ============================================================
   Required parameter:

   -in <infile>		Input file [required]

   ------------------------------------------------------------

   Optional parameters:

   (The first two are mutually exclusive) [mutex: -r -p]

   -r[and[om]]		Output in random order
   -p[erm[ute]]		Output all permutations

   ---------------------------------------------------

   -out <outfile>		Optional output file

   ------------------------------------------------------------
   Note: this program is known to run very slowly of files with
   long individual lines.
   ============================================================
EOPARAM


# TRY STANDARD CONFIG FILES
args.parse(['-CONFIG'])
#args.parse('/usr/local/config/.demo_rc')

#args.parse() or raise "cannot parse";

print args.inspect
