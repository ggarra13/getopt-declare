#!/usr/bin/env ruby

require "Getopt/Declare"

$VERSION = "1.00b";

config = Getopt::Declare.new( <<'EOCONFIG', ['-CONFIG']);
	[strict]
	min = <n>	Minimum value [required]
	max = <n>	Maximum value

EOCONFIG

print "min: ", config['min'], "\n" if config['min']
print "max: ", config['max'], "\n" if config['max']

args = Getopt::Declare.new( <<'EOARGS' )
General options:
[tight]
     -e <f:i>..<t:i>		Set expansion factor to specified range
                        [requires: <file>]
                                { puts "k = [#{f}..#{t}]" }

     -e [<k:n>...]		Set expansion factor to <k> (or 2 by default)
                        [required]
                                { k = [2] unless k
                                  print "k = [", k.join(','), "]\n"; }

	-b <blen:i>		Use byte length of <blen> 
                        [excludes: -a +c]
                                { print "byte len: #{blen}\n"; }

	<file>...		Process files [required] [implies: -a]
                                { print "files: #{file}\n"; }

	-a [<n:n>]		Process all data [except item <n>]
                            { print "proc all\n"; print "except #{n}\n" if n }

	-fab			The fabulous option (is always required :-)
                        [required]
                                { defer { print "fabulous!\n" } }

File creation options:

	+c <file>		Create file [mutex: +c -a]
                                { print "create: file\n"; }

	+d <file>		Duplicate file [implies: -a and -b 8]
                        	This is a second line
                                { print "dup (+d) $file\n"; }
	--dup <file>		[ditto] (long form)

	-how <n:i>		Set height to <n>       [repeatable]

Garbling options:

	-g [<seed:i>]		Garble output with optional seed [requires: +c]
                                { print "garbling with #{seed}\n"; }
	-i			Case insensitive garbling [required]
                                { print "insensitive\n"; }
	-s			Case sensitive garbling 
	-w			WaReZ m0De 6aRBL1N6 

	[mutex: -i -s -w]
EOARGS

print args.unused

#args.usage();
__END__
