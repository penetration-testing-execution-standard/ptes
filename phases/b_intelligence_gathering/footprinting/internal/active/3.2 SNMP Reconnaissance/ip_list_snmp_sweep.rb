#!/usr/bin/env ruby
require 'socket'; require 'rainbow/ext/string'

## [ SNMP word-list sweep by Rick Flores (@nanotechz9l) ]

unless ARGV.length == 1
			puts "Missing arguments. Also make sure your IP list has a single IP on each line (no empty or extra lines). Correct usage below:".foreground(:yellow).bright
			puts "\n#{$0} ip_list.txt\n".foreground(:white).bright
			exit
end

#users = "1.3.6.1.4.1.77.1.2.25".to_s


begin
			list = ARGV[0]                                 # assign list variable from file taken at runtime
			File.open(ARGV[0], "r") do |f|                 # open word list in read mode, and assign code block
			f.each_line do |lines|                         # call each_line method, & iterate thru file like an array
			  
			puts "\n[+] Enumerating entire MIB tree.".foreground(:yellow).bright
			system 'snmpwalk -c public -v1' << " #{lines}"                                  # enumerate entire MIB tree
			
			puts "\n[+] Enumerating windows users.".foreground(:yellow).bright
			#system 'snmpwalk -c public -v1' << " #{lines}"        # enumerate windows users

			#puts "\n[+] Enumerating running windows processes.".foreground(:yellow).bright
			#system 'snmpwalk -c public -v1' << " #{lines}" + '1.3.6.1.2.1.25.4.2.1.2'       # enumerate running windows processes
			
			#puts "\n[+] Enumerating open tcp ports.".foreground(:yellow).bright
			#system 'snmpwalk -c public -v1' << " #{lines}" + '1.3.6.1.2.1.6.13.1.3'         # enumerate open TCP ports
			
			#puts "\n[+] Enumerating installed software.".foreground(:yellow).bright
			#system 'snmpwalk -c public -v1' << " #{lines}" + '1.3.6.1.2.1.25.6.3.1.2'       # enumerate installed software

		end
	end
end
