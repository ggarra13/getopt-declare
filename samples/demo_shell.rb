#!/bin/env ruby


require "Getopt/Declare"

shell_cmds = <<'EOCMDS';
Commands: [repeatable]

	echo [-n] <words:/.*/>	ECHO WITHOUT NEWLINE 
			{ print words; print "\n" unless _PUNCT_['-n'] }

	[pvtype: chwho /u?g?a?/]
	[pvtype: chwhat /r?w?x?/]

	chmod [-R] <who:chwho>=<what:chwhat> <files>...	
				CHANGE FILE PERMISSIONS 
                        { files.each { |i| print "chmod who=what #{i}\n" }
			}

	help			SHOW THIS SUMMARY 
			{ self.usage() }

	exit			EXIT SHELL 
			{ finish(1) }

	<error:/.*/>	 
			{ print "Unknown command: error\n";
			  print "(Try the 'help' command?)\n"; }
EOCMDS

shell = Getopt::Declare.new(shell_cmds,['-BUILD'])

# Pass a proc
count = 1
pt = proc {  print "#{count}> "; count += 1; return $stdin.readline }

shell.parse(pt)
