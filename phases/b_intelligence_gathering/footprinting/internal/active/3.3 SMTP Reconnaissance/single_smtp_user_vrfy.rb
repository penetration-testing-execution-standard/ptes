#!/usr/bin/env ruby
require 'socket'; require 'rainbow'


unless ARGV.length == 3
				puts "\n[SMTP single user verification by Rick Flores (@nanotechz9l)]".foreground(:cyan).bright
				puts "Missing arguments. Correct useage below:\n".foreground(:yellow).bright
				puts "#{$0} 192.168.19.215 25 user".foreground(:yellow).bright
				exit
end

				ip, port, user = ARGV[0..2]

begin
				s = TCPSocket.new(ARGV[0],ARGV[1]) # Create socket, connect to server + ip
				print ">> "+s.recv(10000)          # Receive banner
				s.puts 'VRFY ' + ARGV[2]           # VRFY existing USER
				print ">> "+result=s.recv(10000)   # Receive result
				print ">> "+result                 # Print result
				s.close                            # Close socket
end
