#!/usr/bin/env ruby

require "Getopt/Declare"


@interpolator = Getopt::Declare.new(<<'EOCMDS',['-BUILD'])
	[cluster:none]
	[repeatable]
	[pvtype: NOTDELIM /(?:%T.)+/ ]
	[pvtype: WS   /\s+/ ]

        \{{ <cmd:NOTDELIM> }}[<ws:WS>]	
			{
  print "cmd=",cmd,"\n"
                          self['result'] += (eval cmd||'').to_s
			  self['result'] += ws if ws
                        }

	<str>[<ws:WS>]	
			{ self['result'] = '' unless self['result']
			  self['result'] += str
			  self['result'] += ws if ws }
EOCMDS

def interpolate(t)
  @interpolator['result'] = ''
  @interpolator.parse(t)
  return @interpolator['result']
end


$result = 22
$name = "Sam"
$n = 50

def average(t)
  sum, count = [0,0]
  t.each { |i| sum += i; count += 1; }
  return count ? sum/count : 0;
end

print interpolate('The person {{$name}} scored {{$result}}'), "\n";
print interpolate('The pass mark was {{$result * 2}}'), "\n";
print interpolate('The average of the first {{2*$n}} numbers is {{average(1..2*$n)}}'), "\n";
