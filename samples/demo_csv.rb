#!/usr/bin/env ruby

require "Getopt/Declare"

args = Getopt::Declare.new( <<EOARGS )
	-f <filename:if>	Parse file <filename>
EOARGS

$students = []
$absent = []

data = %q{
	absmith,1234567,20
	"aesmith, the other one",7635656,DNS
	cat,dog,22.2
	7637843,dejones,66.7
	rmwilliams,288721,88
	help me,I'm trapped,in the marks system
	vtthan,872829,94
}


csv = <<'EOCSV'
	<name:qs> , <id:+i> , <score:0+n>	STD FORMAT [repeatable]
		{ $students.push( {:name=>name, :id=>id, :score=>score} ) }

	<id:+i> , <name:qs> , <score:0+n>	VARIANT FORMAT [repeatable]
		{ $students.push( {:name=>name, :id=>id, :score=>score} ) }

	<name:qs> , <id:+i> , DNS		DID NOT SIT [repeatable]
		{ $absent.push(  {:name=>name, :id=>id, :score=>0} ) }

	<other:/.+/>				SOMETHING ELSE [repeatable]
                { print "Unknown entry format: [#{other}]\n"; }
EOCSV

if args["-f"]
	args =  Getopt::Declare.new(csv,[args["-f"]])
else
	args = Getopt::Declare.new(csv,data)
end

$students.each { |i|
  print "student:#{i[:id]} (#{i[:name]}): #{i[:score]}.\n"
}

$absent.each { |i|
  print "#{i[:id]} => #{i[:name]}:   ABSENT\n"
}
