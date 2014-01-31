#!/usr/bin/env ruby

require "Getopt/Declare"

specification = %q%
        [debug]
        -list <l>...				ttt
        -out <out>				ttt
	in=<infile>				ttt
	+range <from> ..<to>			ttt
	--lines <start> - <stop>		ttt
	ignore bad lines			ttt
	<outfile>				ttt
	-copy <files>... <dir>			copy files to dir
	-range <from:i> [[..] [<to:i>] ]	opt. range
					{ to = 10 if to == "" } 
	
%


args = Getopt::Declare.new(specification)


puts args.inspect
