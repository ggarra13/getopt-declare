#!/usr/bin/env ruby

require "Getopt/Declare"

def delold
  print "would have deleted\n"
end

args = Getopt::Declare.new(<<EOF)

		-a		Process all data

		-b <n:n>	Set mean byte length threshold to <N>
  					{ bytelen = n }

		+c <FILE>	Create new file <FILE>

		--del 		Delete old file
  					{ delold(); }

		delete 		[ditto]

		e <w:i>x<h:i>	Expand image to height <h> and width <w>
  					{ }

		-F <file>...	Process named file(s)
  					{ defer { file.each {|i| 
                                                  process(i) } } }

		=getrand [<n>]	Get a random number
				(or, optionally, <n> of them)
  					{ n = 1 unless n }

		--		Traditionally indicates end of arguments
  					{ finish }

EOF

print args.inspect
