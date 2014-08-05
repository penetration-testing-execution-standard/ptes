#!/usr/bin/env ruby
require 'socket'; require 'rainbow/ext/string'

## [ SNMP word-list sweep by Rick Flores (@nanotechz9l) ]

unless ARGV.length == 1
			puts "Missing arguments. Also make sure your IP list has a single IP on each line (no empty or extra lines). Correct usage below:".foreground(:yellow).bright
			puts "#{$0} ip_list.txt\n".foreground(:white).bright
			exit
end

begin
			list = ARGV[0]                                 # assign list variable from file taken at runtime
			File.open(ARGV[0], "r") do |f|                 # open word list in read mode, and assign code block
			f.each_line do |lines|                         # call each_line method, & iterate thru file like an array
			system 'snmpwalk -c public -v1' << " #{lines}" # loop thru command on each ip in the file
		end
	end
end
