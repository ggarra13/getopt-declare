#!/usr/bin/env ruby

require "Getopt/Declare"

argspec = %q{
        [strict]
        --verbose		Print verbose info
        --			Traditional argument list terminator
                                                { finish }
}

args = Getopt::Declare.new(argspec)

p args
