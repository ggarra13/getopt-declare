#!/usr/bin/env ruby

require "Getopt/Declare"

def encode(t)
    return Getopt::Declare.new(t,['-BUILD']).code
end

=begin
Just type in something, like:

=for Getopt::Declare

               -a              Append mode
=cut

=end

$/ = '=cut'
if t = $stdin.readline
  x = t.sub( /^=for\s+Getopt::Declare\s*\n(.*?)\n/esm ) { 
    '(self,source) = []'+encode("#$1") 
  }
  puts x
end


