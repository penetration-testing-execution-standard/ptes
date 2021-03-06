#!/usr/bin/env ruby
require 'rainbow/ext/string'

# zone-xsfr ref: http://stackoverflow.com/questions/19416968/attempting-zone-transfer-with-ruby << thx Tin Man!

puts "\nI return ip addresses, dns name servers, and configured mail servers.".foreground(:yellow).bright
puts "I also attempt a dns zone transfer on all discovered dns name servers.".foreground(:yellow).bright
puts "To start enter the domain below. Example: rotten.com".foreground(:yellow).bright
prompt  = "\nTarget domain name:~$ ".foreground(:cyan).bright

print prompt
domain  = STDIN.gets.chomp()

## IP ADDRESS
puts "\n Address/es:".foreground(:yellow).bright
puts "============================="
	system 'dig +short' << " #{domain}"

## NAME SERVERS
puts "\nDomain Name Server/s:".foreground(:yellow).bright
puts "============================="
system 'dig +short NS' << " #{domain}"

## MAIL SERVERS
puts "\nMail (MX) Server/s:".foreground(:yellow).bright
puts "============================="
system 'dig +short MX' << " #{domain}"

## FORWARD LOOKUP BRUTE FORCE
puts "\nForward lookup brute force:".foreground(:yellow).bright
puts "============================="
# The idea behind this technique is to try to guess valid names of organizational servers 
# by trying to resolve a given name. If the name resolves, the results might indicate 
# the presence and even functionality of the server. We can create a short (or long) 
# list of possible hostnames and loop the host command to try each one.
	
	# system("for ip in $(cat hosts.txt);do host $ip.#{domain};done ") # <- Works! I need to speed this up, maybe multi-threading!
	#system 'for name in $(cat hosts.txt); do host $name.google.com;done' # works but its hardcoded + slow!
  #%x{for ip in $(cat hosts.txt);do host$ip.#{domain};done} # works but doesnt work!
  
#	File.open("hosts.txt", "r") do |f|
#		f.each_line do |line|                                                <- Figure this out, it should be faster than the above way!
#				list = line
#				for names in "#{list}" do system 'host' << " #{names}.#{domain}"
#				`host #{line}.#{domain}`.each_line do |k|
#				puts k
#			end            
#		end
#	end

## REVERSE LOOKUP BRUTE FORCE
puts "\nReverse lookup brute force:".foreground(:yellow).bright
puts "============================="
full_host = `dig +short #{domain}` # returns 64.79.129.102
	slash = full_host.chop.chop.chop.chop.chop # removes the 4th octet plus trailing period + needs refactoring!!
	#for ip in (0..255) do system 'dig +short -x' << " #{slash}.#{ip}" # (+short) Provide a short answer. The default is to print the answer in a verbose form.
	for ip in (0..255) do system 'host' << " #{slash}.#{ip}"
end

## ZONE TRANSFER
puts "\nZone Transfer:".foreground(:yellow).bright
puts "============================="
	nameserver = `dig +short NS #{domain}`
	`host -l #{domain} #{nameserver}`.each_line do |l|
	puts l
end
