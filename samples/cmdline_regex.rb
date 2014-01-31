#!/usr/bin/env ruby

require "Getopt/Declare"

specification = <<-'EOFPARAMS'
-ar <r:n>	       		Set aspect ratio (will be clipped to [0..1] )
  				{
  				  r = 0 if r < 0
  				  r = 1 if r > 1
  				}
-w <pixels:+i>			Specify width in pixels
-h <pixels:+i>			Specify height in pixels
-list  <all:i>...		list of numbers
-range <from:i> [- [<to:i>] ]	opt. range
					{ to = 10 if to == 0 }
-parity <p:/even|odd|both/>	Set parity (<p> must be "even",
				"odd" or "both")
-file <name:/\w*\.[A-Z]{3}/>	File name must have a three-
				capital-letter extension
-find <what:/(%T.)+/> ;	        look ahead test

EOFPARAMS


args = Getopt::Declare.new(specification)

print args.inspect
