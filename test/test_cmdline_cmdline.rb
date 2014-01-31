#!/usr/bin/env ruby

require 'test/unit'
require "Getopt/Declare"

# to avoid getopt from exiting...
def exit(args)
end


class TC_CmdlineDemo < Test::Unit::TestCase

  def setup
    @args = Getopt::Declare.new(<<'EOPARAM', :build)
General options:
     -e <f:i>..<t:i>		Set expansion factor to specified range
                        [requires: <file>]
                                { puts "k = [#{f}..#{t}]" }

     -e [<k:n>...]		Set expansion factor to <k> (or 2 by default)
                        [required]
                                { k = [2] unless k
                                  print "k = [", k.join(','), "]\n"; }

	-b <blen:i>		Use byte length of <blen> 
                        [excludes: -a +c]
                                { print "byte len: #{blen}\n"; }

	<file>...		Process files [required] [implies: -a]
                                { print "files: #{file}\n"; }

	-a [<n:n>]		Process all data [except item <n>]
                            { print "proc all\n"; print "except #{n}\n" if n }

	-fab			The fabulous option (is always required :-)
                        [required]
                                { defer { print "fabulous!\n" } }

File creation options:

	+c <file>		Create file [mutex: +c -a]
                                { print "create: file\n"; }

	+d <file>		Duplicate file [implies: -a and -b 8]
                        	This is a second line
                                { print "dup (+d) #{file}\n"; }
	--dup <file>		[ditto] (long form)

	-how <n:i>		Set height to <n>       [repeatable]

Garbling options:

	-g [<seed:i>]		Garble output with optional seed [requires: +c]
                                { print "garbling with #{seed}\n"; }
	-i			Case insensitive garbling [required]
                                { print "insensitive\n"; }
	-s			Case sensitive garbling 
	-w			WaReZ m0De 6aRBL1N6 

	[mutex: -i -s -w] 
EOPARAM
  end


  def test_file
    @args.parse('-e 1.0 -i -fab file.txt')
    assert_equal( ['file.txt'], @args['<file>'] )
    assert_equal( '-fab', @args['-fab'] )
    assert_equal( [1.0], @args['-e'] )
    assert_equal( '-i', @args['-i'] )
  end

  def test_s
    @args.parse('-e 1.0 -s -fab file.txt')
    assert_equal( ['file.txt'], @args['<file>'] )
    assert_equal( '-fab', @args['-fab'] )
    assert_equal( [1.0], @args['-e'] )
    assert_equal( '-s', @args['-s'] )
  end

  def test_w
    @args.parse('-e 1.0 -w -fab file.txt')
    assert_equal( ['file.txt'], @args['<file>'] )
    assert_equal( '-fab', @args['-fab'] )
    assert_equal( [1.0], @args['-e'] )
    assert_equal( '-w', @args['-w'] )
  end


  def test_d
    @args.parse('+d nothing -e 1.0 -w -fab file.txt')
    assert_equal( ['file.txt'], @args['<file>'] )
    assert_equal( '-fab', @args['-fab'] )
    assert_equal( [1.0], @args['-e'] )
    assert_equal( '-w', @args['-w'] )
    assert_equal( 'nothing', @args['+d'] )
    assert_equal( nil, @args['--dup'] )
  end

  def test_dup
    @args.parse('--dup nothing -e 1.0 -w -fab file.txt')
    assert_equal( ['file.txt'], @args['<file>'] )
    assert_equal( '-fab', @args['-fab'] )
    assert_equal( [1.0], @args['-e'] )
    assert_equal( '-w', @args['-w'] )
    assert_equal( 'nothing', @args['+d'] )
    assert_equal( 'nothing', @args['--dup'] )
  end

  def test_how
    @args.parse('-how 2 -how 3 -e 1.0 -w -fab file.txt')
    assert_equal( ['file.txt'], @args['<file>'] )
    assert_equal( '-fab', @args['-fab'] )
    assert_equal( [1.0], @args['-e'] )
    assert_equal( '-w', @args['-w'] )
    assert_equal( 3, @args['-how'] )
  end

  def test_g
    @args.parse('+c something -g 20 -e 1.0 -w -fab file.txt')
    assert_equal( ['file.txt'], @args['<file>'] )
    assert_equal( '-fab', @args['-fab'] )
    assert_equal( [1.0], @args['-e'] )
    assert_equal( '-w', @args['-w'] )
    assert_equal( 20, @args['-g'] )
  end

  def test_e
    @args.parse('-e 2..4 -w -fab file.txt')
    assert_equal( ['file.txt'], @args['<file>'] )
    assert_equal( '-fab', @args['-fab'] )
    assert_equal( 2, @args['-e']['<f>'] )
    assert_equal( 4, @args['-e']['<t>'] )
    assert_equal( '-w', @args['-w'] )
  end


end

