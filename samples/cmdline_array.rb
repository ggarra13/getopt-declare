#!/usr/bin/env ruby

require "Getopt/Declare"

args = Getopt::Declare.new( %q{

  		-v <value> [etc]	One or more values
  		<infile:if>		Input file [required]
  		-o <outfiles>...	Output files
  	} )

if args['-v']
  print  "Using value: ", args['-v']['<value>']
  print  " (etcetera)" if args['-v']['etc']
  print  "\n"
end


infile = File.new( args['<infile>'] )
data = infile

for outfile in args['-o']
  #outfile = File.new(outfile,'w')
  print "processed ",outfile
  #outfile.close
end
