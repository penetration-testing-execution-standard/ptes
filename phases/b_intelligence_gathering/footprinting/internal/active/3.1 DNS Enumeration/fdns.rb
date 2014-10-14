#!/usr/bin/env ruby
# Koded by Rick Flores
require 'rainbow/ext/string'

puts "\nForward lookup brute force:".foreground(:yellow).bright
puts "============================="

def banner()
print """
The idea behind this technique is to try to guess valid names of organizational servers
by trying to resolve a given name. If the name resolves, the results might indicate
the presence and even functionality of the server. We can create a short (or long)
list of possible hostnames and loop the host command to try each one.

"""
end
banner()

 unless ARGV.length ==2
	puts "\nCorrect usage: #{$0} hostnames.txt xyz.com\n".foreground(:yellow).bright
 exit
 end
   
   file, domain = ARGV[0..1]       # declare runtime arguments
   File.open(ARGV[0], "r") do |x|  # open file, read, and assign to x code block for iteration
       x.each_line do |hostname|   # call each_line method, & iterate thru file like an array
       
       host = hostname.chomp       # strip /n from array
       x = ARGV[1]
       y = "."
       z = `host #{host}#{y}#{x}`
       puts "#{z}".foreground(:cyan).bright
   end
 end
     