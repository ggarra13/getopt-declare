#!/usr/bin/env ruby

require 'test/unit'
require "Getopt/Declare"

# to avoid getopt from exiting...
def exit(args)
end


class TC_Regex < Test::Unit::TestCase

  def setup
    @args = Getopt::Declare.new(<<'EOPARAM', :build)
-ar <r:n>	       		Set aspect ratio (will be clipped to [0..1] )
  				{
  				  r = 0 if r < 0
  				  r = 1 if r > 1
  				}
-w <pixels:+i>			Specify width in pixels
-h <pixels:+i>			Specify height in pixels
-list  <all:i>...		list of numbers
-range <from:i> [- [<to:i>] ]	opt. range
					{ to = 10 if to == 0 }
-parity <p:/even|odd|both/>	Set parity (<p> must be "even",
				"odd" or "both")
-file <name:/\w*\.[A-Z]{3}/>	File name must have a three-
				capital-letter extension
-find <what:/(%T.)+/> ;	        look ahead test
                              
EOPARAM


  end

  def test_ar
    @args.parse('-ar 1')
    assert_equal( 1.0, @args['-ar'] )
    @args.parse('-ar 0.4')
    assert_equal( 0.4, @args['-ar'] )
    @args.parse('-ar 15')
    assert_equal( 1.0, @args['-ar'] )
    @args.parse('-ar -15')
    assert_equal( 0.0, @args['-ar'] )
  end

  def test_w
    @args.parse('-w 512')
    assert_equal( 512, @args['-w'] )
    @args.parse('-w 0')
    assert_equal( nil, @args['-w'] )
  end
  
  def test_list
    @args.parse('-list 2 4 8 16 24 64')
    assert_equal( [2,4,8,16,24,64], @args['-list'] )
  end
  
  def test_parity_regex
    @args.parse('-parity even')
    assert_equal( 'even', @args['-parity'] )
    @args.parse('-parity odd')
    assert_equal( 'odd', @args['-parity'] )
    @args.parse('-parity both')
    assert_equal( 'both', @args['-parity'] )
  end
  
  def test_file_regex
    @args.parse('-file something.EXT')
    assert_equal( 'something.EXT', @args['-file'] )
    @args.parse('-file something.ext')
    assert_equal( nil, @args['-file'] )
  end

  def test_find_regex
    @args.parse('-find hello')
  end

end

