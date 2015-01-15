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

 unless ARGV.length == 2
	puts "\nCorrect usage: #{$0} hosts.txt domains.txt\n".foreground(:yellow).bright
 exit
 end
   
   hosts, domains = ARGV[0..1]       # declare runtime args
   
   File.open(ARGV[0], "r") do |h|    # open hosts file, read, and assign to h code block for iteration
      h.each_line do |hosts|         # call each_line method, & iterate thru file like an array
      host = hosts.chomp             # strip /n from array

   File.open(ARGV[1], "r") do |d|    # open domain file in read mode, and assign code block
      d.each_line do |domains|       # call each_line method, & iterate thru file like an array
      domain = domains.chomp         # strip /n from array

   x = domain                       
   y = "."                          
   z = `host #{host}#{y}#{x}`       
    puts "#{z}".foreground(:cyan).bright
   end
  end
 end
end
     