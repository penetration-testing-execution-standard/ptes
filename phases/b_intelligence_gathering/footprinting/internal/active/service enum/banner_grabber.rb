#!/usr/bin/env ruby
require 'rainbow/ext/string';require 'open-uri'
# Written by nanotechz9l


 unless ARGV.length == 2
  puts "\nMissing argument!".foreground(:red).bright.blink
  puts "\nPerforming banner grabs on multiple hosts is tedious. Netcat does not save the typed input like HEAD / HTTP/1.0, and HTTP/1.1 200 OK for http headers for example.".foreground(:yellow).bright
  puts "I can perform automated banner grabs on a given host. See example below!".foreground(:yellow).bright
  puts "\nUsage: ".foreground(:white).bright + "#{$0} yahoo.com 80".foreground(:white).bright
  exit
 end

 host,port = ARGV[0..1]


 puts "\nAttempting banner grab on:".foreground(:yellow).bright + " #{host}:#{port}\n".foreground(:cyan).bright
 puts "============================="
 system `nc -vv " #{host} #{port}" GET HEAD \n\n\n\n\n` #<< " #{host} #{port}"
 #system 'GET HEAD \n\n\n\n\n' << " #{host} #{port}"

 #puts "Generating http head request:".foreground(:yellow).bright
 #system 'HEAD / HTTP/1.0 \n\n\n\n\n'
 
 #puts "Returning 200 OK response:".foreground(:yellow).bright
 #system 'HTTP/1.1 200 OK \n\n\n\n\n'
 
 #puts "Enumerating enabled HTTP options:".foreground(:yellow).bright
 #system 'nc -vv Options / HTTP/1.0 \n\n\n\n\n' << " #{host} #{port}"
