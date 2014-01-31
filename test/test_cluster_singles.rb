#!/usr/bin/env ruby

require 'test/unit'
require "Getopt/Declare"

# to avoid getopt from exiting...
def exit(args)
end


class TC_ClusterSingle < Test::Unit::TestCase

  def setup
    @args = Getopt::Declare.new(<<'EOPARAM', :build)
  		-a		Append mode
  		-b		Back-up mode
  		-bu		[ditto]
  		-c <file>	Copy mode
  		-d [<file>]	Delete mode
  		-e[xec]		Execute mode

  		[cluster:singles]
EOPARAM
  end


  def test_normal
    @args.parse('-a -b')
    assert_equal( '-a', @args['-a'] )
    assert_equal( '-b', @args['-b'] )
  end

  def test_cluster_ab
    @args.parse('-ab')
    assert_equal( '-a', @args['-a'] )
    assert_equal( '-b', @args['-b'] )
  end

  def test_cluster_ba
    @args.parse('-ba')
    assert_equal( '-a', @args['-a'] )
    assert_equal( '-b', @args['-b'] )
  end

  def test_bu
    @args.parse('-bu')
    assert_equal( '-bu', @args['-b'] )
    assert_equal( '-bu', @args['-bu'] )
  end

  def test_cluster_abu
    @args.parse('-abu')
    assert_equal( '-a', @args['-a'] )
    assert_equal( '-b', @args['-b'] )
    assert_equal( ['u'], @args.unused )
  end

end

