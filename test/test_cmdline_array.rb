#!/usr/bin/env ruby

require 'test/unit'
require "Getopt/Declare"


class TC_Array < Test::Unit::TestCase

  def setup
    @file = __FILE__
    @args = Getopt::Declare.new( <<EOF, :build )
  		-v <value:i> [etc]	One or more values
  		<infile:if>		Input file [required]
  		-o <outfiles:of>...	Output files
EOF
  end

  def test_infile
    @args.parse(@file)
    assert_equal( @file, @args['<infile>'] )
  end

  def test_v_val
    @args.parse("-v 20 #@file")
    assert_equal( 20, @args['-v']['<value>'] )
    assert_equal( @file, @args['<infile>'] )
  end

  def test_v_val_etc
    @args.parse("-v 20 etc #@file")
    assert_equal( 20, @args['-v']['<value>'] )
    assert_equal( 'etc', @args['-v']['etc'] )
    assert_equal( @file, @args['<infile>'] )
  end

  def test_o_single
    @args.parse("-v 20 etc #@file -o goodbye")
    assert_equal( ['goodbye'], @args['-o'] )
  end

  def test_o_multi
    @args.parse("-v 20 etc #@file -o abc goodbye other")
    assert_equal( ['abc', 'goodbye', 'other'], @args['-o'] )
  end

  def test_unused
    @args.parse("-v 20 etc #@file crapola -o abc goodbye other")
    assert_equal( ['abc', 'goodbye', 'other'], @args['-o'] )
    assert_equal( ['crapola'], @args.unused )
  end


end
