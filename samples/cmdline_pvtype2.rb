#!/usr/bin/env ruby

require "Getopt/Declare"

specification = %q(
     [strict]     
     [pvtype: num      /\d+/    { reject if Time.new.localtime.day==3 }  ]
     [pvtype: 'a num'  :n       { puts "a num!"  }               ]
     [pvtype: %q{nbr}  :'a num' { reject $no_nbr }               ]

		   -count1 <n:num>		  test
		   -count2 <n:a num>		  test2
		   -count3 <n:nbr>		  test3

     )

args = Getopt::Declare.new(specification)

print args.inspect

