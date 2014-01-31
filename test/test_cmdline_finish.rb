#!/usr/bin/env ruby

require 'test/unit'
require "Getopt/Declare"


class TC_Finish < Test::Unit::TestCase

  def setup
    @args = Getopt::Declare.new(<<'EOPARAM', :build)
        --verbose		Print verbose info
        --			Traditional argument list terminator
                                                { finish }
EOPARAM
  end

  def test_verbose
    @args.parse("--verbose")
    assert_equal( '--verbose', @args['--verbose'] )
  end

  def test_terminator
    @args.parse("--verbose -- crapola")
    assert_equal( ['crapola'], @args.unused )
  end

end

