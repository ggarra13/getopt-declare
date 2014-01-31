#!/bin/env ruby

require "Getopt/Declare"

#  In the next example, only the <tt>-a</tt> and <tt>-b</tt> parameters may be clustered.
#  The <tt>-bu</tt> parameter is excluded because it consists of more than one
#  letter, whilst the <tt>-c</tt> and <tt>-d</tt> parameters are excluded because they
#  take (or may take, in <tt>-d</tt>'s case) a variable. The <tt>-e[xec]</tt> parameter
#  is excluded because it may take a trailing punctuator (<tt>[xec]</tt>).
#
#  By comparison, if the directive had been <tt>[cluster: flags]</tt>, then
#  <tt>-bu</tt> _could_ be clustered, though <tt>-c</tt>, <tt>-d</tt> and <tt>-e[xec]</tt> would
#  still be excluded since they are not "pure flags").
#

args = Getopt::Declare.new( <<-'EOSPEC' )

  		-a		Append mode
  		-b		Back-up mode
  		-bu		[ditto]
  		-c <file>	Copy mode
  		-d [<file>]	Delete mode
  		-e[xec]		Execute mode

  		[cluster:singles]
EOSPEC

print args.inspect
