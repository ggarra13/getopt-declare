#!/usr/bin/env ruby

require 'test/unit'
require "Getopt/Declare"

# to avoid getopt from exiting...
def exit(args)
end

$students = []
$absent   = []

class TC_CSV < Test::Unit::TestCase


  def setup
    @args = Getopt::Declare.new(<<'EOCSV', :build)
	<name:qs> , <id:+i> , <score:0+n>	STD FORMAT [repeatable]
		{ $students.push( {:name=>name, :id=>id, :score=>score} ) }

	<id:+i> , <name:qs> , <score:0+n>	VARIANT FORMAT [repeatable]
		{ $students.push( {:name=>name, :id=>id, :score=>score} ) }

	<name:qs> , <id:+i> , DNS		DID NOT SIT [repeatable]
		{ $absent.push(  {:name=>name, :id=>id, :score=>0} ) }

	<other:/.+/>				SOMETHING ELSE [repeatable]
                { puts "Unknown entry format: #{other}" }
EOCSV
  end

  @@data = <<'EODATA'
absmith,1234567,20
"aesmith, the other one",7635656,DNS
cat,dog,22.2
7637843,"dejones",66.7
rmwilliams,288721,88
help me,I'm trapped,in the marks system
vtthan,872829,94
EODATA

  #'
  def test_csv
    @args.parse(@@data)

    students = [
                ["absmith",1234567,20],
                ['"dejones"',7637843,66.7],
                ["rmwilliams",288721,88],
                ['vtthan',872829,94],
               ]

    assert_equal( students.size, $students.size )

    $students.each_with_index { |i, idx|
      assert_equal( students[idx][0], i[:name] )
      assert_equal( students[idx][1], i[:id] )
      assert_equal( students[idx][2], i[:score] )
    }

    absent = [
              ['"aesmith, the other one"',7635656],
             ]

    assert_equal( absent.size, $absent.size )

    $absent.each_with_index { |i, idx|
      assert_equal( absent[idx][0], i[:name] )
      assert_equal( absent[idx][1], i[:id] )
    }
  end


end

