#!/usr/bin/env ruby

require 'test/unit'
require "Getopt/Declare"

# to avoid getopt from exiting...
def exit(args)
end


class TC_PvType < Test::Unit::TestCase

  def setup
    @args = Getopt::Declare.new(<<'EOPARAM', :build)
	[pvtype: type  /AB|[OAB]/ ]
	[pvtype: Rh    /Rh[+-]/  ]
  	[pvtype: days  :+i  { 
                 reject( (_VAL_ < 14)," #{_PARAM_} (too soon!)" ) 
                            }
          ]
	  -donated <d:days>		  Days since last donation
	  -applied <a:days>		  Days since applied to donate

	  -blood <type:type> [<rh:Rh>]	  Specify blood type
					  and (optionally) rhesus factor
EOPARAM
  end

  def test_type
    ['AB', 'O', 'A', 'B'].each { |type|
        line = "-blood #{type}"
        @args.parse(line)
        assert_equal( type,  @args['-blood']['<type>'] )
    }
  end

  def test_applied
    @args.parse('-applied 15')
    assert_equal( 15,  @args['-applied'] )
  end

  def test_donated
    @args.parse('-donated 15')
    assert_equal( 15,  @args['-donated'] )
  end

  def test_rh
    ['AB', 'O', 'A', 'B'].each { |type|
      ['', 'Rh+','Rh-'].each { |rh|
        line = "-blood #{type} #{rh}"
        @args.parse(line)
        assert_equal( type,  @args['-blood']['<type>'] )
        assert_equal( rh,  @args['-blood']['<rh>'] )
      }
    }
  end
end

