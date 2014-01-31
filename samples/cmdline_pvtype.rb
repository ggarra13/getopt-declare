#!/usr/bin/env ruby

require "Getopt/Declare"

args = Getopt::Declare.new( <<'EOPARAM' )
	[pvtype: type  /AB|[OAB]/	                                ]
	[pvtype: Rh?   /Rh[+-]/					        ]
  	[pvtype: days  :+i  { 
                 reject( (_VAL_ < 14)," #{_PARAM_} (too soon!)" ) 
                            }
          ]

	  -donated <d:days>		  Days since last donation
	  -applied <a:days>		  Days since applied to donate

	  -blood <type:type> [<rh:Rh?>]	  Specify blood type
					  and (optionally) rhesus factor
EOPARAM

print args.inspect
