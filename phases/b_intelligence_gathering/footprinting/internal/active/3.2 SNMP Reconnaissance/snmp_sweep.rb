#!/usr/bin/env ruby
require 'rainbow/ext/string'

## SNMP automatic enumeration script by Rick Flores (@nanotechz9l)]
#  The IP gen code from line:13..line:66 was taken from wicked cool ruby scripts pg. 36 by Steve Pugh!

# Create community file
	puts "\n[+] Creating community file (public, private, manager) to start SNMP enumeration on ip range below.".foreground(:cyan).bright
	system 'echo public > community'
	system 'echo private >> community'
	system 'echo manager >> community'
	puts "[+] community file created...\n".foreground(:yellow).bright

	class IP
			def initialize(ip)
					@ip = ip
			end
  
			def to_s
					@ip
			end
  
			def==(other)
					to_s==other.to_s
			end

			def succ 
					return @ip if @ip == "255.255.255.255"
					parts = @ip.split('.').reverse
					parts.each_with_index do |part,i|
							if part.to_i < 255
									part.succ!
									break
							elseif part == "255"
									part.replace("0") unless i == 3
							else
									raise ArgumentError, "Invalid number #{part} in IP address"
							end      
					end

					parts.reverse.join('.')
			end
  
			def succ!
					@ip.replace(succ)
			end
	end

	# Ask user for two IP Addresses :::
	print "[+] Enter starting IP address. ".foreground(:cyan).bright
	print "Example: 192.168.19.0   >> ".foreground(:cyan).bright
	start_ip = STDIN.gets.chomp()

	print "[+] Enter ending IP address. ".foreground(:cyan).bright
	print "  Example: 192.168.19.255 >> ".foreground(:cyan).bright
	end_ip = STDIN.gets.chomp()

	# New IP object is created using the defined IP class called "i" :::
	i = IP.new(start_ip)

	# Final step before generating the IP's is to initialize the file that will be written to named "ofile"
	ofile = File.open("range", "w")

	# For each item returned, the reZults will be >> to "ofile" using the class method "succ!", an "until" loop calls the "succ!"
	# method until "i" = end_ip
	ofile.puts i.succ! until i == end_ip
	ofile.close # End of code from wicked cool ruby scripts pg. 36 by Steve Pugh!

	puts "[+] range file containing above ip range created...".foreground(:yellow).bright

	# Check for community strings on given IP's
	puts "\n[+] Using newly created files to check 3 community strings (public, private, manager) on given ip range.".foreground(:yellow).bright
	system 'onesixtyone -c community -i range -o results'
	puts "[+] snmp community check is complete...\n".foreground(:yellow).bright

	# Once SNMP services are found, we can start querying them for specific MIB data that might be interesting
	system 'cat results | cut -d " " -f 1 >> parsed_results'
	
	puts "[+] Reading parsed results file to begin snmp checks.".foreground(:yellow).bright
		File.open('parsed_results', "r") do |v|           # Open word list in read mode, and assign code block
		v.each_line do |lines|                       # Call each_line method, & iterate thru file like an array

	## For each ip in the results file we perform the following snmp enumeration checks.
#	puts "[+] \nEnumerating entire MIB tree.".foreground(:yellow).bright
#	system 'snmpwalk -c public -v1 ' << "#{lines}"

	puts "\n[+] Enumerating windows users.".foreground(:yellow).bright
	system 'snmpwalk -c public -v1 ' << "#{lines}" + '1.3.6.1.4.1.77.1.2.25'

#	puts "\n[+] Enumerating running windows processes.".foreground(:yellow).bright
#	system 'snmpwalk -c public -v1 ' << "#{lines}" + '1.3.6.1.2.1.25.4.2.1.2'

#	puts "\n[+] Enumerating open tcp ports.".foreground(:yellow).bright
#	system 'snmpwalk -c public -v1 ' << "#{lines}" + '1.3.6.1.2.1.6.13.1.3'

#	puts "\n[+] Enumerating installed software.".foreground(:yellow).bright
#	system 'snmpwalk -c public -v1 ' << "#{lines}" + '1.3.6.1.2.1.25.6.3.1.2'
	end
end
