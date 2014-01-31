#!/usr/bin/env ruby


require "Getopt/Declare"


spec = Getopt::Declare.new <<EOF
	-i <iterations:+i>	iteration count	
	-q	add new task [requires: -i]	
EOF

