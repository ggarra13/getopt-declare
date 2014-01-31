#!/usr/bin/env ruby

require "Getopt/Declare"


#  With the next specification, the <tt>-rev</tt> and/or <tt>-rand</tt> flags
#  can be specified _after_ the list of files, but still affect the processing
#  of those files. Moreover, if the command-line parsing fails for some reason
#  (perhaps due to an unrecognized argument), the deferred processing will
#  not be performed.
args = Getopt::Declare.new( %q{

  	<files>...	Files to be processed
  			    { defer { files.each { |i| 
                                                   puts i, " ",$ordered } } }

  	-rev[erse]	Process in reverse order
  			    { $ordered = -1; }

  	-rand[om]	Process in random order
  			    { $ordered = 0; }
  	} )

