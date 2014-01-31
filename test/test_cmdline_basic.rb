#!/usr/bin/env ruby

require 'test/unit'
require "Getopt/Declare"


class TC_Basic < Test::Unit::TestCase

  def setup
    @file = __FILE__
    @args = Getopt::Declare.new(<<'EOPARAM', :build)

   ============================================================
   Required parameter:

   -in <infile>		Input file [required]

   ------------------------------------------------------------

   Optional parameters:

   (The first two are mutually exclusive) [mutex: -r -p]

   -r[and[om]]		Output in random order
   -p[erm[ute]]		Output all permutations

   ---------------------------------------------------

   -out <outfile>	Optional output file

   ------------------------------------------------------------
   Note: this program is known to run very slowly of files with
   long individual lines.
   ============================================================
EOPARAM
  end

  def test_infile
    @args.parse("-in #@file")
    assert_equal( @args['-in'], @file )
  end

  def test_outfile
    @args.parse("-in #@file -out crapola")
    assert_equal( @args['-in'], @file )
    assert_equal( @args['-out'], 'crapola' )
  end

  def test_random
    @args.parse("-in #@file -random -out crapola")
    assert_equal( @args['-in'], @file )
    assert_equal( @args['-out'], 'crapola' )
    assert_equal( @args['-r']['and'], 'and' )
    assert_equal( @args['-r']['om'], 'om' )
  end

  def test_r
    @args.parse("-in #@file -r -out crapola")
    assert_equal( @args['-in'], @file )
    assert_equal( @args['-out'], 'crapola' )
    assert_not_equal( @args['-r'], nil )
  end

  def test_p
    @args.parse("-in #@file -p -out crapola")
    assert_equal( @args['-in'], @file )
    assert_equal( @args['-out'], 'crapola' )
    assert_not_equal( @args['-p'], nil )
  end

  def test_perm
    @args.parse("-in #@file -perm -out crapola")
    assert_equal( @args['-in'], @file )
    assert_equal( @args['-out'], 'crapola' )
    assert_equal( @args['-p']['erm'], 'erm' )
    assert_not_equal( @args['-p']['ute'], 'ute' )
  end

  def test_permute
    @args.parse("-in #@file -permute -out crapola")
    assert_equal( @args['-in'], @file )
    assert_equal( @args['-out'], 'crapola' )
    assert_equal( @args['-p']['erm'], 'erm' )
    assert_equal( @args['-p']['ute'], 'ute' )
  end

  def test_mutex
    #     @args.parse("-in #@file -r -permute -out crapola")
  end

end

