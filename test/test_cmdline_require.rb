#!/usr/bin/env ruby
#
# Put script description here.
#
# Author::    
# Copyright:: 
# License::   Ruby
#

require 'Getopt/Declare'


require 'test/unit'
require "Getopt/Declare"

# to avoid getopt from exiting...
def exit(args)
end


class TC_Require < Test::Unit::TestCase

  def setup
    @args = Getopt::Declare.new(<<EOF, :build)
    [debug]
	-i <iterations:+i>	iteration count	
	-q	add new task [ requires: -i ]	
EOF
  end

  def test_q_without_i
    begin
      @args.parse('-q')
      assert_equal( nil, @args['-q'] )
    rescue
    end
  end

  def test_i_without_q
    begin
      @args.parse('-i 5')
    rescue
    end
    assert_equal( 5, @args['-i'] )
  end

  def test_i_with_q
    begin
      @args.parse('-i 5 -q')
    rescue
    end
    assert_equal( 5, @args['-i'] )
    assert_equal( '-q', @args['-q'] )
  end

end
