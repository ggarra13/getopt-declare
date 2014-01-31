#!/usr/bin/env ruby

require 'test/unit'
require "Getopt/Declare"

def delold
  print "would have deleted\n"
end

class TC_Mid < Test::Unit::TestCase

  def setup
    @file = __FILE__
    @args = Getopt::Declare.new(<<'EOPARAM', :build)
		-a		Process all data
		-b <n:n>	Set mean byte length threshold to <N>
  					{ bytelen = n }
		+c <FILE>	Create new file <FILE>
		--del 		Delete old file
  					{ delold(); }
		delete 		[ditto]
		e <w:i>x<h:i>	Expand image to height <h> and width <w>
  					{ }
		-F <file>...	Process named file(s)
  					{ defer { file.each {|j| 
                                                  process(j) } } }
		=getrand [<n:i>]	Get a random number
				(or, optionally, <n> of them)
  					{ n = 1 unless n }
		--		Traditionally indicates end of arguments
  					{ finish }
EOPARAM
  end

  def test_getrand
    @args.parse('=getrand')
    assert_equal( 1, @args['=getrand'] )
    @args.parse('=getrand 15')
    assert_equal( 15, @args['=getrand'] )
  end

  def test_e
    @args.parse('e 320x480')
    assert_equal( 320, @args['e']['<w>'] )
    assert_equal( 480, @args['e']['<h>'] )
  end

  def test_delete
    @args.parse('--del')
    assert_equal( '--del', @args['--del'] )
    @args.parse('delete')
    assert_equal( 'delete', @args['--del'] )
  end

  def test_end
    @args.parse('--del =getrand -- 15 -a')
    assert_equal( nil, @args['-a'] )
    assert_equal( 1, @args['=getrand'] )
    assert_equal( '--del', @args['--del'] )
    assert_equal( ['15', '-a'], @args.unused )
  end

end

