#!/usr/bin/env ruby

require 'test/unit'
require "Getopt/Declare"

# to avoid getopt from exiting...
def exit(args)
end


class TC_PvType2 < Test::Unit::TestCase

  def setup
    @args = Getopt::Declare.new(<<'EOPARAM', :build)
     [strict]
     [pvtype: num      /\d+/    ]
     [pvtype: 'a num'  :n       { puts "a num!"  }               ]
     [pvtype: %q{nbr}  :'a num' ]

		   -count1 <n:num>		  test
		   -count2 <n:a num>		  test2
		   -count3 <n:nbr>		  test3
EOPARAM
  end

  def test_count1
    @args.parse('-count1 20')
    assert_equal( '20', @args['-count1'] )
  end

  def test_count2
    @args.parse('-count2 20')
    assert_equal( 20, @args['-count2'] )
  end

  # @todo: this should really be 20, not '20'
  def test_count3
    @args.parse('-count3 20')
    assert_equal( '20', @args['-count3'] )
  end
end

