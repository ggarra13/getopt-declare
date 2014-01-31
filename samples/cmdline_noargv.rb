#!/bin/env ruby

require "Getopt/Declare"

argv2 = '-in test'

# Parse options from another string instead of ARGV
args = Getopt::Declare.new(<<'EOPARAM', argv2 )

   ============================================================
   -in <infile>		Input file
   -r[and[om]]		Output in random order
   -p[erm[ute]]		Output all permutations
   -out <outfile>	Optional output file
   ============================================================
EOPARAM

puts args.inspect

# Parse options from another string instead of ARGV
argv3 = "-r -in argv3"
args.parse(argv3)
puts args.inspect

# Parse options from another array instead of ARGV
argv4 = [ '-in', 'opt with spaces' ]

args.parse(['-ARGV', argv4])
puts args.inspect
