#!/usr/bin/env ruby

require 'test/unit'
require "Getopt/Declare"

# to avoid getopt from exiting...
def exit(args)
end


class TC_Parameters < Test::Unit::TestCase

  def setup
    @args = Getopt::Declare.new(<<'EOPARAM', :build)
        -list <l>...				ttt
        -out <out>				ttt
	in=<infile>				ttt
	+range <from> [..] <to>			ttt
	--lines <start> - <stop>        	ttt
	ignore bad lines			ttt
	<outfile>				ttt
	-copy <files>... <dir>			copy files to dir
	-range <from:i> [[..] [<to:i>] ]	opt. range
					{ to = 10 if to == 0 } 
        -pattern <regex>                        match a pattern
EOPARAM
  end

  def test_regex
    @args.parse("-pattern abc")
    assert_equal( 'abc', @args['-pattern'] )

    @args.parse("-pattern .*")
    assert_equal( '.*', @args['-pattern'] )

    @args.parse("-pattern abc[a-z]")
    assert_equal( 'abc[a-z]', @args['-pattern'] )

    @args.parse("-pattern abc[a-z]+")
    assert_equal( 'abc[a-z]+', @args['-pattern'] )

    @args.parse("-pattern abc[a-z]+dsa")
    assert_equal( 'abc[a-z]+dsa', @args['-pattern'] )

    @args.parse("-pattern abc[a-z]+.*")
    assert_equal( 'abc[a-z]+.*', @args['-pattern'] )
  end

  def test_list
    @args.parse('-list 1 2 3 4')
    assert_equal( ['1','2','3','4'], @args['-list'] )
  end

  def test_in
    @args.parse('in=hello')
    assert_equal( 'hello', @args['in='] )
  end

  def test_plus_range
    @args.parse('+range 1 20')
    assert_equal( '1', @args['+range']['<from>'] )
    assert_equal( '20', @args['+range']['<to>'] )
    @args.parse('+range ABC .. ZZZ')
    assert_equal( 'ABC', @args['+range']['<from>'] )
    assert_equal( 'ZZZ', @args['+range']['<to>'] )
  end

  def test_lines
    @args.parse('--lines 1 - 20')
    assert_equal( '1', @args['--lines']['<start>'] )
    assert_equal( '20', @args['--lines']['<stop>'] )
# Hmm... should this work?
#     @args.parse('--lines 1-20')
#     assert_equal( '1', @args['--lines']['<start>'] )
#     assert_equal( '20', @args['--lines']['<stop>'] )
  end

  def test_range_minus
    @args.parse('-range 1 .. 20')
    assert_equal( 1, @args['-range']['<from>'] )
    assert_equal( 20, @args['-range']['<to>'] )
    @args.parse('-range 1..20')
    assert_equal( 1, @args['-range']['<from>'] )
    assert_equal( 20, @args['-range']['<to>'] )
    @args.parse('-range 1 20')
    assert_equal( 1, @args['-range']['<from>'] )
    assert_equal( 20, @args['-range']['<to>'] )
    @args.parse('-range 1')
    assert_equal( 1, @args['-range']['<from>'] )
    assert_equal( 10, @args['-range']['<to>'] )
    @args.parse('-range 1..')
    assert_equal( 1, @args['-range']['<from>'] )
    assert_equal( 10, @args['-range']['<to>'] )
  end

  def test_copy
    @args.parse('-copy fileA dest')
    assert_equal( ['fileA'], @args['-copy']['<files>'] )
    assert_equal( 'dest', @args['-copy']['<dir>'] )
  end

  def test_ignore_bad_lines
    @args.parse('ignore bad lines')
    assert_not_equal( nil, @args['ignore'] )
  end

end

