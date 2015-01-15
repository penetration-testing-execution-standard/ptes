#!/usr/bin/env ruby
require 'socket'; require 'rainbow/ext/string'

## SMTP word-list user verification by Rick Flores (@nanotechz9l)]

unless ARGV.length == 2
				puts "Missing arguments. A worlist file with usernames named list.txt has to be present in the same directory as #{$0}. Correct usage below:".foreground(:yellow).bright
				puts "#{$0} 192.168.19.215 25.\n".foreground(:yellow).bright
				exit
end

begin
				ip, port = ARGV[0..1]                        # TO-DO : Need to add additional filename ARGV to get rid of hardcoded 
                                                             # file name 'list.txt' below.
				File.open('list.txt', "r") do |f|            # Open word list in read mode, and assign code block
				f.each_line do |lines|                       # Call each_line method, & iterate thru file like an array
				s = TCPSocket.new(ARGV[0], ARGV[1])          # Create socket, connect to server + ip given at runtime
				puts "server banner >> "+s.recv(10000)       # Receive banner
				s.puts 'VRFY ' + "#{lines}"                  # VRFY existing USER from each .txt file line
				result=s.recv(10000)                         # Receive result // << puts result=s.recv(10000) also works!
				puts "#{result}".foreground(:yellow).bright  # Print result
	#			s.close                                      # Close socket not needed. Files opened with each_line will automatically get closed as you leave the outer block.
		end
	end
end
